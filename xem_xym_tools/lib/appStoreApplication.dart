import 'package:fluro/fluro.dart';
import 'package:logging/logging.dart';
import 'package:xem_xym_tools/repository/zaifRepository.dart';

import 'appRoutes.dart';
import 'application.dart';
import 'utility/log.dart';

class AppStoreApplication implements Application {
  FluroRouter router;
  ZaifRepository zaifRepository;

  @override
  void onCreate() async {
    _initLog();
    _initRouter();
    initRepository();
    await _initDB();
  }

  @override
  void onTerminate() async {
    // await db close
  }

  Future<void> _initDB() async {}

  void _initRouter() {
    router = new FluroRouter();
    AppRoutes.configureRoutes(router);
  }

  void _initLog() {
    Log.init();

    Log.setLevel(Level.ALL);
  }

  void initRepository() {
    zaifRepository = ZaifRepository();
  }
}
