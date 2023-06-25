import 'package:flutter/material.dart';
import 'package:to_do/domain/managers/persistence_manager.dart';

import '../../../constants/constants.dart';
import '../../../domain/models/task.dart';
import '../../../utils/localizations.dart';

class Confirm extends StatelessWidget {
  final Task? task;
  const Confirm({super.key, required this.task});

  void removeTask(Task? task) async {
    PersistenceManager persistenceManager = PersistenceManager();
    await persistenceManager.removeTask(task: task!);
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
                    Navigator.pop(context);
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
                    Navigator.pop(context);
                    Navigator.pop(context);
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
