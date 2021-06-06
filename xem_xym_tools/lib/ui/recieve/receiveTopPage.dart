import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:xem_xym_tools/appProvider.dart';
import 'package:xem_xym_tools/model/generateType.dart';
import 'package:xem_xym_tools/model/walletAddress.dart';
import 'package:xem_xym_tools/ui/common/spaceBox.dart';
import 'package:xem_xym_tools/ui/recieve/address/addressSelectPage.dart';
import 'package:xem_xym_tools/ui/recieve/amount/receiveAmountPage.dart';
import 'package:xem_xym_tools/ui/recieve/memo/memoEditPage.dart';
import 'package:xem_xym_tools/ui/recieve/receiveTopBloc.dart';

class ReceiveTopPage extends StatefulWidget {
  ReceiveTopPage({Key key}) : super(key: key);

  @override
  State createState() => _ReceiveTopState();
}

class _ReceiveTopState extends State<ReceiveTopPage> {
  ReceiveTopBloc _bloc;
  List<GenerateType> generateTypes = GenerateType.values;

  @override
  void didChangeDependencies() {
    _init();
  }

  void _init() {
    if (_bloc == null) {
      _bloc = ReceiveTopBloc(AppProvider.getApplication(context));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white70,
          elevation: 0,
          title: Text('QR Generator'),
        ),
        body: CustomScrollView(
          slivers: [
            _buildQrImage(),
            _buildSpaceBoxHeight(8),
            _buildDivider(),
            _buildAddress(),
            _buildDivider(),
            _buildAmount(),
            _buildDivider(),
            _buildMessage(),
            _buildDivider(),
          ],
        ),
      );

  Widget _buildQrImage() => SliverToBoxAdapter(
        child: Center(
          child: QrImage(
            data: '123455',
            version: QrVersions.auto,
            size: 140,
          ),
        ),
      );

  Widget _buildAddress() => SliverToBoxAdapter(
        child: InkWell(
          onTap: () async {
            Map result = await AppProvider.getRouter(context).navigateTo(
                context, AddressSelectPage.PATH,
                transition: TransitionType.native);
            if (result != null &&
                result.containsKey(AddressSelectPage.ADDRESS)) {
              _bloc.changeSelectedWalletAddress(
                  result[AddressSelectPage.ADDRESS]);
            }
          },
          child: Container(
            child: ListTile(
              leading: Icon(
                Icons.menu_book,
                color: Colors.amber,
                size: 24,
              ),
              title: StreamBuilder<WalletAddress>(
                  stream: _bloc.selectedWalletAddress,
                  builder: (context, snapshot) {
                    var text = 'Select Address';
                    if (snapshot.data != null) {
                      text = snapshot.data.address;
                    }
                    return Text(
                      text,
                      style: TextStyle(fontSize: 14, color: Color(0x99000000)),
                    );
                  }),
            ),
          ),
        ),
      );

  Widget _buildAmount() => SliverToBoxAdapter(
        child: InkWell(
          onTap: () async {
            Map results = await AppProvider.getRouter(context).navigateTo(
                context, ReceiveAmountPage.PATH,
                transition: TransitionType.native);

            if (results != null) {
              if (results.containsKey(ReceiveAmountPage.IS_XYM_MODE)) {
                _bloc.changeXymMode(results[ReceiveAmountPage.IS_XYM_MODE]);
              }
              if (results.containsKey(ReceiveAmountPage.AMOUNT)) {
                _bloc.changeAmount(results[ReceiveAmountPage.AMOUNT]);
              }
            }
          },
          child: Container(
            child: ListTile(
              leading: Icon(
                Icons.payments,
                color: Colors.amber,
                size: 24,
              ),
              title: StreamBuilder<double>(
                  stream: _bloc.amount,
                  builder: (context, snapshot) {
                    var text = 'Amount';
                    var amount = 0.0;
                    if (snapshot.hasData) {
                      if (snapshot.data != 0) {
                        text = snapshot.data.toString();
                        amount = snapshot.data;
                      }
                    }
                    return StreamBuilder<bool>(
                        stream: _bloc.isXymMode,
                        builder: (context, isXymSnapshot) {
                          if (isXymSnapshot.hasData && amount != 0.0) {
                            text = text + (isXymSnapshot.data ? 'XYM' : 'XEM');
                          }
                          return Text(
                            text,
                            style: TextStyle(
                                fontSize: 14, color: Color(0x99000000)),
                          );
                        });
                  }),
            ),
          ),
        ),
      );

  Widget _buildMessage() => SliverToBoxAdapter(
        child: InkWell(
          onTap: () async {
            Map<String, String> params = {MemoEditPage.MEMO: _bloc.getMemo()};
            Uri uri = Uri(path: MemoEditPage.PATH, queryParameters: params);
            Map result = await AppProvider.getRouter(context).navigateTo(
                context, uri.toString(),
                transition: TransitionType.native);
            if (result != null && result.containsKey(MemoEditPage.MEMO)) {
              _bloc.changeMemo(result[MemoEditPage.MEMO]);
            }
          },
          child: Container(
            child: ListTile(
              leading: Icon(
                Icons.notes,
                color: Colors.amber,
                size: 24,
              ),
              title: StreamBuilder<String>(
                  stream: _bloc.memo,
                  builder: (context, snapshot) {
                    var text = 'Add Message/Memo';
                    if (snapshot.hasData && snapshot.data.isNotEmpty) {
                      text = snapshot.data;
                    }
                    return Text(
                      text,
                      style: TextStyle(fontSize: 14, color: Color(0x99000000)),
                    );
                  }),
            ),
          ),
        ),
      );

  Widget _buildCryptSelector() => SliverToBoxAdapter(
        child: Container(
          margin: EdgeInsets.only(left: 60, right: 60),
          child: DropdownButtonFormField(
            value: generateTypes.first,
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.only(left: 8, right: 5, top: 0, bottom: 0),
                border: OutlineInputBorder()),
            isDense: true,
            items: generateTypes.map((GenerateType generateType) {
              return new DropdownMenuItem(
                  value: generateType,
                  child: Row(
                    children: <Widget>[
                      Text(
                        generateType.name,
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ));
            }).toList(),
            onChanged: (GenerateType generateType) {},
          ),
        ),
      );

  Widget _buildDivider() => SliverToBoxAdapter(
        child: Divider(
          color: Color(0x14212121),
          height: 1,
          thickness: 1,
          indent: 0,
          endIndent: 0,
        ),
      );

  Widget _buildSpaceBoxHeight(double height) => SliverToBoxAdapter(
        child: SpaceBox.height(height),
      );
}
