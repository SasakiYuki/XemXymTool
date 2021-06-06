// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'walletAddress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletAddress _$WalletAddressFromJson(Map<String, dynamic> json) {
  return WalletAddress(
    json['name'] as String,
    json['address'] as String,
  )..id = json['id'] as int;
}

Map<String, dynamic> _$WalletAddressToJson(WalletAddress instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
    };
