import 'package:flutter/material.dart';
import 'package:to_do/data/controllers/tasks_change_notifier_controller.dart';
import 'package:to_do/data/local/persistence_manager.dart';
import 'package:to_do/data/repository/task_repository_impl.dart';
import 'package:to_do/presentation/home_screen/todo_list.dart';

import '../../constants/constants.dart';
import '../../data/remote/network_manager.dart';
import '../../domain/models/task.dart';
import '../../utils/localizations.dart';

@immutable
class HomeScreen extends StatefulWidget {
  final void Function(TasksChangeNotifierController) addTask;
  final void Function(Task, TasksChangeNotifierController) changeTask;
  const HomeScreen({
    Key? key,
    required this.addTask,
    required this.changeTask,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TasksChangeNotifierController tasksChangeNotifierController;

  @override
  void initState() {
    tasksChangeNotifierController = TasksChangeNotifierController(
      taskRepository: TaskRepositoryImpl(
        PersistenceManager(),
        NetworkManager(),
      ),
    );
    tasksChangeNotifierController.getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return StatefulBuilder(
      builder: (context, setState) {
        return Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 170,
                  backgroundColor: AppConstants.backPrimary(context),
                  surfaceTintColor: AppConstants.backPrimary(context),
                  flexibleSpace: FlexibleSpaceBar(
                    title: Container(
                      padding: const EdgeInsets.only(right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)?.translate('tasks') ??
                                '',
                            style: theme.textTheme.titleLarge,
                          ),
                          AnimatedBuilder(
                              animation: tasksChangeNotifierController,
                              builder: (context, child) {
                                return IconButton(
                                  onPressed: tasksChangeNotifierController
                                      .toggleVisibility,
                                  icon: Icon(
                                    tasksChangeNotifierController.isVisible
                                        ? Icons.visibility_rounded
                                        : Icons.visibility_off_rounded,
                                    color: AppConstants.blue(context),
                                  ),
                                );
                              })
                        ],
                      ),
                    ),
                    expandedTitleScale: 1.2,
                    background: Container(
                      color: AppConstants.backPrimary(context),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(73, 0, 20, 15),
                    child: AnimatedBuilder(
                        animation: tasksChangeNotifierController,
                        builder: (context, child) {
                          return Text(
                            '${AppLocalizations.of(context)?.translate('done')} - ${tasksChangeNotifierController.count}',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppConstants.tertiary(context),
                            ),
                          );
                        }),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ClipRect(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppConstants.backSecondary(context),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: AnimatedBuilder(
                            animation: tasksChangeNotifierController,
                            builder: (context, child) {
                              return ToDoList(
                                notifierController:
                                    tasksChangeNotifierController,
                                changeTaskScreen: widget.changeTask,
                                addTask: widget.addTask,
                              );
                            }),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: AnimatedBuilder(
              animation: tasksChangeNotifierController,
              builder: (context, child) {
                return FloatingActionButton(
                  onPressed: () {
                    widget.addTask(tasksChangeNotifierController);
                    // throw Exception('Crashlytics test');
                  },
                  backgroundColor: AppConstants.blue(context),
                  shape: const CircleBorder(),
                  child: Icon(
                    Icons.add,
                    color: AppConstants.white(context),
                  ),
                );
              }),
        );
      },
    );
  }
}
