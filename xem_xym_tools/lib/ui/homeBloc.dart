import 'package:rxdart/rxdart.dart';
import 'package:xem_xym_tools/appStoreApplication.dart';

class HomeBloc {
  final AppStoreApplication _application;
  final _isShowLoading = BehaviorSubject<bool>();

  Stream<bool> get isShowLoading => _isShowLoading.stream;

  HomeBloc(this._application) {}

  void dispose() {
    _isShowLoading.close();
  }
}
