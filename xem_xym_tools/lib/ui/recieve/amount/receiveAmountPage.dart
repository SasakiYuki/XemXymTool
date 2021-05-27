import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xem_xym_tools/appProvider.dart';
import 'package:xem_xym_tools/model/lastPrice.dart';
import 'package:xem_xym_tools/ui/common/spaceBox.dart';
import 'package:xem_xym_tools/ui/recieve/amount/receiveAmountBloc.dart';
import 'package:xem_xym_tools/utility/sizeConfig.dart';

class ReceiveAmountPage extends StatefulWidget {
  static const String PATH = '/receive_amount';
  static const String IS_XYM_MODE = 'is_xym_mode';
  static const String AMOUNT = 'amount';

  ReceiveAmountPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ReceiveAmountState();
}

class _ReceiveAmountState extends State<ReceiveAmountPage>
    with SingleTickerProviderStateMixin {
  ReceiveAmountBloc _bloc;
  TabController _tabController;
  TextEditingController _amountEditingController = TextEditingController();
  TextEditingController _xemXymEditingController = TextEditingController();
  Image _xymAssetImage =
      Image(width: 30, height: 30, image: AssetImage('images/symbol.png'));
  Image _xemAssetImage =
      Image(width: 30, height: 30, image: AssetImage('images/nem.png'));

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _init();
  }

  void _init() {
    if (_bloc == null) {
      _bloc = ReceiveAmountBloc(AppProvider.getApplication(context));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (context, value) {
          return [
            SliverAppBar(
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    var isXymMode = _bloc.getXymMode();
                    var amount = 0.0;
                    if (_tabController.index == 0) {
                      amount = _bloc.getAmountFromYen();
                    } else {
                      amount = double.parse(_xemXymEditingController.text);
                    }
                    Navigator.of(context).pop({
                      ReceiveAmountPage.IS_XYM_MODE: isXymMode,
                      ReceiveAmountPage.AMOUNT: amount
                    });
                  },
                )
              ],
              iconTheme: IconThemeData(color: Colors.white),
              title: Text(
                'Enter Amount',
                style: TextStyle(color: Colors.white),
              ),
              bottom: PreferredSize(
                  preferredSize: Size.fromHeight(getProportionHeight(48)),
                  child: _buildTabsRow()),
            ),
          ];
        },
        body: _tabBody(),
      ));

  Widget _tabBody() {
    return TabBarView(
      controller: _tabController,
      children: [_buildYenBody(), _buildXemXymBody()],
    );
  }

  Widget _buildXemXymBody() => Column(
        children: [
          SpaceBox.height(8),
          Container(
            child: _buildXemXymTextField(),
          ),
          SpaceBox.height(32),
          _buildWatchListHeader(),
          SpaceBox.height(8),
          _buildDivider(),
          _buildXemWatchListRow(),
          _buildDivider(),
          _buildXymWatchListRow(),
          _buildDivider(),
        ],
      );

  Widget _buildXemXymTextField() => StreamBuilder<bool>(
      stream: _bloc.isXymMode,
      builder: (context, snapshot) {
        var suffix = '';
        if (snapshot.hasData) {
          if (snapshot.data) {
            suffix = 'ＸＹＭ';
          } else {
            suffix = 'ＸＥＭ';
          }
        }
        return TextField(
            onChanged: (text) {},
            controller: _xemXymEditingController,
            inputFormatters: [ThousandsSeparatorInputFormatter()],
            keyboardType: TextInputType.number,
            style: TextStyle(
              fontSize: 30,
            ),
            decoration: InputDecoration(
              isDense: true,
              suffixIcon: Text(
                suffix,
                style: TextStyle(fontSize: 30),
              ),
              prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
            ),
            textAlign: TextAlign.right);
      });

  Widget _buildYenBody() => Column(
        children: [
          SpaceBox.height(8),
          Container(
            child: TextField(
                onChanged: (text) {
                  final replace = text.replaceAll(',', '');
                  if (replace.isEmpty) {
                    _bloc.changeAmount(0);
                  } else {
                    _bloc.changeAmount(int.parse(replace));
                  }
                },
                controller: _amountEditingController,
                inputFormatters: [ThousandsSeparatorInputFormatter()],
                keyboardType: TextInputType.number,
                style: TextStyle(
                  fontSize: 30,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  suffixIcon: Text(
                    "円",
                    style: TextStyle(fontSize: 30),
                  ),
                  prefixIconConstraints:
                      BoxConstraints(minWidth: 0, minHeight: 0),
                ),
                textAlign: TextAlign.right),
          ),
          SpaceBox.height(32),
          _buildWatchListHeader(),
          SpaceBox.height(8),
          _buildDivider(),
          _buildXemWatchListRow(),
          _buildDivider(),
          _buildXymWatchListRow(),
          _buildDivider(),
          _buildPaymentsRow(),
          _buildDivider(),
        ],
      );

  Widget _buildWatchListHeader() => Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          left: 16,
        ),
        child: Text(
          'Information',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
        ),
      );

  Widget _buildXemWatchListRow() => StreamBuilder<bool>(
      stream: _bloc.isXymMode,
      builder: (context, snapshot) {
        var isXymMode = false;
        if (snapshot.hasData) {
          isXymMode = snapshot.data;
        }
        return Visibility(
          visible: !isXymMode,
          child: StreamBuilder<LastPrice>(
              stream: _bloc.xemLastPrice,
              builder: (context, snapshot) {
                var value = 0.0;
                if (snapshot.hasData) {
                  value = snapshot.data.lastPrice;
                }
                return Container(
                    margin: EdgeInsets.only(left: 8, right: 8),
                    child: ListTile(
                      leading: _xemAssetImage,
                      title: Text(
                        '現在価格: $value円 / 1XEM',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xDE000000)),
                      ),
                    ));
              }),
        );
      });

  Widget _buildXymWatchListRow() => StreamBuilder<bool>(
      stream: _bloc.isXymMode,
      builder: (context, snapshot) {
        var isXymMode = false;
        if (snapshot.hasData) {
          isXymMode = snapshot.data;
        }
        return Visibility(
          visible: isXymMode,
          child: StreamBuilder<LastPrice>(
              stream: _bloc.xymLastPrice,
              builder: (context, snapshot) {
                var value = 0.0;
                if (snapshot.hasData) {
                  value = snapshot.data.lastPrice;
                }
                return Container(
                    margin: EdgeInsets.only(left: 8, right: 8),
                    child: ListTile(
                      leading: _xymAssetImage,
                      title: Text(
                        '現在価格: $value円 / 1XYM',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xDE000000)),
                      ),
                    ));
              }),
        );
      });

  Widget _buildPaymentsRow() => StreamBuilder<String>(
      stream: _bloc.currentCurrencyAmount,
      builder: (context, snapshot) {
        var text = '';
        if (snapshot.hasData) {
          text = snapshot.data;
        }
        return Container(
            margin: EdgeInsets.only(left: 8, right: 8),
            child: ListTile(
              leading: Icon(
                Icons.payments,
              ),
              title: Text(
                text,
                style: TextStyle(fontSize: 16, color: Color(0xDE000000)),
              ),
            ));
      });

  Widget _buildTabsRow() {
    return Stack(
      children: [_buildTabTitles(), _buildTabActions()],
    );
  }

  Widget _buildDivider() => Divider(
        color: Color(0x14212121),
        height: 1,
        thickness: 1,
        indent: 0,
        endIndent: 0,
      );

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
                color: Colors.white,
              )),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            tabs: [
              _tabTitle('円'),
              _tabTitle('XEM/XYM'),
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
          InkWell(
            onTap: () => {_bloc.changeXymMode()},
            child: Padding(
              padding: EdgeInsets.only(
                  right: getProportionWidth(20),
                  left: getProportionWidth(20),
                  top: getProportionWidth(10),
                  bottom: getProportionWidth(10)),
              child: const Icon(
                Icons.multiple_stop,
                color: Colors.white,
              ),
            ),
          )
        ],
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

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  static const separator = ',';

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length == 0) {
      return newValue.copyWith(text: '');
    }

    String oldValueText = oldValue.text.replaceAll(separator, '');
    String newValueText = newValue.text.replaceAll(separator, '');

    if (oldValue.text.endsWith(separator) &&
        oldValue.text.length == newValue.text.length + 1) {
      newValueText = newValueText.substring(0, newValueText.length - 1);
    }

    if (oldValueText != newValueText) {
      int selectionIndex =
          newValue.text.length - newValue.selection.extentOffset;
      final chars = newValueText.split('');

      String newString = '';
      for (int i = chars.length - 1; i >= 0; i--) {
        if ((chars.length - 1 - i) % 3 == 0 && i != chars.length - 1)
          newString = separator + newString;
        newString = chars[i] + newString;
      }

      return TextEditingValue(
        text: newString.toString(),
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndex,
        ),
      );
    }

    return newValue;
  }
}
