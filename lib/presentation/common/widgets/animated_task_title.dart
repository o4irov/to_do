import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class AnimatedTaskTitle extends StatelessWidget {
  final String title;
  final bool isCompleted;
  const AnimatedTaskTitle({
    super.key,
    required this.title,
    required this.isCompleted,
  });

  final duration = const Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 135,
            child: Text(
              title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppConstants.tertiary(context),
                    decoration: TextDecoration.lineThrough,
                    decorationColor: AppConstants.tertiary(context),
                  ),
            ),
          ),
        ],
      ),
      secondChild: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 135,
            child: Text(
              title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppConstants.primary(context),
                    decoration: TextDecoration.none,
                    decorationColor: AppConstants.tertiary(context),
                  ),
            ),
          ),
        ],
      ),
      crossFadeState:
          isCompleted ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: duration,
    );
  }
}
