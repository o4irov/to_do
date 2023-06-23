import 'package:isar/isar.dart';
import 'package:to_do/domain/models/task.dart';

part 'task_isar.g.dart';

@Collection()
class TaskIsar {
  Id id = Isar.autoIncrement;

  String? title;
  bool? isCompleted;
  @enumerated
  Priority importance;
  DateTime? deadline;

  TaskIsar({
    this.importance = Priority.none,
  });
}
