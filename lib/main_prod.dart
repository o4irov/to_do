import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:to_do/presentation/app.dart';
import 'package:to_do/utils/firebase.dart';
import 'package:to_do/utils/logger.dart';
import 'utils/global.dart';

void main() async {
  final flavor = FlavorConfig(
    name: 'prod',
    color: Colors.blue,
  );

  await Fire.init();
  HttpOverrides.global = MyHttpOverrides();
  final uncaughtExceptionsController = StreamController<void>.broadcast();
  PlatformDispatcher.instance.onError = (error, stackTrace) {
    logger.e(
      'Uncaught exception',
      error,
      stackTrace,
    );

    uncaughtExceptionsController.addError(error, stackTrace);

    return true;
  };

  FlutterError.onError = (details) {
    logger.e(
      'Uncaught exception',
      details.exception,
      details.stack,
    );

    if (!details.silent) {
      uncaughtExceptionsController.addError(details.exception, details.stack);
    }
  };
  runApp(
    MainApp(
      flavor: flavor,
    ),
  );
}
