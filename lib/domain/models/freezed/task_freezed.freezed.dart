// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_freezed.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TaskFreezed _$TaskFreezedFromJson(Map<String, dynamic> json) {
  return _TaskFreezed.fromJson(json);
}

/// @nodoc
mixin _$TaskFreezed {
  String get id => throw _privateConstructorUsedError;
  @JsonValue('text')
  String get title => throw _privateConstructorUsedError;
  Priority get importance => throw _privateConstructorUsedError;
  @JsonValue('done')
  bool get isCompleted => throw _privateConstructorUsedError;
  int? get deadline => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;
  @JsonValue('created_at')
  int get createdAt => throw _privateConstructorUsedError;
  @JsonValue('changed_at')
  int get changedAt => throw _privateConstructorUsedError;
  @JsonValue('last_updated_by')
  String get lastUpdatedBy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskFreezedCopyWith<TaskFreezed> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskFreezedCopyWith<$Res> {
  factory $TaskFreezedCopyWith(
          TaskFreezed value, $Res Function(TaskFreezed) then) =
      _$TaskFreezedCopyWithImpl<$Res, TaskFreezed>;
  @useResult
  $Res call(
      {String id,
      @JsonValue('text') String title,
      Priority importance,
      @JsonValue('done') bool isCompleted,
      int? deadline,
      String color,
      @JsonValue('created_at') int createdAt,
      @JsonValue('changed_at') int changedAt,
      @JsonValue('last_updated_by') String lastUpdatedBy});
}

/// @nodoc
class _$TaskFreezedCopyWithImpl<$Res, $Val extends TaskFreezed>
    implements $TaskFreezedCopyWith<$Res> {
  _$TaskFreezedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? importance = null,
    Object? isCompleted = null,
    Object? deadline = freezed,
    Object? color = null,
    Object? createdAt = null,
    Object? changedAt = null,
    Object? lastUpdatedBy = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      importance: null == importance
          ? _value.importance
          : importance // ignore: cast_nullable_to_non_nullable
              as Priority,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as int?,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as int,
      changedAt: null == changedAt
          ? _value.changedAt
          : changedAt // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdatedBy: null == lastUpdatedBy
          ? _value.lastUpdatedBy
          : lastUpdatedBy // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TaskFreezedCopyWith<$Res>
    implements $TaskFreezedCopyWith<$Res> {
  factory _$$_TaskFreezedCopyWith(
          _$_TaskFreezed value, $Res Function(_$_TaskFreezed) then) =
      __$$_TaskFreezedCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonValue('text') String title,
      Priority importance,
      @JsonValue('done') bool isCompleted,
      int? deadline,
      String color,
      @JsonValue('created_at') int createdAt,
      @JsonValue('changed_at') int changedAt,
      @JsonValue('last_updated_by') String lastUpdatedBy});
}

/// @nodoc
class __$$_TaskFreezedCopyWithImpl<$Res>
    extends _$TaskFreezedCopyWithImpl<$Res, _$_TaskFreezed>
    implements _$$_TaskFreezedCopyWith<$Res> {
  __$$_TaskFreezedCopyWithImpl(
      _$_TaskFreezed _value, $Res Function(_$_TaskFreezed) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? importance = null,
    Object? isCompleted = null,
    Object? deadline = freezed,
    Object? color = null,
    Object? createdAt = null,
    Object? changedAt = null,
    Object? lastUpdatedBy = null,
  }) {
    return _then(_$_TaskFreezed(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      importance: null == importance
          ? _value.importance
          : importance // ignore: cast_nullable_to_non_nullable
              as Priority,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as int?,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as int,
      changedAt: null == changedAt
          ? _value.changedAt
          : changedAt // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdatedBy: null == lastUpdatedBy
          ? _value.lastUpdatedBy
          : lastUpdatedBy // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TaskFreezed extends _TaskFreezed with DiagnosticableTreeMixin {
  const _$_TaskFreezed(
      {required this.id,
      @JsonValue('text') required this.title,
      this.importance = Priority.basic,
      @JsonValue('done') this.isCompleted = false,
      this.deadline,
      this.color = '#FFFFFF',
      @JsonValue('created_at') required this.createdAt,
      @JsonValue('changed_at') required this.changedAt,
      @JsonValue('last_updated_by') required this.lastUpdatedBy})
      : super._();

  factory _$_TaskFreezed.fromJson(Map<String, dynamic> json) =>
      _$$_TaskFreezedFromJson(json);

  @override
  final String id;
  @override
  @JsonValue('text')
  final String title;
  @override
  @JsonKey()
  final Priority importance;
  @override
  @JsonKey()
  @JsonValue('done')
  final bool isCompleted;
  @override
  final int? deadline;
  @override
  @JsonKey()
  final String color;
  @override
  @JsonValue('created_at')
  final int createdAt;
  @override
  @JsonValue('changed_at')
  final int changedAt;
  @override
  @JsonValue('last_updated_by')
  final String lastUpdatedBy;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TaskFreezed(id: $id, title: $title, importance: $importance, isCompleted: $isCompleted, deadline: $deadline, color: $color, createdAt: $createdAt, changedAt: $changedAt, lastUpdatedBy: $lastUpdatedBy)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TaskFreezed'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('importance', importance))
      ..add(DiagnosticsProperty('isCompleted', isCompleted))
      ..add(DiagnosticsProperty('deadline', deadline))
      ..add(DiagnosticsProperty('color', color))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('changedAt', changedAt))
      ..add(DiagnosticsProperty('lastUpdatedBy', lastUpdatedBy));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TaskFreezed &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.importance, importance) ||
                other.importance == importance) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.changedAt, changedAt) ||
                other.changedAt == changedAt) &&
            (identical(other.lastUpdatedBy, lastUpdatedBy) ||
                other.lastUpdatedBy == lastUpdatedBy));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, importance,
      isCompleted, deadline, color, createdAt, changedAt, lastUpdatedBy);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TaskFreezedCopyWith<_$_TaskFreezed> get copyWith =>
      __$$_TaskFreezedCopyWithImpl<_$_TaskFreezed>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TaskFreezedToJson(
      this,
    );
  }
}

abstract class _TaskFreezed extends TaskFreezed {
  const factory _TaskFreezed(
          {required final String id,
          @JsonValue('text') required final String title,
          final Priority importance,
          @JsonValue('done') final bool isCompleted,
          final int? deadline,
          final String color,
          @JsonValue('created_at') required final int createdAt,
          @JsonValue('changed_at') required final int changedAt,
          @JsonValue('last_updated_by') required final String lastUpdatedBy}) =
      _$_TaskFreezed;
  const _TaskFreezed._() : super._();

  factory _TaskFreezed.fromJson(Map<String, dynamic> json) =
      _$_TaskFreezed.fromJson;

  @override
  String get id;
  @override
  @JsonValue('text')
  String get title;
  @override
  Priority get importance;
  @override
  @JsonValue('done')
  bool get isCompleted;
  @override
  int? get deadline;
  @override
  String get color;
  @override
  @JsonValue('created_at')
  int get createdAt;
  @override
  @JsonValue('changed_at')
  int get changedAt;
  @override
  @JsonValue('last_updated_by')
  String get lastUpdatedBy;
  @override
  @JsonKey(ignore: true)
  _$$_TaskFreezedCopyWith<_$_TaskFreezed> get copyWith =>
      throw _privateConstructorUsedError;
}
