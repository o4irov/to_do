import 'package:flutter/material.dart';
import 'package:to_do/data/local/persistence_manager.dart';

import '../domain/models/routes.dart';
import 'navigation_state.dart';

class MyRouteInformationParser extends RouteInformationParser<NavigationState> {
  @override
  Future<NavigationState> parseRouteInformation(
      RouteInformation routeInformation) async {
    final location = routeInformation.location;
    final tasks = await PersistenceManager().getTasks();
    if (location == null) {
      return NavigationState.unknown();
    }

    final uri = Uri.parse(location);

    if (uri.pathSegments.isEmpty) {
      return NavigationState.root();
    }

    if (uri.pathSegments.length == 2) {
      final itemId = uri.pathSegments[1];

      if (uri.pathSegments[0] == Routes.task &&
          tasks.any((item) => item.id == itemId)) {
        return NavigationState.item(itemId);
      }

      return NavigationState.unknown();
    }

    if (uri.pathSegments.length == 1) {
      final path = uri.pathSegments[0];
      if (path == Routes.adding) {
        return NavigationState.adding();
      }

      return NavigationState.root();
    }

    return NavigationState.root();
  }

  @override
  RouteInformation? restoreRouteInformation(NavigationState configuration) {
    if (configuration.isAdding) {
      return const RouteInformation(location: '/${Routes.adding}');
    }

    if (configuration.isChanging) {
      return RouteInformation(
          location: '/${Routes.task}/${configuration.selectedTaskId}');
    }

    if (configuration.isUnknown) {
      return null;
    }

    return const RouteInformation(location: '/');
  }
}
