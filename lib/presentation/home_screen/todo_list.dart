import 'package:flutter/material.dart';
import 'package:to_do/constants/constants.dart';
import 'package:to_do/data/controllers/tasks_change_notifier_controller.dart';
import 'package:to_do/domain/models/task.dart';
import 'package:to_do/presentation/common/task.dart';
import 'package:to_do/utils/localizations.dart';

import '../add_change_task_screen/add_change.dart';

class ToDoList extends StatefulWidget {
  final TasksChangeNotifierController notifierController;
  final void Function() addTask;
  const ToDoList({
    super.key,
    required this.notifierController,
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
              final newTask = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddTask(),
                ),
              );
              if (newTask != null) {
                addTask(newTask);
              }
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
                );
              });
        }
        return Container();
      },
    );
  }
}
