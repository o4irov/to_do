import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../utils/localizations.dart';

class TaskTitle extends StatelessWidget {
  final TextEditingController titleController;
  const TaskTitle({super.key, required this.titleController});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppConstants.backSecondary(context),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: TextField(
        controller: titleController,
        maxLines: 4,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)?.translate('obscure'),
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppConstants.tertiary(context),
              ),
          border: InputBorder.none,
        ),
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
