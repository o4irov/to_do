import 'package:flutter/material.dart';
import 'package:to_do/constants/constants.dart';
import 'package:to_do/domain/global.dart';
import 'package:to_do/domain/models/task.dart';
import 'package:to_do/presentation/common/task.dart';
import 'package:to_do/utils/localizations.dart';

import '../add_change_task/add_change.dart';
import 'home_screen.dart';

class ToDoList extends StatefulWidget {
  final bool isVisible;
  const ToDoList({
    super.key,
    required this.isVisible,
  });

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  TasksId tasksId = TasksId();

  @override
  void initState() {
    tasksId.count = HomeScreen.listOf(context)!.length;
    super.initState();
  }

  void addTask(Task newTask) {
    HomeScreen.addOf(context, task: newTask);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: HomeScreen.listOf(context)!.length + 1,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        //Создаём задачу
        if (index == HomeScreen.listOf(context)!.length) {
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
        if (widget.isVisible) {
          return TaskTile(
            task: HomeScreen.listOf(context)![index],
          );
        }
        // Инчае показываем только те, которые ещё нужно выполнить
        if (!HomeScreen.listOf(context)![index].isCompleted) {
          return TaskTile(
            task: HomeScreen.listOf(context)![index],
          );
        }
        return Container();
      },
    );
  }
}
