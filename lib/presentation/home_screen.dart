import 'package:flutter/material.dart';
import 'package:to_do/constants/constants.dart';
import 'package:to_do/presentation/add_change.dart';
import 'package:to_do/presentation/todo_list.dart';
import 'package:to_do/utils/localizations.dart';

class ToDo extends StatefulWidget {
  const ToDo({super.key});

  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  bool _isVisible = true;
  int count = 0;
  void changeCount(bool? increase) {
    setState(() {
      if (increase == null) {
        return;
      }
      if (increase) {
        count++;
        return;
      }
      count--;
    });
  }

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
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
                          IconButton(
                            onPressed: _toggleVisibility,
                            icon: Icon(
                              _isVisible
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
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
                          changeCount: changeCount,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddTask(),
                ),
              );
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
    );
  }
}
