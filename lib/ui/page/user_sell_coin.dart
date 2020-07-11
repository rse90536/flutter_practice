import 'package:digvast/model/userCoinAmounts_data.dart';
import 'package:digvast/service/app/shared_data.dart';
import 'package:digvast/service/app/shared_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//class UserSellCoinPage extends StatefulWidget {
//  final int coinId;
//  final String coinName;
//
////  final List<CoinAmountsData> data;
//  UserSellCoinPage({Key key, @required this.coinId, @required this.coinName})
//      : super(key: key);
//
////  UserSellCoinPage({Key key})
////      : super(key: key);
//
////  final bool _isLoadingUserData;
////  final HomePageState _myHomePageState;
//
////  PlanListPage(this._myHomePageState, {Key key}) : super(key: key);
//
//  @override
//  UserSellCoinPageState createState() => UserSellCoinPageState();
//}
//
//class UserSellCoinPageState extends State<UserSellCoinPage> {
//  final _sellCoin = TextEditingController();
//  final _sellMoney = TextEditingController();
//  String _text = "USD";
//  var nowAmount = 0.0;
//  var nowUSD = 0.0;
//
//  @override
//  void dispose() {
//    SharedService.upDateFun=null;
//    super.dispose();
//  }
//
//  @override
//  void initState() {
//    nowAmount = SharedData.coinAmountsData
//        .firstWhere((data) => data.coinId == widget.coinId)
//        .amount;
//    nowUSD = SharedData.coinAmountsData
//        .firstWhere((data) => data.coinId == widget.coinId)
//        .usdPrice;
//    SharedService.upDateFun = updateData();
//
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
////        resizeToAvoidBottomInset: false,
//      appBar: new AppBar(
//          title: new Text(
//            widget.coinName,
//            style: TextStyle(
//                fontSize: 22.0,
//                color: Colors.white,
//                fontWeight: FontWeight.w500),
//          ),
//          centerTitle: true),
//      backgroundColor: Colors.white,
//      body: GestureDetector(
//        behavior: HitTestBehavior.translucent,
//        onTap: () {
//          // 触摸收起键盘
//          FocusScope.of(context).requestFocus(FocusNode());
//        },
//        child: _coinRecordsContainer(),
//      ),
//    );
//  }
//
//  Widget _coinRecordsContainer() {
//    updateData();
//    return Column(
//      mainAxisSize: MainAxisSize.max,
//      mainAxisAlignment: MainAxisAlignment.center,
//      crossAxisAlignment: CrossAxisAlignment.center,
//      children: <Widget>[
////        Container(
////          alignment: Alignment.centerLeft,
////          child:
////          Text("coin:\$1234567"),
////        ),
//
//        Text("目前資產:\$$nowAmount"),
//        Text("目前匯率:\$$nowUSD USD"),
//        Container(
//          margin: const EdgeInsets.all(10.0),
//          child: TextField(
//            onSubmitted: (text) {
////            FocusScope.of(context).requestFocus(_sellMoney);
//            },
//            style: TextStyle(fontSize: 22.0, color: Colors.black),
//            keyboardType: TextInputType.number,
//            controller: _sellCoin,
//            textAlign: TextAlign.start,
////            onEditingComplete:()=>setState((){
////
////            }) ,
////            inputFormatters: ,
//            onChanged: (v) => setState(() {
//              if (v == "") {
//                _text = "USD";
//              } else {
//                var count = double.parse(v) * nowUSD;
//                _text = "$count";
//              }
//            }),
//            decoration: InputDecoration(
////                      border: InputBorder.,
////                        contentPadding:
////                            const EdgeInsets.fromLTRB(3.0, 0.0, 0.0, 0.0),
////                icon: Icon(Icons.attach_money),
//                labelText: "how many money",
//                enabledBorder: const OutlineInputBorder(
//                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
//                ),
//                border: OutlineInputBorder(
//                  borderRadius: BorderRadius.circular(15.0),
//                )),
//          ),
//        ),
//        Container(
//          margin: const EdgeInsets.all(10.0),
//          child: TextField(
//            onSubmitted: (text) {
////            FocusScope.of(context).requestFocus(_sellCoin);
//            },
//            style: TextStyle(fontSize: 22.0, color: Colors.black),
//            controller: _sellMoney,
//            textAlign: TextAlign.start,
//            enabled: false,
//            decoration: InputDecoration(
////                      border: InputBorder.,
////                        contentPadding:
////                            const EdgeInsets.fromLTRB(3.0, 0.0, 0.0, 0.0),
//                labelText: _text,
//                enabledBorder: const OutlineInputBorder(
//                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
//                ),
//                border: OutlineInputBorder(
//                  borderRadius: BorderRadius.circular(15.0),
//                )),
//          ),
//        ),
//        Container(
//          margin: const EdgeInsets.all(10.0),
//          child: (RaisedButton(
//            child: Text(
//              "confirm",
//              style: TextStyle(
//                fontSize: 22.0,
//                color: Colors.white,
//              ),
//            ),
//            onPressed: () {
////                      FocusScope.of(context).requestFocus(FocusNode());
//            },
//            color: Colors.blue,
//            highlightColor: Colors.green,
//            splashColor: Colors.green,
//          )),
//        )
//      ],
//    );
//  }
//
//  void updateData() {
//
//    setState(() {
//      nowAmount = SharedData.coinAmountsData
//          .firstWhere((data) => data.coinId == widget.coinId)
//          .amount;
//      nowUSD = SharedData.coinAmountsData
//          .firstWhere((data) => data.coinId == widget.coinId)
//          .usdPrice;
//      debugPrint('inUpdate finish');
//
//    });
////    Future.delayed(const Duration(seconds: 60), () {
////      debugPrint('updateData: $nowAmount');
////
////
////      debugPrint('updateData:finish $nowAmount');
////
//////      _showToast(context);
////    });
//  }
//
//  void _showToast(BuildContext context) {
//    final scaffold = Scaffold.of(context);
//    var setText = "匯率已更新，請檢查匯率是否變動";
//    scaffold.showSnackBar(
//      SnackBar(
//        content: Text(setText),
//        action: SnackBarAction(
//            label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
//      ),
//    );
//  }
//}
