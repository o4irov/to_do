import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do/constants/constants.dart';
import 'package:to_do/presentation/add_change_task/add_change.dart';

import '../../domain/models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final Function(int) deleteTask;
  final Function(Task, bool?) onChanged;
  const TaskTile(
      {super.key,
      required this.task,
      required this.deleteTask,
      required this.onChanged});

  void change(bool value) {
    if (value) {
      onChanged(
        Task(
          id: task.id,
          title: task.title,
          isCompleted: true,
          deadline: task.deadline,
          importance: task.importance,
        ),
        value,
      );
    } else {
      onChanged(
        Task(
          id: task.id,
          title: task.title,
          isCompleted: false,
          deadline: task.deadline,
          importance: task.importance,
        ),
        value,
      );
    }
  }

  String formatDate(String inputDate) {
    final parsedDate = DateFormat('dd MM yyyy').parse(inputDate);
    final formattedDate = DateFormat('dd MMMM yyyy', 'ru').format(parsedDate);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey<int>(task.id),
      background: const Done(),
      secondaryBackground: const Delete(),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          if (!task.isCompleted) {
            change(true);
          }
          return false;
        }
        return true;
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          deleteTask(task.id);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        color: AppConstants.backSecondary(context),
        
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 24,
                  child: Checkbox(
                    value: task.isCompleted,
                    onChanged: (value) => change(value ?? true),
                    fillColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return AppConstants.green(context);
                        }
                        return task.importance == Priority.high
                            ? AppConstants.red(context)
                            : AppConstants.separator(context);
                      },
                    ),
                    activeColor: AppConstants.green(context),
                    checkColor: AppConstants.backPrimary(context),
                  ),
                ),
                Importance(
                  importance: task.importance,
                  isCompleted: task.isCompleted,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 135,
                          child: Text(
                            task.title,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: task.isCompleted
                                      ? AppConstants.tertiary(context)
                                      : AppConstants.primary(context),
                                  decoration: task.isCompleted
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  decorationColor:
                                      AppConstants.tertiary(context),
                                ),
                          ),
                        ),
                      ],
                    ),
                    task.deadline != null
                        ? Text(
                            formatDate(
                                '${task.deadline?.day} ${task.deadline?.month} ${task.deadline?.year}'),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontSize: 14,
                                  color: AppConstants.tertiary(context),
                                ),
                          )
                        : Container(),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: () async {
                final newTask = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTask(
                      task: task,
                      deleteTask: deleteTask,
                    ),
                  ),
                );
                if (newTask != null) {
                  onChanged(newTask, null);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  Icons.info_outline,
                  color: AppConstants.tertiary(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Done extends StatelessWidget {
  const Done({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppConstants.green(context),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Icon(
            Icons.done_rounded,
            color: AppConstants.white(context),
          ),
        ),
      ),
    );
  }
}

class Delete extends StatelessWidget {
  const Delete({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppConstants.red(context),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Icon(
            Icons.delete,
            color: AppConstants.white(context),
          ),
        ),
      ),
    );
  }
}

class Importance extends StatelessWidget {
  final Priority importance;
  final bool isCompleted;
  const Importance(
      {super.key, required this.importance, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    if (importance == Priority.high && !isCompleted) {
      return Text(
        '!! ',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppConstants.red(context),
            height: 1.2,
            fontWeight: FontWeight.w900),
      );
    } else if (importance == Priority.low && !isCompleted) {
      return Text(
        '↓ ',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppConstants.gray(context),
            fontSize: 24,
            height: .9,
            fontWeight: FontWeight.w900),
      );
    }
    return Container();
  }
}
