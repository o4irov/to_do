// Mocks generated by Mockito 5.4.2 from annotations
// in to_do/test/test_doubles/persistence_manager_mock.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:to_do/data/local/persistence_manager.dart' as _i2;
import 'package:to_do/domain/models/task.dart' as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [PersistenceManager].
///
/// See the documentation for Mockito's code generation for more information.
class MockPersistenceManager extends _i1.Mock
    implements _i2.PersistenceManager {
  @override
  _i3.Future<List<_i4.Task>> getTasks() => (super.noSuchMethod(
        Invocation.method(
          #getTasks,
          [],
        ),
        returnValue: _i3.Future<List<_i4.Task>>.value(<_i4.Task>[]),
        returnValueForMissingStub:
            _i3.Future<List<_i4.Task>>.value(<_i4.Task>[]),
      ) as _i3.Future<List<_i4.Task>>);
  @override
  _i3.Future<void> setTasks(List<_i4.Task>? tasks) => (super.noSuchMethod(
        Invocation.method(
          #setTasks,
          [tasks],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> addTask({required _i4.Task? task}) => (super.noSuchMethod(
        Invocation.method(
          #addTask,
          [],
          {#task: task},
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> changeTask({required _i4.Task? task}) => (super.noSuchMethod(
        Invocation.method(
          #changeTask,
          [],
          {#task: task},
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> removeTask({required String? id}) => (super.noSuchMethod(
        Invocation.method(
          #removeTask,
          [],
          {#id: id},
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<int> getRevision() => (super.noSuchMethod(
        Invocation.method(
          #getRevision,
          [],
        ),
        returnValue: _i3.Future<int>.value(0),
        returnValueForMissingStub: _i3.Future<int>.value(0),
      ) as _i3.Future<int>);
  @override
  _i3.Future<void> updateRevision(int? newRevision) => (super.noSuchMethod(
        Invocation.method(
          #updateRevision,
          [newRevision],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}
