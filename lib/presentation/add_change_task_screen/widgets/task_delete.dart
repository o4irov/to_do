import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../domain/models/task.dart';
import '../../../utils/localizations.dart';
import 'confirm.dart';

class TaskDelete extends StatelessWidget {
  final bool isAdding;
  final Task? task;
  const TaskDelete({super.key, required this.task, required this.isAdding});

  @override
  Widget build(BuildContext context) {
    Future<void> confirmDelete() async {
      await showDialog(
        context: context,
        builder: (context) {
          return Confirm(
            task: task,
          );
        },
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          GestureDetector(
            onTap: isAdding
                ? null
                : () async {
                    await confirmDelete();
                  },
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Icon(
                    Icons.delete,
                    color: isAdding
                        ? AppConstants.red(context).withOpacity(.6)
                        : AppConstants.red(context),
                    size: 25,
                  ),
                  const Padding(padding: EdgeInsets.only(right: 10)),
                  Text(
                    AppLocalizations.of(context)?.translate('delete') ?? '',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isAdding
                              ? AppConstants.red(context).withOpacity(.6)
                              : AppConstants.red(context),
                          fontSize: 18,
                        ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
