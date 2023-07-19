import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:to_do/data/repository/task_repository_impl.dart';
import 'package:to_do/domain/models/task.dart';
import 'package:to_do/domain/repository/task_repository.dart';
import 'package:to_do/utils/logger.dart';

import 'data/tasks.dart';
import 'test_doubles/connectivity_checker_mock.mocks.dart';
import 'test_doubles/network_manager_mock.mocks.dart';
import 'test_doubles/persistence_manager_mock.mocks.dart';

void main() {
  late final MockNetworkManager networkManager;
  late final MockPersistenceManager persistenceManager;
  late final MockConnectivityChecker connectivityChecker;

  setUp(() async => {
        networkManager = MockNetworkManager(),
        persistenceManager = MockPersistenceManager(),
        connectivityChecker = MockConnectivityChecker(),
        when(connectivityChecker.networkChecker())
            .thenAnswer((realInvocation) => Future.value(false)),
        when(persistenceManager.getTasks())
            .thenAnswer((realInvocation) => Future.value(tasks)),
      });
  test('Task repository test. Function get tasks', () async {
    final TaskRepository taskRepository = TaskRepositoryImpl(
      persistenceManager,
      networkManager,
      connectivityChecker,
    );

    final List<Task> taskList = await taskRepository.getTasks();

    for (var task in taskList) {
      logger.i(task.title);
    }

    expect(taskList, tasks);
  });
}
