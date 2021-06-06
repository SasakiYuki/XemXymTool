import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xem_xym_tools/appProvider.dart';
import 'package:xem_xym_tools/ui/address/addressRegistrationBloc.dart';
import 'package:xem_xym_tools/ui/common/spaceBox.dart';

class AddressRegistrationPage extends StatefulWidget {
  static const String PATH = '/address_registration';

  AddressRegistrationPage({Key key}) : super(key: key);

  @override
  State createState() => _AddressRegistrationState();
}

class _AddressRegistrationState extends State<AddressRegistrationPage> {
  final _walletNameController = TextEditingController();
  final _addressController = TextEditingController();
  AddressRegistrationBloc _bloc;

  @override
  void didChangeDependencies() {
    if (_bloc == null) {
      _bloc = AddressRegistrationBloc(AppProvider.getApplication(context));
    }
    _bloc.complete.listen((event) {
      if (event) {
        Navigator.pop(context);
      }
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'アドレスを追加',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.check,
              color: Colors.black,
            ),
            onPressed: () {
              if (_bloc.getAddress().isEmpty) {
                Fluttertoast.showToast(
                    msg: 'アドレスが入力されていません',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Color(0xffB22F3237),
                    textColor: Colors.white,
                    fontSize: 14.0);
              } else if (_bloc.getWalletName().isEmpty) {
                Fluttertoast.showToast(
                    msg: 'ウォレット名が入力されていません',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Color(0xffB22F3237),
                    textColor: Colors.white,
                    fontSize: 14.0);
              } else {
                _bloc.saveAddress();
              }
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              _buildWalletNameTextField(),
              SpaceBox.height(16),
              _buildAddressTextField()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWalletNameTextField() => TextField(
        controller: _walletNameController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: '任意のウォレット名',
        ),
        onChanged: (text) {
          _bloc.changeWalletName(text);
        },
      );

  Widget _buildAddressTextField() => TextField(
        controller: _addressController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'アドレス',
        ),
        onChanged: (text) {
          _bloc.changeAddress(text);
        },
      );
}
