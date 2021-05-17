import 'package:rxdart/rxdart.dart';
import 'package:xem_xym_tools/appStoreApplication.dart';
import 'package:xem_xym_tools/model/lastPrice.dart';

class DashboardBloc {
  final AppStoreApplication _application;
  final _compositeSubscription = CompositeSubscription();

  final _lastPrice = BehaviorSubject<LastPrice>();

  Stream<LastPrice> get lastPrice => _lastPrice.stream;

  DashboardBloc(this._application) {
    _init();
  }

  void dispose() {
    _lastPrice.close();
  }

  void _init() {
    getLastPrice();
  }

  void getLastPrice() async {
    final subscription =
        Observable.fromFuture(_application.zaifRepository.getLastPrice())
            .listen((event) {
      _lastPrice.value = event;
    });
    _compositeSubscription.add(subscription);
  }
}
