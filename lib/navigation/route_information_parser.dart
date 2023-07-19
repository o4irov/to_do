import 'package:flutter/material.dart';
import 'package:to_do/data/local/persistence_manager_impl.dart';

import '../data/local/persistence_manager.dart';
import '../domain/models/routes.dart';
import 'navigation_state.dart';

/// URI <> NavigationState
class MyRouteInformationParser extends RouteInformationParser<NavigationState> {
  @override
  Future<NavigationState> parseRouteInformation(
      RouteInformation routeInformation) async {
    final location = routeInformation.location;
    PersistenceManager persistenceManager = PersistenceManagerImpl();
    final uri = Uri.parse(location ?? 'myapp://example.com/');

    if (uri.pathSegments.isEmpty) {
      return const NavigationState.main();
    }

    if (uri.pathSegments.length == 2) {
      final taskId = uri.pathSegments[1];
      final tasks = await persistenceManager.getTasks();
      final task = tasks.firstWhere((element) => element.id == taskId);

      if (uri.pathSegments[0] == Routes.task &&
          tasks.any((item) => item.id == taskId)) {
        return NavigationState.edit(task: task);
      }
    }
    return const NavigationState.main();
  }

  @override
  RouteInformation? restoreRouteInformation(NavigationState configuration) {
    if (configuration.edit && configuration.task == null) {
      return const RouteInformation(location: '/${Routes.adding}');
    }

    if (configuration.edit && configuration.task != null) {
      return RouteInformation(
          location: '/${Routes.task}/${configuration.task!.id}');
    }

    return const RouteInformation(location: '/');
  }
}
