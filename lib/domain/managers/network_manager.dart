import 'dart:convert';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:http/http.dart' as http;
import 'package:to_do/domain/managers/persistence_manager.dart';

import 'package:to_do/domain/models/task.dart';
import 'package:to_do/utils/logger.dart';

class NetworkManager {
  int revision = 0;

  static const _baseUrl = String.fromEnvironment('url');

  Map<String, String> getHeaders() {
    return {
      'Authorization': 'Bearer ${const String.fromEnvironment('token')}',
      'X-Last-Known-Revision': '$revision',
    };
  }

  Future<List<Task>> getTasks() async {
    List<Task> tasks = [];
    final uri = Uri.parse('$_baseUrl/list');
    final response = await http.get(uri, headers: getHeaders());
    if (response.statusCode == 200) {
      final data =
          jsonDecode(const Utf8Decoder().convert(response.body.codeUnits));
      for (int i = 0; i < data['list'].length; i++) {
        tasks.add(fromJson(data['list'][i]));
      }
      setRevision(data['revision']);
      return tasks;
    } else {
      final PersistenceManager manager = PersistenceManager();
      tasks = await manager.getTasks();
      logger.e('${response.statusCode}: ${response.body}');
      return tasks;
    }
  }

  //Не протестил эту функцию, прошу не судить строго, она пока не вызывалась ни при одном случае
  Future<void> updateTasks(List<Task> tasks) async {
    final uri = Uri.parse('$_baseUrl/list');
    List<Map<String, dynamic>> list = [];
    for (int i = 0; i < tasks.length; i++) {
      final taskJson = await toJson(tasks[i]);
      list.add(taskJson);
    }
    Map<String, dynamic> body = {'list': list};
    logger.d(body);
    final response = await http.patch(
      uri,
      headers: getHeaders(),
      body: body,
    );
    if (response.statusCode == 200) {
      final data =
          jsonDecode(const Utf8Decoder().convert(response.body.codeUnits));
      setRevision(data['revision']);
    } else {
      logger.e('${response.statusCode}: ${response.body}');
    }
  }

  Future<Task?> getTask(int taskId) async {
    final uri = Uri.parse('$_baseUrl/list/$taskId');
    final response = await http.get(uri, headers: getHeaders());
    if (response.statusCode == 200) {
      final data =
          jsonDecode(const Utf8Decoder().convert(response.body.codeUnits));
      setRevision(data['revision']);
      return fromJson(data['element']);
    } else {
      logger.e('${response.statusCode}: ${response.body}');
      return null;
    }
  }

  Future<void> addTask(Task task) async {
    final uri = Uri.parse('$_baseUrl/list');
    final body = await toJson(task);
    final response = await http.post(
      uri,
      headers: getHeaders(),
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      final data =
          jsonDecode(const Utf8Decoder().convert(response.body.codeUnits));
      setRevision(data['revision']);
    } else {
      logger.e('${response.statusCode}: ${response.body}');
    }
  }

  Future<void> changeTask(Task task) async {
    final uri = Uri.parse('$_baseUrl/list/${task.id}');
    final body = await toJson(task);
    final response = await http.put(
      uri,
      headers: getHeaders(),
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      final data =
          jsonDecode(const Utf8Decoder().convert(response.body.codeUnits));
      setRevision(data['revision']);
    } else {
      logger.e('${response.statusCode}: ${response.body}');
    }
  }

  Future<void> removeTask(int taskId) async {
    final uri = Uri.parse('$_baseUrl/list/$taskId');
    final response = await http.delete(
      uri,
      headers: getHeaders(),
    );
    if (response.statusCode == 200) {
      final data =
          jsonDecode(const Utf8Decoder().convert(response.body.codeUnits));
      setRevision(data['revision']);
    } else {
      logger.e('${response.statusCode}: ${response.body}');
    }
  }

  void setRevision(int version) async {
    final PersistenceManager persistenceManager = PersistenceManager();
    if (version == revision) {
      return;
    }
    if (version > revision) {
      getTasks().then((value) => persistenceManager.setTasks(value));
      revision = version;
    } else {
      persistenceManager.getTasks().then((tasks) => updateTasks(tasks));
    }
  }

  Task fromJson(Map<String, dynamic> data) {
    final Priority imp;
    if (data['importance'] == 'basic') {
      imp = Priority.basic;
    } else if (data['importance'] == 'low') {
      imp = Priority.low;
    } else {
      imp = Priority.important;
    }
    return Task(
      id: int.parse(data['id']),
      title: data['text'],
      importance: imp,
      deadline: data['deadline'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(data['deadline'] * 1000),
      isCompleted: data['done'],
    );
  }

  Future<Map<String, dynamic>> toJson(Task task) async {
    String deviceId = await getDeviceId() ?? '';
    String imp;
    if (task.importance == Priority.basic) {
      imp = 'basic';
    } else if (task.importance == Priority.important) {
      imp = 'important';
    } else {
      imp = 'low';
    }
    Map<String, dynamic> data = {
      'element': {
        'id': '${task.id}',
        'text': task.title,
        'importance': imp,
        'deadline': task.deadline == null
            ? null
            : task.deadline!.millisecondsSinceEpoch ~/ 1000,
        'done': task.isCompleted,
        'created_at': DateTime.now().millisecondsSinceEpoch ~/ 1000,
        'changed_at': DateTime.now().millisecondsSinceEpoch ~/ 1000,
        'last_updated_by': deviceId,
      }
    };
    return data;
  }

  Future<String?> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String? deviceId;

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.androidId;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor;
    }

    return deviceId;
  }
}
