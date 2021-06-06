import 'package:appspector/appspector.dart';
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
    _runAppSpector();
    runApp(AppComponent(application));
  }

  void _runAppSpector() {
    final config = Config()
      ..iosApiKey = ""
      ..androidApiKey =
          "android_ZmZiYjBkYzQtYjU2Mi00MTUwLTg5ZTQtMDMyZWM3NmVjMGI2"
      ..monitors = [
        Monitors.screenshot,
        Monitors.sqLite,
        Monitors.sharedPreferences,
        Monitors.userDefaults,
      ];

    AppSpectorPlugin.run(config);
  }
}
