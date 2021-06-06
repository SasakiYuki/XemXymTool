import 'package:rxdart/rxdart.dart';
import 'package:xem_xym_tools/appStoreApplication.dart';

class MemoEditBloc {
  final AppStoreApplication _application;

  CompositeSubscription _compositeSubscription = CompositeSubscription();

  final _memo = BehaviorSubject<String>();

  Stream<String> get memo => _memo.stream;

  MemoEditBloc(this._application, String memo) {
    _init(memo);
  }

  void _init(String memo) {
    _memo.add(memo);
  }

  void dispose() {
    _memo.close();
  }

  void changeMemo(String memo) {
    _memo.add(memo);
  }
}
