import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:to_do/constants/constants.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/presentation/task.dart';
import 'package:to_do/utils/localizations.dart';

import 'add_change.dart';

class ToDoList extends StatefulWidget {
  final bool isVisible;
  final Function(bool?) changeCount;
  const ToDoList(
      {super.key, required this.isVisible, required this.changeCount});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  List<Task> tasks = [
    Task(
      id: 1,
      title: 'Купить что-то',
    ),
    Task(
        id: 2,
        title: 'Купить что-то, где-то, зачем-то, но зачем не очень понятно',
        importance: 'high'),
    Task(
        id: 3,
        title:
            'Купить что-то, где-то, зачем-то, но зачем не очень понятно, но точно чтобы показать как обр…',
        importance: 'low'),
  ];

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  void _callCountChanged(bool? increase) {
    widget.changeCount(increase);
  }

  void deleteTask(int id) {
    setState(() {
      tasks.removeWhere((element) => element.id == id);
      logger.d('Id deleted task: $id');
    });
  }

  void onChanged(Task task, bool? value) {
    _callCountChanged(value);
    setState(() {
      try {
        int idx =
            tasks.indexOf(tasks.firstWhere((element) => element.id == task.id));
        tasks[idx] = task;
      } catch (e) {
        tasks.add(task);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: tasks.length + 1,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        //Создаём задачу
        if (index == tasks.length) {
          return TextButton(
            onPressed: () async {
              final newTask = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddTask(),
                ),
              );
              if (newTask != null) {
                onChanged(newTask, null);
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
            task: tasks[index],
            deleteTask: deleteTask,
            onChanged: (task, value) => onChanged(task, value),
          );
        }
        // Инчае показываем только те, которые ещё нужно выполнить
        if (tasks[index].status == 'in doing') {
          return TaskTile(
            task: tasks[index],
            deleteTask: deleteTask,
            onChanged: (task, value) => onChanged(task, value),
          );
        }
        return Container();
      },
    );
  }
}
