import 'package:flutter/material.dart';

import '../appProvider.dart';
import 'dashboard/dashboardPage.dart';
import 'homeBloc.dart';

class HomePage extends StatefulWidget {
  static const String PATH = '/';

  HomePage({Key key}) : super(key: key);

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _init();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<int>(
        stream: _bloc.bottomNavigationState,
        builder: (_, snapshot) {
          final index = snapshot.hasData ? snapshot.data : 0;

          List<Widget> _pageList = [
            DashboardPage(),
          ];

          return Scaffold(
            body: _pageList[index],
            bottomNavigationBar: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              currentIndex: index,
              items: [
                _buildBottomNavigationBarItem(0, 'HOME', index),
                _buildBottomNavigationBarItem(1, 'RECEIVE', index),
                _buildBottomNavigationBarItem(2, 'HOME', index),
                _buildBottomNavigationBarItem(3, 'HOME', index),
              ],
              onTap: (value) => _bloc.navigateBottomNavigation(value),
            ),
          );
        },
      );

  void _init() {
    if (null == _bloc) {
      _bloc = HomeBloc(AppProvider.getApplication(context));
      _bloc.isShowLoading.listen((bool isLoading) {
        if (isLoading) {
          // TODO
        } else {
          // TODO
        }
      });
      // load
    }
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      num position, String title, int currentIndex) {
    var selectedColor = Colors.amber;
    var unselectedColor = Colors.black38;
    var icon;
    switch (position) {
      case 0:
        icon = Icons.home;
        break;
      case 1:
        icon = Icons.qr_code;
        break;
      case 2:
        icon = Icons.ac_unit;
        break;
      case 3:
        icon = Icons.person_rounded;
        break;
    }
    return BottomNavigationBarItem(
        icon: Icon(icon,
            color: currentIndex == position ? selectedColor : unselectedColor),
        label: title);
  }
}
