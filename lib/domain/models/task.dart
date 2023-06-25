class Task {
  int id;
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
}

enum Priority {
  basic,
  low,
  important,
}
