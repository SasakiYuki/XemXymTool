import 'package:sqflite/sqflite.dart';
import 'package:xem_xym_tools/databaseHelper.dart';
import 'package:xem_xym_tools/utility/log.dart';

class AppDatabaseMigrationListener implements DatabaseMigrationListener {
  static const int VERSION_1_0_0 = 1;

  @override
  void onCreate(Database db, int version) async {
    Log.info('onCreate version : $version');
    await _createDatabase(db, version);
  }

  @override
  void onUpgrade(Database db, int oldVersion, int newVersion) {
    Log.info('oldVersion : $oldVersion');
    Log.info('newVersion : $newVersion');
  }

  Future<void> _createDatabase(Database db, int version) async {
    if (VERSION_1_0_0 == version) {
      await db.execute(
          'CREATE TABLE wallet_address(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, address TEXT)');
    }
  }
}
