import 'package:rxdart/rxdart.dart';
import 'package:xem_xym_tools/appStoreApplication.dart';
import 'package:xem_xym_tools/model/walletAddress.dart';

class ReceiveTopBloc {
  final AppStoreApplication _application;
  final _compositeSubscription = CompositeSubscription();

  ReceiveTopBloc(this._application) {
    _init();
  }

  final _amount = BehaviorSubject<double>();
  final _isXymMode = BehaviorSubject<bool>();
  final _selectedWalletAddress = BehaviorSubject<WalletAddress>();
  final _memo = BehaviorSubject<String>();

  Stream<double> get amount => _amount.stream;

  Stream<bool> get isXymMode => _isXymMode.stream;

  Stream<WalletAddress> get selectedWalletAddress =>
      _selectedWalletAddress.stream;

  Stream<String> get memo => _memo.stream;

  void _init() {
    _amount.add(0);
    _isXymMode.add(false);
    _selectedWalletAddress.add(null);
    _memo.add('');
  }

  void dispose() {
    _amount.close();
    _isXymMode.close();
    _selectedWalletAddress.close();
    _memo.close();
  }

  void changeXymMode(bool isXymMode) {
    _isXymMode.add(isXymMode);
  }

  void changeAmount(double amount) {
    _amount.add(amount);
  }

  void changeSelectedWalletAddress(WalletAddress walletAddress) {
    _selectedWalletAddress.add(walletAddress);
  }

  void changeMemo(String memo) {
    _memo.add(memo);
  }

  String getMemo() => _memo.value;
}
