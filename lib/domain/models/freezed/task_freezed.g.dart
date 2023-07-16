// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_freezed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

// ignore: non_constant_identifier_names
_$_TaskFreezed _$$_TaskFreezedFromJson(Map<String, dynamic> json) =>
    _$_TaskFreezed(
      id: json['id'] as String,
      title: json['title'] as String,
      importance: $enumDecodeNullable(_$PriorityEnumMap, json['importance']) ??
          Priority.basic,
      isCompleted: json['isCompleted'] as bool? ?? false,
      deadline: json['deadline'] as int?,
      color: json['color'] as String? ?? '#FFFFFF',
      createdAt: json['createdAt'] as int,
      changedAt: json['changedAt'] as int,
      lastUpdatedBy: json['lastUpdatedBy'] as String,
    );

// ignore: non_constant_identifier_names
Map<String, dynamic> _$$_TaskFreezedToJson(_$_TaskFreezed instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'importance': _$PriorityEnumMap[instance.importance]!,
      'isCompleted': instance.isCompleted,
      'deadline': instance.deadline,
      'color': instance.color,
      'createdAt': instance.createdAt,
      'changedAt': instance.changedAt,
      'lastUpdatedBy': instance.lastUpdatedBy,
    };

const _$PriorityEnumMap = {
  Priority.basic: 'basic',
  Priority.low: 'low',
  Priority.important: 'important',
};
