import '../models/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();

  Future<void> addTask(Task task);

  Future<void> changeTask(Task task);

  Future<void> removeTask(String id);
}
