import 'package:rxdart/rxdart.dart';
import 'package:xem_xym_tools/appStoreApplication.dart';

class HomeBloc {
  final AppStoreApplication _application;
  final _isShowLoading = BehaviorSubject<bool>();
  final _bottomNavigationState = BehaviorSubject<int>();

  Stream<bool> get isShowLoading => _isShowLoading.stream;

  Stream<int> get bottomNavigationState => _bottomNavigationState.stream;

  HomeBloc(this._application) {
    _bottomNavigationState.add(0);
  }

  void dispose() {
    _isShowLoading.close();
    _bottomNavigationState.close();
  }

  void navigateBottomNavigation(int position) {
    _bottomNavigationState.value = position;
  }
}
