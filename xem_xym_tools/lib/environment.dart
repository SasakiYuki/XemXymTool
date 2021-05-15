import 'package:flutter/material.dart';

import 'appComponent.dart';
import 'appStoreApplication.dart';

class Environment {
  static Environment value;

  String appName;
  Color primarySwatch;

  int databaseVersion = 1;
  String databaseName;

  Environment() {
    value = this;
    _init();
  }

  void _init() async {
    WidgetsFlutterBinding.ensureInitialized();

    var application = AppStoreApplication();
    await application.onCreate();
    runApp(AppComponent(application));
  }
}
