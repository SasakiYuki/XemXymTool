import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'ui/homePage.dart';

var rootHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomePage();
});

class AppRoutes {
  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print('ROUTE WAS NOT FOUND !!!');
    });
    router.define(HomePage.PATH, handler: rootHandler);
  }
}
