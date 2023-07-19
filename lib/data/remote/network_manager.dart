import '../../domain/models/task.dart';

abstract class NetworkManager {
  Future<List<Task>> getTasks();
  Future<int> updateTasks(List<Task> tasks, int revision);
  Future<Task?> getTask(int taskId, int revision);
  Future<int> addTask(Task task, int revision);
  Future<int> changeTask(Task task, int revision);
  Future<int> removeTask(String taskId, int revision);
  Future<int> getRevision();
}
