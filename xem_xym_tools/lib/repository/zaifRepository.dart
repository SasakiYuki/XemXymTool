import 'dart:convert' show json;

import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:xem_xym_tools/model/lastPrice.dart';

@JsonSerializable()
class ZaifRepository {
  Future<LastPrice> getXemLastPrice() async {
    var url = Uri.https('api.zaif.jp', '/api/1/last_price/xem_jpy');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> decodedJson = json.decode(response.body);
      return LastPrice.fromJson(decodedJson);
    } else {
      throw Exception('getLastPrice 取得できてませんよ');
    }
  }

  Future<LastPrice> getXymLastPrice() async {
    var url = Uri.https('api.zaif.jp', '/api/1/last_price/xym_jpy');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> decodedJson = json.decode(response.body);
      return LastPrice.fromJson(decodedJson);
    } else {
      throw Exception('getLastPrice 取得できてませんよ');
    }
  }
}
