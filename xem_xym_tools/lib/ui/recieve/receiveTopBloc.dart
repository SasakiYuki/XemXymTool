
import 'package:rxdart/rxdart.dart';
import 'package:xem_xym_tools/appStoreApplication.dart';

class ReceiveTopBloc {
 final AppStoreApplication _application;
 final _compositeSubscription = CompositeSubscription();

 ReceiveTopBloc(this._application);

}