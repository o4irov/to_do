class Task {
  int id;
  String title;
  String? status = 'in doing';
  String? importance;
  DateTime? deadline;

  Task({
    required this.id,
    required this.title,
    this.importance,
    this.deadline,
    this.status,
  });
}
