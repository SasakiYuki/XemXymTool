import 'package:flutter/material.dart';

import '../appProvider.dart';
import 'homeBloc.dart';

class HomePage extends StatefulWidget {
  static const String PATH = '/';

  HomePage({Key key}) : super(key: key);

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc bloc;

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text(""),
    );
  }

  void _init() {
    if (null == bloc) {
      bloc = HomeBloc(AppProvider.getApplication(context));
      bloc.isShowLoading.listen((bool isLoading) {
        if (isLoading) {
          // TODO
        } else {
          // TODO
        }
      });
      // load
    }
  }
}
