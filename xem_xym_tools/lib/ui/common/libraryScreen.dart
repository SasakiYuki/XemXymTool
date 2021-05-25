import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xem_xym_tools/utility/sizeConfig.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key key}) : super(key: key);

  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (context, value) {
              return [
                SliverAppBar(
                    title: Text('Library'),
                    bottom: PreferredSize(
                        preferredSize: Size.fromHeight(getProportionHeight(48)),
                        child: _buildTabsRow())),
              ];
            },
            body: _tabBody()));
  }

  Widget _tabBody() {
    return TabBarView(
      controller: _tabController,
      children: [
        Container(child: Center(child: Icon(Icons.car_rental))),
        Container(child: Center(child: Icon(Icons.car_rental))),
        Container(child: Center(child: Icon(Icons.car_rental))),
      ],
    );
  }

  Widget _buildTabsRow() {
    return Stack(
      children: [
        _buildTabTitles(),
        _buildTabActions() // 並び替えとフィルターのactions
      ],
    );
  }

  // タブの左寄せタイトル郡
  Widget _buildTabTitles() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                width: getProportionWidth(3),
                color: Colors.black,
              )),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            tabs: [
              _tabTitle('Car'),
              _tabTitle('Bike'),
              _tabTitle('Walk'),
            ],
          ),
        ),
        Expanded(flex: 2, child: Container()),
      ],
    );
  }

  Widget _buildTabActions() {
    return Container(
      // tab height
      height: getProportionWidth(40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _tabAction(
              icon: const Icon(Icons.sort_outlined, color: Colors.white),
              onTap: () {}),
          _tabAction(
              icon: const Icon(Icons.filter_alt_outlined, color: Colors.white),
              onTap: () {}),
        ],
      ),
    );
  }

  Widget _tabAction({@required Icon icon, @required Function onTap}) {
    return Padding(
      padding: EdgeInsets.only(right: getProportionWidth(20)),
      child: GestureDetector(
        onTap: () => onTap,
        child: icon,
      ),
    );
  }

  Widget _tabTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionWidth(6)),
      child: Container(
        height: getProportionHeight(40),
        width: getProportionWidth(132),
        child: Tab(text: title),
      ),
    );
  }

  double getProportionHeight(double inputHeight) {
    final screenHeight = SizeConfig.screenHeight;
    return (inputHeight / 812.0) * screenHeight;
  }

  double getProportionWidth(double inputWidth) {
    final screenWidth = SizeConfig.screenWidth;
    return (inputWidth / 375.0) * screenWidth;
  }
}
