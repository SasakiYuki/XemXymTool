import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:xem_xym_tools/appStoreApplication.dart';
import 'package:xem_xym_tools/model/walletAddress.dart';

class AddressSelectBloc {
  final AppStoreApplication _application;
  final _compositeSubscription = CompositeSubscription();

  final _searchText = BehaviorSubject<String>();
  final _walletAddresses = BehaviorSubject<List<WalletAddress>>();

  Stream<List<WalletAddress>> get walletAddresses => _walletAddresses.stream;

  AddressSelectBloc(this._application) {
    _init();
  }

  void _init() {
    changeSearchText('');
  }

  void dispose() {
    _searchText.close();
    _walletAddresses.close();
  }

  void changeSearchText(String event) {
    _searchText.add(event);
    _getAddresses();
  }

  void _getAddresses() {
    StreamSubscription subscription = Observable.fromFuture(_application
            .dbAppStoreRepository
            .queryWalletAddress(_searchText.value))
        .listen((event) {
      _walletAddresses.add(event);
    });
    _compositeSubscription.add(subscription);
  }
}
