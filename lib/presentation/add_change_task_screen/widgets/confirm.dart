import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../data/controllers/tasks_change_notifier_controller.dart';
import '../../../domain/models/task.dart';
import '../../../utils/localizations.dart';

class Confirm extends StatelessWidget {
  final Task? task;
  final TasksChangeNotifierController? tasksChangeNotifierController;
  final void Function(BuildContext) pop;
  const Confirm({
    super.key,
    required this.task,
    required this.tasksChangeNotifierController,
    required this.pop,
  });

  void removeTask(Task? task) {
    tasksChangeNotifierController!.removeTask(task!);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: AppConstants.backSecondary(context),
      content: Container(
        height: 170,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)?.translate('confirm') ?? '',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    pop(context);
                  },
                  child: Text(
                    AppLocalizations.of(context)?.translate('no') ?? '',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppConstants.blue(context),
                        ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    removeTask(task);
                    pop(context);
                    pop(context);
                  },
                  child: Text(
                    AppLocalizations.of(context)?.translate('yes') ?? '',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppConstants.red(context),
                        ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
