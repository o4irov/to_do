import '../../domain/models/task.dart';

abstract class PersistenceManager {
  Future<List<Task>> getTasks();
  Future<void> setTasks(List<Task> tasks);
  Future<void> addTask({required Task task});
  Future<void> changeTask({required Task task});
  Future<void> removeTask({required String id});
  Future<int> getRevision();
  Future<void> updateRevision(int? newRevision);
}
