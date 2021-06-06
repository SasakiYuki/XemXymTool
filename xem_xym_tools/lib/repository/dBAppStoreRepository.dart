import 'package:sqflite/sqflite.dart';
import 'package:xem_xym_tools/model/walletAddress.dart';

class DBAppStoreRepository {
  Database _database;

  DBAppStoreRepository(this._database);

  Future<void> insertWalletAddress(WalletAddress walletAddress) async {
    Map<String, dynamic> maps = walletAddress.toJson();
    await _database.insert(WalletAddress.TABLE_NAME, maps);
  }

  Future<List<WalletAddress>> loadWalletAddresses() async {
    List<Map> list = await _database.rawQuery(
        'SELECT * FROM ${WalletAddress.TABLE_NAME} ORDER BY `id` ASC');

    return list.map((e) => WalletAddress.fromJson(e)).toList();
  }

  Future<List<WalletAddress>> queryWalletAddress(String text) async {
    List<Map> list;
    if (text != null && text.isNotEmpty) {
      list = await _database.rawQuery(
          "SELECT * FROM ${WalletAddress.TABLE_NAME} WHERE address LIKE '$text%' ORDER BY `id` ASC");
    } else {
      list = await _database.rawQuery(
          "SELECT * FROM ${WalletAddress.TABLE_NAME} ORDER BY `id` ASC");
    }
    return list.map((e) => WalletAddress.fromJson(e)).toList();
  }
}
