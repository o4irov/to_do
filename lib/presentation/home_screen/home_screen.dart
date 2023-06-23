import 'package:flutter/material.dart';
import 'package:to_do/domain/managers/persistence_manager.dart';
import 'package:to_do/domain/models/task.dart';
import 'package:to_do/presentation/home_screen/todo_list.dart';
import 'package:to_do/utils/logger.dart';

import '../../constants/constants.dart';
import '../../utils/localizations.dart';
import '../add_change_task/add_change.dart';

@immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  static List<Task>? listOf(BuildContext context) =>
      _HomeScreenScope.of(context).tasks;

  static void addOf(BuildContext context, {required Task task}) =>
      _of(context)?.addTask(task);

  static void removeOf(BuildContext context, {required Task task}) =>
      _of(context)?.removeTask(task);

  static void changeOf(BuildContext context, {required Task task}) =>
      _of(context)?.changeTask(task);

  static void increaseCountOf(BuildContext context,
          {required bool isIncrease}) =>
      _of(context)?.increaseCount(isIncrease);

  static _HomeScreenState? _of(BuildContext context) =>
      _HomeScreenScope.of(context).state;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> _tasks = <Task>[
    Task(
      id: 1,
      title: 'Купить что-то',
    ),
    Task(
        id: 2,
        title: 'Купить что-то, где-то, зачем-то, но зачем не очень понятно',
        importance: Priority.high),
    Task(
        id: 3,
        title:
            'Купить что-то, где-то, зачем-то, но зачем не очень понятно, но точно чтобы показать как обр…',
        importance: Priority.low),
  ];

  final PersistenceManager _persistenceManager = PersistenceManager();

  bool _isVisible = true;
  int count = 0;

  @override
  void initState() {
    _persistenceManager
        .getTasks()
        .then((value) => setState(() => _tasks = value));
    super.initState();
  }

  void addTask(Task task) async {
    // setState(() {
    //   _tasks = List.of([..._tasks, task]);
    // });
    await _persistenceManager.addTask(task: task);
    _tasks = await _persistenceManager.getTasks();
    setState(() {});
  }

  Future<void> removeTask(Task task) async {
    // setState(() {
    //   _tasks = List.of(_tasks.where((e) => e != task));
    //   if (task.isCompleted) {
    //     count--;
    //   }
    // });
    await _persistenceManager.removeTask(task: task);
    _tasks = await _persistenceManager.getTasks();
    setState(() {});
    logger.d('Deleted task: ${task.id}');
  }

  void changeTask(Task task) {
    // setState(() {
    //   _tasks[_tasks.indexOf(
    //       _tasks.firstWhere((element) => element.id == task.id))] = task;
    // });
  }

  void increaseCount(bool isIncrease) {
    if (isIncrease) {
      count++;
      return;
    }
    count--;
  }

  void _toggleVisibility() => setState(() => _isVisible = !_isVisible);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _HomeScreenScope(
      state: this,
      tasks: _tasks,
      child: StatefulBuilder(
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
                              AppLocalizations.of(context)
                                      ?.translate('tasks') ??
                                  '',
                              style: theme.textTheme.titleLarge,
                            ),
                            IconButton(
                              onPressed: _toggleVisibility,
                              icon: Icon(
                                _isVisible
                                    ? Icons.visibility_rounded
                                    : Icons.visibility_off_rounded,
                                color: AppConstants.blue(context),
                              ),
                            )
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
                      child: Text(
                        '${AppLocalizations.of(context)?.translate('done')} - $count',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppConstants.tertiary(context),
                        ),
                      ),
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
                          child: ToDoList(
                            isVisible: _isVisible,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
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
              backgroundColor: AppConstants.blue(context),
              shape: const CircleBorder(),
              child: Icon(
                Icons.add,
                color: AppConstants.white(context),
              ),
            ),
          );
        },
      ),
    );
  }
}

@immutable
class _HomeScreenScope extends InheritedWidget {
  final List<Task> tasks;
  final _HomeScreenState state;

  const _HomeScreenScope({
    required Widget child,
    required this.state,
    required this.tasks,
    Key? key,
  }) : super(key: key, child: child);

  static _HomeScreenScope of(BuildContext context, {bool listen = false}) =>
      listen
          ? context.dependOnInheritedWidgetOfExactType<_HomeScreenScope>()!
          : context
              .getElementForInheritedWidgetOfExactType<_HomeScreenScope>()!
              .widget as _HomeScreenScope;

  @override
  bool updateShouldNotify(_HomeScreenScope oldWidget) =>
      !identical(state, oldWidget.state) || state != oldWidget.state;
}