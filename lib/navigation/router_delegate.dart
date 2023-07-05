import 'package:flutter/material.dart';
import 'package:to_do/navigation/navigation_state.dart';
import 'package:to_do/presentation/add_change_task_screen/add_change.dart';
import 'package:to_do/presentation/home_screen/home_screen.dart';

import '../presentation/common/uncnown.dart';

class MyRouterDelegate extends RouterDelegate<NavigationState>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<NavigationState> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  MyRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  NavigationState? state;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          child: HomeScreen(
            addTask: _showAddTaskScreen,
          ),
        ),
        if (state?.isAdding == true)
          const MaterialPage(
            child: AddTask(),
          ),
        if (state?.isUnknown == true)
          const MaterialPage(
            child: UnknownScreen(),
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        state = NavigationState.root();

        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(NavigationState configuration) async {
    state = configuration;
    notifyListeners();
  }

  void _showAddTaskScreen() {
    state = NavigationState.adding();
    notifyListeners();
  }
}
