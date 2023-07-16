import 'package:isar/isar.dart';
import 'package:to_do/domain/models/task.dart';
import 'package:uuid/uuid.dart';

part 'task_isar.g.dart';

@Collection()
class TaskIsar {
  String id = const Uuid().v4();

  Id get isarId => fastHash(id);

  String? title;
  bool? isCompleted;
  @enumerated
  Priority importance;
  DateTime? deadline;

  TaskIsar({
    this.importance = Priority.basic,
  });

  int fastHash(String string) {
    var hash = 0xcbf29ce484222325;

    var i = 0;
    while (i < string.length) {
      final codeUnit = string.codeUnitAt(i++);
      hash ^= codeUnit >> 8;
      hash *= 0x100000001b3;
      hash ^= codeUnit & 0xFF;
      hash *= 0x100000001b3;
    }

    return hash;
  }
}
