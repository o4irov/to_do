import 'package:flutter/material.dart';
import 'package:to_do/utils/localizations.dart';

class UnknownScreen extends StatelessWidget {
  const UnknownScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)?.translate('notFound') ?? '',
        ),
      ),
      body: const Center(
        child: Text('404'),
      ),
    );
  }
}
