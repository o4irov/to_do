import 'package:flutter/material.dart';
import 'package:to_do/constants/constants.dart';
import 'package:to_do/data/controllers/tasks_change_notifier_controller.dart';
import 'package:to_do/domain/models/task.dart';
import 'package:to_do/presentation/common/task.dart';
import 'package:to_do/utils/localizations.dart';

class ToDoList extends StatefulWidget {
  final TasksChangeNotifierController notifierController;
  final void Function(TasksChangeNotifierController) addTask;
  final void Function(Task, TasksChangeNotifierController) changeTaskScreen;
  const ToDoList({
    super.key,
    required this.notifierController,
    required this.changeTaskScreen,
    required this.addTask,
  });

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  late final TasksChangeNotifierController _notifierController;

  @override
  void initState() {
    _notifierController = widget.notifierController;
    super.initState();
  }

  void addTask(Task newTask) {
    _notifierController.addTask(newTask);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _notifierController.tasks.length + 1,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        //Создаём задачу
        if (index == _notifierController.tasks.length) {
          return TextButton(
            onPressed: () async {
              widget.addTask(_notifierController);
            },
            child: Container(
              padding: const EdgeInsets.only(left: 53),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)?.translate('new') ?? '',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppConstants.tertiary(context),
                      ),
                ),
              ),
            ),
          );
        }
        //Если нужно показывать решённые задачи
        if (_notifierController.isVisible) {
          return AnimatedBuilder(
              animation: _notifierController,
              builder: (context, child) {
                return TaskTile(
                  task: _notifierController.tasks[index],
                  tasksChangeNotifierController: _notifierController,
                  changeTaskScreen: widget.changeTaskScreen,
                );
              });
        }
        // Инчае показываем только те, которые ещё нужно выполнить
        if (!_notifierController.tasks[index].isCompleted) {
          return AnimatedBuilder(
              animation: _notifierController,
              builder: (context, child) {
                return TaskTile(
                  task: _notifierController.tasks[index],
                  tasksChangeNotifierController: _notifierController,
                  changeTaskScreen: widget.changeTaskScreen,
                );
              });
        }
        return Container();
      },
    );
  }
}
