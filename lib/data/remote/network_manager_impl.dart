import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:to_do/domain/models/task.dart';
import 'package:to_do/utils/logger.dart';

import 'network_manager.dart';

class NetworkManagerImpl implements NetworkManager {
  static const _baseUrl = String.fromEnvironment('url');
  static const _token = String.fromEnvironment('token');

  Map<String, String> _getHeaders(int revision) {
    return {
      'Authorization': 'Bearer $_token',
      'X-Last-Known-Revision': '$revision',
      'Content-Type': 'application/json',
    };
  }

  @override
  Future<List<Task>> getTasks() async {
    List<Task> tasks = [];
    final uri = Uri.parse('$_baseUrl/list');
    final response = await http.get(uri, headers: _getHeaders(-1));
    if (response.statusCode == 200) {
      final data =
          jsonDecode(const Utf8Decoder().convert(response.body.codeUnits));
      for (int i = 0; i < data['list'].length; i++) {
        tasks.add(Task.fromJson(data['list'][i]));
      }
    } else {
      logger.e('${response.statusCode}: ${response.body}');
    }
    return tasks;
  }

  @override
  Future<int> updateTasks(List<Task> tasks, int revision) async {
    final uri = Uri.parse('$_baseUrl/list');
    List<Map<String, dynamic>> list = [];
    for (int i = 0; i < tasks.length; i++) {
      final taskJson = await tasks[i].toJson(tasks[i]);
      list.add(taskJson);
    }
    Map<String, dynamic> body = {'list': list};
    final response = await http.patch(
      uri,
      headers: _getHeaders(revision),
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      final data =
          jsonDecode(const Utf8Decoder().convert(response.body.codeUnits));
      return data['revision'];
    } else {
      logger.e('${response.statusCode}: ${response.body}');
      return -1;
    }
  }

  @override
  Future<Task?> getTask(int taskId, int revision) async {
    final uri = Uri.parse('$_baseUrl/list/$taskId');
    final response = await http.get(uri, headers: _getHeaders(revision));
    if (response.statusCode == 200) {
      final data =
          jsonDecode(const Utf8Decoder().convert(response.body.codeUnits));
      return Task.fromJson(data['element']);
    } else {
      logger.e('${response.statusCode}: ${response.body}');
      return null;
    }
  }

  @override
  Future<int> addTask(Task task, int revision) async {
    final uri = Uri.parse('$_baseUrl/list');
    final body = await task.toJson(task);
    final response = await http.post(
      uri,
      headers: _getHeaders(revision),
      body: jsonEncode({'element': body}),
    );
    if (response.statusCode == 200) {
      final data =
          jsonDecode(const Utf8Decoder().convert(response.body.codeUnits));
      return data['revision'];
    } else {
      logger.e('${response.statusCode}: ${response.body}');
      return -1;
    }
  }

  @override
  Future<int> changeTask(Task task, int revision) async {
    final uri = Uri.parse('$_baseUrl/list/${task.id}');
    final body = await task.toJson(task);
    final response = await http.put(
      uri,
      headers: _getHeaders(revision),
      body: jsonEncode({'element': body}),
    );
    if (response.statusCode == 200) {
      final data =
          jsonDecode(const Utf8Decoder().convert(response.body.codeUnits));
      return data['revision'];
    } else {
      logger.e('${response.statusCode}: ${response.body}');
      return -1;
    }
  }

  @override
  Future<int> removeTask(String taskId, int revision) async {
    final uri = Uri.parse('$_baseUrl/list/$taskId');
    final response = await http.delete(
      uri,
      headers: _getHeaders(revision),
    );
    if (response.statusCode == 200) {
      final data =
          jsonDecode(const Utf8Decoder().convert(response.body.codeUnits));
      return data['revision'];
    } else {
      logger.e('${response.statusCode}: ${response.body}');
      return -1;
    }
  }

  @override
  Future<int> getRevision() async {
    final uri = Uri.parse('$_baseUrl/list');
    final response = await http.get(uri, headers: _getHeaders(-1));
    if (response.statusCode == 200) {
      final data =
          jsonDecode(const Utf8Decoder().convert(response.body.codeUnits));
      return data['revision'];
    } else {
      logger.e('${response.statusCode}: ${response.body}');
      return -1;
    }
  }
}
