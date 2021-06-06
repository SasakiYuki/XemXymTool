import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_svg/svg.dart';
import 'package:xem_xym_tools/appProvider.dart';
import 'package:xem_xym_tools/model/walletAddress.dart';
import 'package:xem_xym_tools/ui/common/spaceBox.dart';
import 'package:xem_xym_tools/ui/recieve/address/addressSelectBloc.dart';

class AddressSelectPage extends StatefulWidget {
  static const String PATH = '/address_select';
  static const String ADDRESS = 'address';

  AddressSelectPage({Key key}) : super(key: key);

  @override
  State createState() => _AddressSelectPage();
}

class _AddressSelectPage extends State<AddressSelectPage> {
  AddressSelectBloc _bloc;
  SearchBar searchBar;
  var _memoController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _AddressSelectPage() {
    searchBar = new SearchBar(
      inBar: false,
      buildDefaultAppBar: buildAppBar,
      setState: setState,
      onChanged: onChanged,
    );
  }

  @override
  void didChangeDependencies() {
    _init();
  }

  void _init() {
    if (_bloc == null) {
      _bloc = AddressSelectBloc(AppProvider.getApplication(context));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultStickyHeaderController(
        child: new Scaffold(
            appBar: searchBar.build(context),
            key: _scaffoldKey,
            body: StreamBuilder<List<WalletAddress>>(
              stream: _bloc.walletAddresses,
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data;
                  if (data.isEmpty) {
                    return _buildEmptyView();
                  }
                  return CustomScrollView(slivers: [_buildList(data)]);
                } else {
                  return _buildEmptyView();
                }
              },
            )));
  }

  Widget _buildEmptyView() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/empty_kun.svg',
            height: 130,
          ),
          SpaceBox.height(25),
          Text(
            'まだアドレスが追加されていません',
            style: TextStyle(fontSize: 16, color: Color(0x61000000)),
          ),
          SpaceBox.height(16),
          Text(
            'Top画面から追加できます',
            style:
                TextStyle(fontSize: 14, color: Color(0x61000000), height: 0.7),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  SliverStickyHeader _buildList(List<WalletAddress> data) {
    return SliverStickyHeader(
      header: SpaceBox.height(0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
            (context, index) => _buildRow(index, data[index]),
            childCount: data.length),
      ),
    );
  }

  Widget _buildRow(int index, WalletAddress walletAddress) {
    return InkWell(
        onTap: () {
          Navigator.of(context).pop({AddressSelectPage.ADDRESS: walletAddress});
        },
        child: Container(
          margin: EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                walletAddress.name,
                style: TextStyle(fontSize: 18, color: Color(0xDE000000)),
              ),
              SpaceBox.height(4),
              Text(
                walletAddress.address,
                style: TextStyle(fontSize: 12, color: Color(0xDE000000)),
              ),
            ],
          ),
        ));
  }

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
      backgroundColor: Colors.white,
      leading: GestureDetector(
        child: Icon(Icons.close, color: Colors.black),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      titleSpacing: 0.0,
      title: TextFormField(
          controller: _memoController,
          decoration: const InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: 'アドレス',
          ),
          onChanged: (value) {
            _bloc.changeSearchText(value);
          }),
    );
  }

  void onChanged(String value) {
    _bloc.changeSearchText(value);
  }
}
