import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xem_xym_tools/appProvider.dart';
import 'package:xem_xym_tools/model/lastPrice.dart';
import 'package:xem_xym_tools/ui/address/addressRegistrationPage.dart';
import 'package:xem_xym_tools/ui/common/spaceBox.dart';
import 'package:xem_xym_tools/ui/dashboard/dashboardBloc.dart';
import 'package:xem_xym_tools/utility/sizeConfig.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key}) : super(key: key);

  @override
  State createState() => _DashboardState();
}

class _DashboardState extends State<DashboardPage> {
  DashboardBloc _bloc;

  @override
  void didChangeDependencies() {
    _init();
  }

  void _init() {
    SizeConfig().init(context);
    if (null == _bloc) {
      _bloc = DashboardBloc(AppProvider.getApplication(context));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              _buildHeader(),
              _buildSpaceBoxHeight(16),
              _buildMenuRow(),
              _buildSpaceBoxHeight(32),
              _buildWatchListHeader(),
              _buildSpaceBoxHeight(8),
              _buildDivider(),
              _buildXemWatchListRow(),
              _buildDivider(),
              _buildXymWatchListRow()
            ],
          ),
        ),
      );

  Widget _buildSpaceBoxHeight(double height) => SliverToBoxAdapter(
        child: SpaceBox.height(height),
      );

  Widget _buildHeader() => SliverToBoxAdapter(
        child: Container(
          color: Colors.amber,
          child: Column(
            children: [
              Row(
                children: [
                  SpaceBox.width(8),
                  Text(
                    'Oh,Hello! NemBear.',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
              SpaceBox.height(6),
              Row(
                children: [
                  SpaceBox.width(8),
                  Text(
                    'Welcome to Symbull',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  )
                ],
              ),
              SpaceBox.height(16),
              Container(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: const Text(
                      'Get started with Address',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.blueAccent),
                    onPressed: () {
                      AppProvider.getRouter(context).navigateTo(
                          context, AddressRegistrationPage.PATH,
                          transition: TransitionType.native);
                    },
                  ),
                ),
              ),
              SpaceBox.height(8)
            ],
          ),
        ),
      );

  Widget _buildMenuRow() => SliverToBoxAdapter(
        child: Container(
          margin: EdgeInsets.only(left: 8, right: 8),
          padding: EdgeInsets.only(top: 20, bottom: 20, left: 20),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Menu List',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        ],
                      ),
                      SpaceBox.height(8),
                      Text(
                        'Any sufficiently advanced technology is indistinguishable from magic.',
                        style: TextStyle(color: Colors.white54, fontSize: 13),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SvgPicture.asset(
                  'assets/top_menu.svg',
                  height: 130,
                ),
              )
            ],
          ),
        ),
      );

  Widget _buildWatchListHeader() => SliverToBoxAdapter(
        child: Container(
          margin: EdgeInsets.only(
            left: 8,
          ),
          child: Text(
            'WatchList',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
          ),
        ),
      );

  Widget _buildXymWatchListRow() => StreamBuilder<LastPrice>(
      stream: _bloc.xymLastPrice,
      builder: (context, snapshot) {
        var text = '';
        if (snapshot.hasData) {
          text = snapshot.data.lastPrice.toString();
        }
        return SliverToBoxAdapter(
          child: Container(
              margin: EdgeInsets.only(left: 8, right: 8),
              child: ListTile(
                leading: Image(
                  width: 30,
                  height: 30,
                  image: AssetImage(
                    'images/symbol.png',
                  ),
                ),
                title: Text(
                  'XYM',
                  style: TextStyle(fontSize: 16, color: Color(0xDE000000)),
                ),
                trailing: Text(
                  '$text円',
                  style: TextStyle(fontSize: 16, color: Color(0xDE000000)),
                ),
              )),
        );
      });

  Widget _buildXemWatchListRow() => StreamBuilder<LastPrice>(
      stream: _bloc.lastPrice,
      builder: (context, snapshot) {
        var text = '';
        if (snapshot.hasData) {
          text = snapshot.data.lastPrice.toString();
        }
        return SliverToBoxAdapter(
          child: Container(
              margin: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
              child: ListTile(
                leading: Image(
                  width: 30,
                  height: 30,
                  image: AssetImage(
                    'images/nem.png',
                  ),
                ),
                title: Text(
                  'XEM',
                  style: TextStyle(fontSize: 16, color: Color(0xDE000000)),
                ),
                trailing: Text(
                  '$text円',
                  style: TextStyle(fontSize: 16, color: Color(0xDE000000)),
                ),
              )),
        );
      });

  Widget _buildDivider() => SliverToBoxAdapter(
        child: Divider(
          color: Color(0x14212121),
          height: 1,
          thickness: 1,
          indent: 0,
          endIndent: 0,
        ),
      );
}
