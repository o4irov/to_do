import 'package:flutter/material.dart';
import 'package:to_do/domain/models/task.dart';
import 'package:to_do/utils/firebase.dart';

import '../../domain/repository/task_repository.dart';

class TasksChangeNotifierController extends ChangeNotifier {
  List<Task> tasks = [];
  int count = 0;
  bool isVisible = true;

  final TaskRepository _taskRepository;

  TasksChangeNotifierController({required TaskRepository taskRepository})
      : _taskRepository = taskRepository;

  Future<void> getTasks() async {
    tasks = await _taskRepository.getTasks();
    for (var task in tasks) {
      if (task.isCompleted) {
        count++;
      }
    }
    notifyListeners();
  }

  //Дублировал вызов метода notifyListeners для быстрого реагирования на изменения
  //если есть способ лучше, то буду благодарен за подсказку

  Future<void> addTask(Task task) async {
    tasks.add(task);
    notifyListeners();
    await _taskRepository.addTask(task);
    Fire.analytics.logEvent(
      name: 'AddTask',
      parameters: {
        'taskId': task.id,
        'taskTitle': task.title,
      },
    );
    notifyListeners();
  }

  Future<void> removeTask(Task task) async {
    tasks.removeWhere((element) => element.id == task.id);
    if (task.isCompleted) {
      count--;
    }
    notifyListeners();
    await _taskRepository.removeTask(task.id);
    Fire.analytics.logEvent(
      name: 'RemoveTask',
      parameters: {
        'taskId': task.id,
        'taskTitle': task.title,
      },
    );
    notifyListeners();
  }

  Future<void> changeTask(Task task) async {
    tasks[tasks.indexOf(tasks.firstWhere((element) => element.id == task.id))] =
        task;
    notifyListeners();
    await _taskRepository.changeTask(task);
    Fire.analytics.logEvent(
      name: 'ChangeTask',
      parameters: {
        'taskId': task.id,
        'taskTitle': task.title,
      },
    );
    notifyListeners();
  }

  void toggleVisibility() {
    isVisible = !isVisible;
    notifyListeners();
  }

  void increaseCount(bool isIncrease) {
    if (isIncrease) {
      count++;
      return;
    }
    count--;
    notifyListeners();
  }
}
