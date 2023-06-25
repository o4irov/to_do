import 'dart:io';

import 'package:flutter/material.dart';

class Revision extends ChangeNotifier {
  int _value = 0;

  int get value => _value;

  void increment() {
    _value++;
    notifyListeners();
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class TasksId {
  int count = 0;

  static final TasksId _singleton = TasksId._internal();

  factory TasksId() {
    return _singleton;
  }

  TasksId._internal();
}
