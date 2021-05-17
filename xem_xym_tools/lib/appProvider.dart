import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:xem_xym_tools/appStoreApplication.dart';

class AppProvider extends InheritedWidget {
  final AppStoreApplication application;

  AppProvider({Key key, Widget child, this.application})
      : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static AppProvider of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<AppProvider>());
  }

  static FluroRouter getRouter(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<AppProvider>())
        .application
        .router;
  }

  static AppStoreApplication getApplication(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<AppProvider>())
        .application;
  }
}
