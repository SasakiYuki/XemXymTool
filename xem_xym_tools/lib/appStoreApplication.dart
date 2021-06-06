import 'package:fluro/fluro.dart';
import 'package:logging/logging.dart';
import 'package:xem_xym_tools/repository/dBAppStoreRepository.dart';
import 'package:xem_xym_tools/repository/zaifRepository.dart';

import 'appDatabaseMigrationListener.dart';
import 'appRoutes.dart';
import 'application.dart';
import 'databaseHelper.dart';
import 'utility/log.dart';

class AppStoreApplication implements Application {
  FluroRouter router;
  ZaifRepository zaifRepository;
  DatabaseHelper _database;
  DBAppStoreRepository dbAppStoreRepository;

  @override
  void onCreate() async {
    _initLog();
    _initRouter();
    await _initDB();
    initRepository();
  }

  @override
  void onTerminate() async {
    // await db close
  }

  Future<void> _initDB() async {
    AppDatabaseMigrationListener migrationListener =
    AppDatabaseMigrationListener();
    DatabaseConfig databaseConfig = DatabaseConfig(
        1,
        'xym_xem_tools_db',
        migrationListener);
    _database = DatabaseHelper(databaseConfig);
    await _database.open();
  }

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
    dbAppStoreRepository = DBAppStoreRepository(_database.database);
  }
}
