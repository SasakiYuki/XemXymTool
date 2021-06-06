import 'package:json_annotation/json_annotation.dart';

part 'walletAddress.g.dart';

@JsonSerializable()
class WalletAddress {
  static final String TABLE_NAME = 'wallet_address';

  int id = 0;
  final String name;
  final String address;

  WalletAddress(this.name, this.address);

  factory WalletAddress.fromJson(Map<String, dynamic> json) =>
      _$WalletAddressFromJson(json);

  Map<String, dynamic> toJson() => _$WalletAddressToJson(this);
}
