import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:to_do/domain/models/task_isar.dart';

import '../models/task.dart';

class PersistenceManager {
  Isar? _isar;

  Future<Isar> get _isarGetter async {
    _isar = Isar.getInstance();
    final appDir = await getApplicationDocumentsDirectory();
    _isar ??= await Isar.open(
      [TaskIsarSchema],
      directory: appDir.path,
    );
    return _isar!;
  }

  Future<List<Task>> getTasks() async {
    final isar = await _isarGetter;
    final tasks = await isar.taskIsars.where().findAll();
    return tasks
        .map(
          (task) => Task(
            id: task.id,
            title: task.title ?? '',
            importance: task.importance,
            deadline: task.deadline,
            isCompleted: task.isCompleted ?? false,
          ),
        )
        .toList();
  }

  Future<void> setTasks(List<Task> tasks) async {
    final isar = await _isarGetter;
    isar.writeTxn(() async {
      await isar.taskIsars.clear();
      await isar.taskIsars.putAll(tasks
          .map((task) => TaskIsar()
            ..title = task.title
            ..importance = task.importance
            ..deadline = task.deadline
            ..isCompleted = task.isCompleted)
          .toList());
    });
  }

  Future<void> addTask({required Task task}) async {
    final isar = await _isarGetter;
    final newTask = TaskIsar()
      ..title = task.title
      ..importance = task.importance
      ..deadline = task.deadline
      ..isCompleted = task.isCompleted;
    isar.writeTxn(() async {
      await isar.taskIsars.put(newTask);
    });
  }

  Future<void> changeTask({required Task task}) async {
    final isar = await _isarGetter;
    final newTask = TaskIsar()
      ..id = task.id
      ..title = task.title
      ..importance = task.importance
      ..deadline = task.deadline
      ..isCompleted = task.isCompleted;
    isar.writeTxn(() async {
      await isar.taskIsars.put(newTask);
    });
  }

  Future<void> removeTask({required Task task}) async {
    final isar = await _isarGetter;
    isar.writeTxn(() async {
      await isar.taskIsars.delete(task.id);
    });
  }
}
