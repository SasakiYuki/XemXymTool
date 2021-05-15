import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'appProvider.dart';
import 'appStoreApplication.dart';

class AppComponent extends StatefulWidget {
  final AppStoreApplication _application;

  AppComponent(this._application);

  @override
  State createState() {
    return new AppComponentState(_application);
  }
}

class AppComponentState extends State<AppComponent> {
  final AppStoreApplication _application;

  AppComponentState(this._application);

  @override
  void dispose() async {
    super.dispose();
    await _application.onTerminate();
  }

  @override
  Widget build(BuildContext context) {
    final app = new MaterialApp(
      title: 'TrialTool',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(primarySwatch: Colors.amber),
      onGenerateRoute: _application.router.generator,
    );

    final appProvider = AppProvider(child: app, application: _application);
    return appProvider;
  }
}
