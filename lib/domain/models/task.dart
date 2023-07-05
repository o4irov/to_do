import '../../utils/device_id.dart';

class Task {
  String id;
  String title;
  bool isCompleted;
  Priority importance;
  DateTime? deadline;

  Task({
    required this.id,
    required this.title,
    this.importance = Priority.basic,
    this.deadline,
    this.isCompleted = false,
  });

  factory Task.fromJson(Map<String, dynamic> data) {
    final Priority imp;
    if (data['importance'] == 'basic') {
      imp = Priority.basic;
    } else if (data['importance'] == 'low') {
      imp = Priority.low;
    } else {
      imp = Priority.important;
    }
    return Task(
      id: data['id'],
      title: data['text'],
      importance: imp,
      deadline: data['deadline'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(data['deadline'] * 1000),
      isCompleted: data['done'],
    );
  }

  Future<Map<String, dynamic>> toJson(Task task) async {
    String deviceId = await DeviceId().deviceId;
    String imp;
    if (task.importance == Priority.basic) {
      imp = 'basic';
    } else if (task.importance == Priority.important) {
      imp = 'important';
    } else {
      imp = 'low';
    }
    Map<String, dynamic> data = {
      'id': task.id,
      'text': task.title,
      'importance': imp,
      'deadline': task.deadline == null
          ? null
          : task.deadline!.millisecondsSinceEpoch ~/ 1000,
      'done': task.isCompleted,
      'created_at': DateTime.now().millisecondsSinceEpoch ~/ 1000,
      'changed_at': DateTime.now().millisecondsSinceEpoch ~/ 1000,
      'last_updated_by': deviceId,
    };
    return data;
  }
}

enum Priority {
  basic,
  low,
  important,
}
