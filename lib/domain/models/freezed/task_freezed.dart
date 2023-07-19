import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'task_freezed.freezed.dart';
part 'task_freezed.g.dart';

@freezed
class TaskFreezed with _$TaskFreezed {
  const factory TaskFreezed({
    required String id,
    @JsonValue('text') required String title,
    @Default(Priority.basic) Priority importance,
    @JsonValue('done') @Default(false) bool isCompleted,
    int? deadline,
    @Default('#FFFFFF') String color,
    @JsonValue('created_at') required int createdAt,
    @JsonValue('changed_at') required int changedAt,
    @JsonValue('last_updated_by') required String lastUpdatedBy,
  }) = _TaskFreezed;

  factory TaskFreezed.fromJson(Map<String, dynamic> json) =>
      _$TaskFreezedFromJson(json);

  const TaskFreezed._();
}

enum Priority {
  basic,
  low,
  important,
}