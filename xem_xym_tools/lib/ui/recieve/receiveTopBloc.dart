import 'package:rxdart/rxdart.dart';
import 'package:xem_xym_tools/appStoreApplication.dart';

class ReceiveTopBloc {
  final AppStoreApplication _application;
  final _compositeSubscription = CompositeSubscription();

  ReceiveTopBloc(this._application) {
    _init();
  }

  final _amount = BehaviorSubject<double>();
  final _isXymMode = BehaviorSubject<bool>();

  Stream<double> get amount => _amount.stream;

  Stream<bool> get isXymMode => _isXymMode.stream;

  void _init() {
    _amount.add(0);
    _isXymMode.add(false);
  }

  void dispose() {
    _amount.close();
    _isXymMode.close();
  }

  void changeXymMode(bool isXymMode) {
    _isXymMode.add(isXymMode);
  }

  void changeAmount(double amount) {
    _amount.add(amount);
  }
}
