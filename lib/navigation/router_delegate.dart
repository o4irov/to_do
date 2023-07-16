import 'package:flutter/material.dart';
import 'package:to_do/data/controllers/tasks_change_notifier_controller.dart';
import 'package:to_do/navigation/navigation_state.dart';
import 'package:to_do/presentation/add_change_task_screen/add_change.dart';
import 'package:to_do/presentation/home_screen/home_screen.dart';
import 'package:to_do/utils/firebase.dart';

import '../domain/models/task.dart';

class MyRouterDelegate extends RouterDelegate<NavigationState>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<NavigationState> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  MyRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  NavigationState state = const NavigationState.main();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        if (state.main == true) //
          HomeScreen(
            addTask: addTask,
            changeTask: changeTask,
          ),
        if (state.edit == true)
          AddTask(
            task: state.task,
            tasksChangeNotifierController: state.tasksChangeNotifierController!,
            pop: pop,
          ),
      ].map((e) => MaterialPage(child: e)).toList(),
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        state = const NavigationState.main();

        Fire.analytics.logEvent(
          name: 'returning_to_HomeScreen',
        );

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

  void addTask(TasksChangeNotifierController tasksChangeNotifierController) {
    state = NavigationState.edit(
        tasksChangeNotifierController: tasksChangeNotifierController);
    notifyListeners();
    Fire.analytics.logEvent(
      name: 'AddTask_screen',
    );
  }

  void changeTask(
      Task task, TasksChangeNotifierController tasksChangeNotifierController) {
    state = NavigationState.edit(
        tasksChangeNotifierController: tasksChangeNotifierController,
        task: task);
    notifyListeners();
    Fire.analytics.logEvent(
      name: 'ChangeTask_screen:taskId:${task.id}',
    );
  }

  void pop(BuildContext context) {
    Navigator.pop(context);
    notifyListeners();
    Fire.analytics.logEvent(
      name: 'returning_to_HomeScreen',
    );
  }
}
