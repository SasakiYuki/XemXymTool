import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:xem_xym_tools/appProvider.dart';

import 'memoEditBloc.dart';

class MemoEditPage extends StatefulWidget {
  static const String PATH = '/memo_edit';
  static const String MEMO = 'memo';
  final String memo;

  MemoEditPage({Key key, @required this.memo}) : super(key: key);

  @override
  State createState() => _MemoEditState(memo: memo);
}

class _MemoEditState extends State<MemoEditPage> {
  MemoEditBloc _bloc;
  final String memo;
  TextEditingController _controller = TextEditingController();

  _MemoEditState({@required this.memo});

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_bloc == null) {
      _bloc = MemoEditBloc(AppProvider.getApplication(context), memo);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultStickyHeaderController(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'メモ',
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
                Navigator.of(context)
                    .pop({MemoEditPage.MEMO: _controller.text});
              },
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: StreamBuilder<String>(
              stream: _bloc.memo,
              builder: (context, snapshot) {
                var initialMemo = '';
                if (snapshot.hasData) {
                  initialMemo = snapshot.data;
                }
                _controller.value =
                    _controller.value.copyWith(text: initialMemo);
                return TextFormField(
                  controller: _controller,
                  onChanged: (value) {
                    _bloc.changeMemo(value);
                  },
                  style: TextStyle(color: Color(0xDE000000), fontSize: 16),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'メモ',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                );
              }),
        ),
      ),
    );
  }
}
