import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do/constants/constants.dart';
import 'package:to_do/data/controllers/tasks_change_notifier_controller.dart';
import 'package:to_do/presentation/add_change_task_screen/add_change.dart';

import '../../domain/models/task.dart';

class TaskTile extends StatelessWidget {
  final TasksChangeNotifierController tasksChangeNotifierController;
  final Task task;
  const TaskTile({
    super.key,
    required this.task,
    required this.tasksChangeNotifierController,
  });

  String formatDate(String inputDate) {
    final parsedDate = DateFormat('dd MM yyyy').parse(inputDate);
    final formattedDate = DateFormat('dd MMMM yyyy', 'ru').format(parsedDate);
    return formattedDate;
  }

  void changeTask(Task newTask) {
    tasksChangeNotifierController.changeTask(newTask);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: tasksChangeNotifierController,
        builder: (context, child) {
          return Dismissible(
            key: ValueKey<String>(task.id),
            background: const Done(),
            secondaryBackground: const Delete(),
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.startToEnd) {
                if (!task.isCompleted) {
                  changeTask(
                    Task(
                      id: task.id,
                      title: task.title,
                      deadline: task.deadline,
                      importance: task.importance,
                      isCompleted: true,
                    ),
                  );
                  tasksChangeNotifierController.increaseCount(true);
                }
                return false;
              }
              return true;
            },
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                tasksChangeNotifierController.removeTask(task);
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
                          onChanged: (value) {
                            changeTask(
                              Task(
                                id: task.id,
                                title: task.title,
                                deadline: task.deadline,
                                importance: task.importance,
                                isCompleted: value!,
                              ),
                            );
                            tasksChangeNotifierController.increaseCount(value);
                          },
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.selected)) {
                                return AppConstants.green(context);
                              }
                              return task.importance == Priority.important
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
                    onTap: !task.isCompleted
                        ? () async {
                            final newTask = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddTask(
                                  task: task,
                                ),
                              ),
                            );
                            if (newTask != null) {
                              changeTask(newTask);
                            }
                          }
                        : null,
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
        });
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
    if (importance == Priority.important && !isCompleted) {
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
