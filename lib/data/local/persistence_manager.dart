import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do/domain/models/task_isar.dart';

import '../../domain/models/task.dart';

const localRevision = 'revision';

class PersistenceManager {
  Isar? _isar;
  final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();

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
          .map((task) => TaskIsar(id: task.id)
            ..title = task.title
            ..importance = task.importance
            ..deadline = task.deadline
            ..isCompleted = task.isCompleted)
          .toList());
    });
    updateRevision(null);
  }

  Future<void> addTask({required Task task}) async {
    final isar = await _isarGetter;
    final newTask = TaskIsar(id: task.id)
      ..title = task.title
      ..importance = task.importance
      ..deadline = task.deadline
      ..isCompleted = task.isCompleted;
    isar.writeTxn(() async {
      await isar.taskIsars.put(newTask);
    });
    updateRevision(null);
  }

  Future<void> changeTask({required Task task}) async {
    final isar = await _isarGetter;
    final newTask = TaskIsar(id: task.id)
      ..id = task.id
      ..title = task.title
      ..importance = task.importance
      ..deadline = task.deadline
      ..isCompleted = task.isCompleted;
    isar.writeTxn(() async {
      await isar.taskIsars.delete(TaskIsar(id: task.id).fastHash(task.id));
      await isar.taskIsars.put(newTask);
    });
    updateRevision(null);
  }

  Future<void> removeTask({required String id}) async {
    final isar = await _isarGetter;
    isar.writeTxn(() async {
      await isar.taskIsars.delete(TaskIsar(id: id).fastHash(id));
    });
    updateRevision(null);
  }

  Future<int> getRevision() async {
    final SharedPreferences sharedPreferences = await _sharedPreferences;
    final revision = sharedPreferences.getInt(localRevision);
    return revision ?? -1;
  }

  Future<void> updateRevision(int? newRevision) async {
    final SharedPreferences sharedPreferences = await _sharedPreferences;
    final revision = sharedPreferences.getInt(localRevision) ?? -1;
    sharedPreferences.setInt(localRevision, newRevision ?? revision + 1);
  }
}
