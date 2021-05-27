import 'package:rxdart/rxdart.dart';
import 'package:xem_xym_tools/appStoreApplication.dart';
import 'package:xem_xym_tools/model/lastPrice.dart';

class ReceiveAmountBloc {
  final AppStoreApplication _application;
  final _compositeSubscription = CompositeSubscription();

  final _xemLastPrice = BehaviorSubject<LastPrice>();
  final _xymLastPrice = BehaviorSubject<LastPrice>();
  final _amount = BehaviorSubject<int>();
  final _currentCurrencyAmount = BehaviorSubject<String>();
  final _isXymMode = BehaviorSubject<bool>();

  Stream<LastPrice> get xemLastPrice => _xemLastPrice.stream;

  Stream<LastPrice> get xymLastPrice => _xymLastPrice.stream;

  Stream<int> get amount => _amount.stream;

  Stream<bool> get isXymMode => _isXymMode.stream;

  Stream<String> get currentCurrencyAmount => _currentCurrencyAmount.stream;

  ReceiveAmountBloc(this._application) {
    _init();
  }

  void _init() {
    _isXymMode.add(true);
    getXemLastPrice();
    getXymLastPrice();
    _amount.add(0);
    _currentCurrencyAmount.add('0円 = 0 XYM');
  }

  void dispose() {
    _xymLastPrice.close();
    _xemLastPrice.close();
    _isXymMode.close();
  }

  void getXemLastPrice() async {
    final subscription =
        Observable.fromFuture(_application.zaifRepository.getXemLastPrice())
            .listen((event) {
      _xemLastPrice.value = event;
    });
    _compositeSubscription.add(subscription);
  }

  void getXymLastPrice() async {
    final subscription =
        Observable.fromFuture(_application.zaifRepository.getXymLastPrice())
            .listen((event) {
      _xymLastPrice.value = event;
    });
    _compositeSubscription.add(subscription);
  }

  void changeXymMode() {
    var isXymMode = !_isXymMode.value;
    _isXymMode.add(isXymMode);
    var amount = _amount.value;
    if (isXymMode) {
      var xymPrice = _xymLastPrice.value;
      // 100円 / 25円/1xym = 4xym
      var price = (amount / xymPrice.lastPrice).toStringAsFixed(4);
      var text = '$amount円 = $price XYM';
      _currentCurrencyAmount.add(text);
    } else {
      var xemPrice = _xemLastPrice.value;
      var price = (amount / xemPrice.lastPrice).toStringAsFixed(4);
      var text = '$amount円 = $price XEM';
      _currentCurrencyAmount.add(text);
    }
  }

  void changeAmount(int amount) {
    _amount.add(amount);
    var isXymMode = _isXymMode.value;
    if (isXymMode) {
      var xymPrice = _xymLastPrice.value;
      var price = (amount / xymPrice.lastPrice).toStringAsFixed(4);
      var text = '$amount円 = $price XYM';
      _currentCurrencyAmount.add(text);
    } else {
      var xemPrice = _xemLastPrice.value;
      var price = (amount / xemPrice.lastPrice).toStringAsFixed(4);
      var text = '$amount円 = $price XEM';
      _currentCurrencyAmount.add(text);
    }
  }

  bool getXymMode() => _isXymMode.value;

  int getAmount() => _amount.value;

  double getAmountFromYen() {
    var amount = getAmount();
    var isXymMode = _isXymMode.value;
    if (isXymMode) {
      var xymPrice = _xymLastPrice.value;
      var price = (amount / xymPrice.lastPrice).toStringAsFixed(4);
      return double.parse(price);
    } else {
      var xemPrice = _xemLastPrice.value;
      var price = (amount / xemPrice.lastPrice).toStringAsFixed(4);
      return double.parse(price);
    }
  }
}
