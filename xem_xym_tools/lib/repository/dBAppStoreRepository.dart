import 'package:sqflite/sqflite.dart';
import 'package:xem_xym_tools/model/walletAddress.dart';

class DBAppStoreRepository {
  Database _database;

  DBAppStoreRepository(this._database);

  Future<void> insertWalletAddress(WalletAddress walletAddress) async {
    Map<String, dynamic> maps = walletAddress.toJson();
    await _database.insert(WalletAddress.TABLE_NAME, maps);
  }
}
