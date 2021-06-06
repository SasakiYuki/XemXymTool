import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:xem_xym_tools/appStoreApplication.dart';
import 'package:xem_xym_tools/model/walletAddress.dart';

class AddressRegistrationBloc {
  final AppStoreApplication _application;
  final _compositeSubscription = CompositeSubscription();

  final _address = BehaviorSubject<String>();
  final _walletName = BehaviorSubject<String>();
  final _complete = BehaviorSubject<bool>();

  Stream<String> get address => _address.stream;

  Stream<String> get walletName => _walletName.stream;

  Stream<bool> get complete => _complete.stream;

  AddressRegistrationBloc(this._application) {
    _init();
  }

  void _init() {
    _address.add('');
    _walletName.add('');
    _complete.add(false);
  }

  void dispose() {
    _address.close();
    _walletName.close();
    _complete.close();
  }

  void changeAddress(String address) {
    _address.add(address);
  }

  String getAddress() => _address.value;

  String getWalletName() => _walletName.value;

  void changeWalletName(String walletName) {
    _walletName.add(walletName);
  }

  void saveAddress() async {
    var walletAddress = WalletAddress(_walletName.value, _address.value);

    StreamSubscription subscription = Observable.fromFuture(_application
            .dbAppStoreRepository
            .insertWalletAddress(walletAddress))
        .listen((event) {
      _complete.add(true);
    });
    _compositeSubscription.add(subscription);
  }
}
