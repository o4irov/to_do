import 'package:to_do/data/controllers/tasks_change_notifier_controller.dart';

import '../domain/models/task.dart';

class NavigationState {
  final bool main;
  final bool edit;

  final Task? task;
  final TasksChangeNotifierController? tasksChangeNotifierController;

  const NavigationState.main()
      : main = true,
        edit = false,
        task = null,
        tasksChangeNotifierController = null;
  const NavigationState.edit({this.tasksChangeNotifierController, this.task})
      : edit = true,
        main = false;
}
