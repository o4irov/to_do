import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:to_do/data/local/persistence_manager.dart';
import 'package:to_do/data/remote/network_manager.dart';
import 'package:to_do/domain/models/task.dart';
import 'package:to_do/domain/repository/task_repository.dart';

import '../../utils/logger.dart';

class TaskRepositoryImpl extends TaskRepository {
  final PersistenceManager persistenceManager;
  final NetworkManager networkManager;

  TaskRepositoryImpl(this.persistenceManager, this.networkManager);

  @override
  Future<List<Task>> getTasks() async {
    final hasNetwork = await networkChecker();
    try {
      if (hasNetwork) {
        final data = await networkManager.getTasks();
        final remoteRevision = await networkManager.getRevision();
        final localRev = await persistenceManager.getRevision();
        logger.i(
            'TaskRepositoryImpl: getTasks() current revision: local: $localRev remote: $remoteRevision');
        if (remoteRevision > localRev) {
          persistenceManager.setTasks(data);
          logger.i(
              'TaskRepositoryImpl: getTasks() local data updated with revision: local: $localRev remote: $remoteRevision');
          return data;
        } else if (remoteRevision < localRev) {
          final localData = await persistenceManager.getTasks();
          persistenceManager.updateRevision(remoteRevision);
          await networkManager.updateTasks(
            localData,
            remoteRevision,
          );
          logger.i(
              'TaskRepositoryImpl: getTasks() remote data updated with revision: local: $localRev remote: $remoteRevision');
          return localData;
        } else {
          final localData = await persistenceManager.getTasks();
          return localData;
        }
      } else {
        final localData = await persistenceManager.getTasks();
        logger.i('TaskRepositoryImpl: getTasks() tasks from local data');
        return localData;
      }
    } on Exception catch (e) {
      logger.e('TaskRepositoryImpl: getTasks(): ${e.toString()}');
      return persistenceManager.getTasks();
    }
  }

  @override
  Future<void> addTask(Task task) async {
    final hasNetwork = await networkChecker();
    try {
      await persistenceManager.addTask(task: task);
      logger.i(
          'TaskRepositoryImpl: addTask(${task.title}) task added to local storage');
      if (hasNetwork) {
        final remoteRevision = await networkManager.getRevision();
        await networkManager.addTask(task, remoteRevision);
        logger.i(
            'TaskRepositoryImpl: addTask(${task.title}) task added to remote storage');
      }
    } on Exception catch (e) {
      logger.e('TaskRepositoryImpl: addTask(): ${e.toString()}');
    }
  }

  @override
  Future<void> removeTask(String id) async {
    final hasNetwork = await networkChecker();
    try {
      await persistenceManager.removeTask(id: id);
      logger.i(
          'TaskRepositoryImpl: removeTask($id) task removed from local storage');
      if (hasNetwork) {
        final remoteRevision = await networkManager.getRevision();
        await networkManager.removeTask(
          id,
          remoteRevision,
        );
        logger.i(
            'TaskRepositoryImpl: removeTask($id) task removed from remote storage');
      }
    } on Exception catch (e) {
      logger.e('TaskRepositoryImpl: removeTask(): ${e.toString()}');
    }
  }

  @override
  Future<void> changeTask(Task task) async {
    final hasNetwork = await networkChecker();
    try {
      await persistenceManager.changeTask(task: task);
      logger.i(
          'TaskRepositoryImpl: changeTask(${task.title}) task changed at local storage');
      if (hasNetwork) {
        final remoteRevision = await networkManager.getRevision();
        persistenceManager.updateRevision(remoteRevision);
        await networkManager.changeTask(
          task,
          remoteRevision,
        );
        logger.i(
            'TaskRepositoryImpl: changeTask(${task.title}) task changed at remote storage');
      }
    } on Exception catch (e) {
      logger.e('TaskRepositoryImpl: changeTask(): ${e.toString()}');
    }
  }

  Future<bool> networkChecker() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    logger.i('networkCheker: Connection: $connectivityResult');
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }
}
