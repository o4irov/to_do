class Task {
  int id;
  String title;
  bool isCompleted;
  Priority importance;
  DateTime? deadline;

  Task({
    required this.id,
    required this.title,
    this.importance = Priority.none,
    this.deadline,
    this.isCompleted = false,
  });
}

enum Priority {
  none,
  low,
  high,
}
