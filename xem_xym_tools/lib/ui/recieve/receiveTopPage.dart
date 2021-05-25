import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:xem_xym_tools/appProvider.dart';
import 'package:xem_xym_tools/model/GenerateType.dart';
import 'package:xem_xym_tools/ui/common/SpaceBox.dart';
import 'package:xem_xym_tools/ui/recieve/amount/receiveAmountPage.dart';
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
            _buildSpaceBoxHeight(4),
            _buildCryptSelector(),
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
          onTap: () {},
          child: Container(
            child: ListTile(
              leading: Icon(
                Icons.menu_book,
                color: Colors.amber,
                size: 24,
              ),
              title: Text(
                "Select Address",
                style: TextStyle(fontSize: 14, color: Color(0x99000000)),
              ),
            ),
          ),
        ),
      );

  Widget _buildAmount() => SliverToBoxAdapter(
        child: InkWell(
          onTap: () {
            AppProvider.getRouter(context).navigateTo(
                context, ReceiveAmountPage.PATH,
                transition: TransitionType.native);
          },
          child: Container(
            child: ListTile(
              leading: Icon(
                Icons.payments,
                color: Colors.amber,
                size: 24,
              ),
              title: Text(
                "Amount",
                style: TextStyle(fontSize: 14, color: Color(0x99000000)),
              ),
            ),
          ),
        ),
      );

  Widget _buildMessage() => SliverToBoxAdapter(
        child: InkWell(
          onTap: () {},
          child: Container(
            child: ListTile(
              leading: Icon(
                Icons.notes,
                color: Colors.amber,
                size: 24,
              ),
              title: Text(
                "Add Message/Memo",
                style: TextStyle(fontSize: 14, color: Color(0x99000000)),
              ),
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
