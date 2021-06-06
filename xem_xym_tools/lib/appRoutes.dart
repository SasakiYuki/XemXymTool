import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:xem_xym_tools/ui/address/addressRegistrationPage.dart';
import 'package:xem_xym_tools/ui/recieve/amount/receiveAmountPage.dart';

import 'ui/homePage.dart';

var rootHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomePage();
});

var receiveAmountHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ReceiveAmountPage();
});

var addressRegistrationHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return AddressRegistrationPage();
});

class AppRoutes {
  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print('ROUTE WAS NOT FOUND !!!');
    });
    router.define(HomePage.PATH, handler: rootHandler);
    router.define(ReceiveAmountPage.PATH, handler: receiveAmountHandler);
    router.define(AddressRegistrationPage.PATH, handler: addressRegistrationHandler);
  }
}
