import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../domain/models/task.dart';
import '../../../utils/localizations.dart';

class TaskImportance extends StatelessWidget {
  final Priority importance;
  final Function(String) changeSelected;
  const TaskImportance(
      {super.key, required this.importance, required this.changeSelected});

  @override
  Widget build(BuildContext context) {
    PopupMenuItem item(String title, Priority imp) {
      return PopupMenuItem<String>(
        value: imp.toString().split('.').last,
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: imp == Priority.important
                    ? AppConstants.red(context)
                    : AppConstants.primary(context),
              ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)?.translate('importance') ?? '',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 18,
              ),
        ),
        PopupMenuButton(
          initialValue: importance.toString().split('.').last,
          itemBuilder: (context) {
            return [
              item(AppLocalizations.of(context)?.translate('basic') ?? '',
                  Priority.basic),
              item(AppLocalizations.of(context)?.translate('low') ?? '',
                  Priority.low),
              item(AppLocalizations.of(context)?.translate('important') ?? '',
                  Priority.important),
            ];
          },
          onSelected: (value) {
            changeSelected(value);
          },
          icon: Text(
            (AppLocalizations.of(context)
                    ?.translate(importance.toString().split('.').last)) ??
                '',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: importance == Priority.important
                      ? AppConstants.red(context)
                      : AppConstants.tertiary(context),
                ),
          ),
          padding: const EdgeInsets.only(left: 0),
          color: AppConstants.backElevated(context),
        ),
      ],
    );
  }
}
