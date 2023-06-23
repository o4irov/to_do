class TasksId {
  int count = 0;

  static final TasksId _singleton = TasksId._internal();

  factory TasksId() {
    return _singleton;
  }

  TasksId._internal();
}
