import 'package:rxdart/rxdart.dart';
import 'package:xem_xym_tools/appStoreApplication.dart';
import 'package:xem_xym_tools/model/lastPrice.dart';

class DashboardBloc {
  final AppStoreApplication _application;
  final _compositeSubscription = CompositeSubscription();

  final _lastPrice = BehaviorSubject<LastPrice>();
  final _xymLastPrice = BehaviorSubject<LastPrice>();

  Stream<LastPrice> get lastPrice => _lastPrice.stream;

  Stream<LastPrice> get xymLastPrice => _xymLastPrice.stream;

  DashboardBloc(this._application) {
    _init();
  }

  void dispose() {
    _lastPrice.close();
    _xymLastPrice.close();
  }

  void _init() {
    getLastPrice();
    getXymLastPrice();
  }

  void getLastPrice() async {
    final subscription =
        Observable.fromFuture(_application.zaifRepository.getXemLastPrice())
            .listen((event) {
      _lastPrice.value = event;
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
}
