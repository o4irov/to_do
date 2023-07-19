import 'package:flutter_test/flutter_test.dart';
import 'package:to_do/domain/models/task.dart';
import 'package:to_do/utils/logger.dart';

import 'data/task_jsons.dart';

void main() {
  late Task task;
  test('Test of method Task.toJson', () async {
    task = Task(
      id: tasksJson[1]['id'],
      title: tasksJson[1]['text'],
      importance: Priority.low,
      deadline: tasksJson[1]['deadline'],
      isCompleted: tasksJson[1]['done'],
    );

    final taskJson = await task.toJson(task);
    logger.i(taskJson);

    expect(taskJson['id'], tasksJson[1]['id']);
    expect(taskJson['title'], tasksJson[1]['title']);
    expect(taskJson['importance'], tasksJson[1]['importance']);
    expect(taskJson['importance'], tasksJson[1]['importance']);
    expect(taskJson['importance'], tasksJson[1]['importance']);
  });
}
