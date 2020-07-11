import 'dart:convert';
import 'dart:io';

import 'package:digvast/model/userCoinAmounts_data.dart';
import 'package:digvast/service/app/shared_data.dart';
import 'package:digvast/service/app/shared_service.dart';
import 'package:digvast/service/app/shared_service.dart';
import 'package:digvast/ui/page/home.dart';
import 'package:digvast/ui/page/my_plan_list.dart';
import 'package:digvast/ui/page/user_coin_records.dart';
import 'package:digvast/ui/page/user_sell_coin.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WalletPage extends StatefulWidget {
  final HomePageState _HomePageState;
//  final UserSellCoinPageState _UserSellCoinPageState;

  WalletPage(this._HomePageState, {Key key}) : super(key: key);

//  final bool _isLoadingUserData;
//  final HomePageState _myHomePageState;

//  PlanListPage(this._myHomePageState, {Key key}) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

Future<UserCoinAmounts> callAsyncFetch() =>
    Future.delayed(Duration(seconds: 1), () => getCoinAmountsList());

Future<UserCoinAmounts> getCoinAmountsList() async {
//  List<dynamic> list;
  UserCoinAmounts coinAmountsList;
  SharedService.dio.options.headers["authorization"] =
      "Bearer ${SharedData.token}";
  try {
    var response = await SharedService.dio.get("/getUserCoinAmounts");
    if (response.statusCode == HttpStatus.ok) {
      String str = json.encode(response.data);

      List<dynamic> responseList = json.decode(str);
      coinAmountsList = UserCoinAmounts.fromJson(responseList);
      SharedData.coinAmountsData = coinAmountsList.data;
      return coinAmountsList;
    } else {
      debugPrint('error:netError}');
      return null;
    }
  } catch (exception) {
    debugPrint('movieTitle3: $exception');
    return null;
  }
}


GlobalKey<_UserSellCoinPageState> globalKey = GlobalKey();

class _WalletPageState extends State<WalletPage> {
  Future<UserCoinAmounts> _listFuture;
  UserSellCoinPage userSellCoinPage;

  void initState() {
    super.initState();
//    userSellCoinPage = UserSellCoinPage();

    // initial load
    _listFuture = getCoinAmountsList();
    upDateData();
  }

  void refreshList() {
    // reload
    setState(() {
      _listFuture = getCoinAmountsList();
    });
  }
  void upDateData(){
    Future.delayed(Duration(seconds: 60), () => {
      refreshList(),
//      SharedService.upDateFun,
      globalKey.currentState.updateData(),
      upDateData()
    });
  }

  void setUpdateData(){
    setState(() {
//      SharedData.coinAmountsData
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserCoinAmounts>(
        future:_listFuture,
//        callAsyncFetch(),
        builder: (context, AsyncSnapshot<UserCoinAmounts> snapshot) {
          if (snapshot.hasData) {
//            SharedData.coinAmountsData = snapshot.data.data;
//            _myPlanList=snapshot.data.data;
            return Padding(
              padding: EdgeInsets.all(5),
              child: ListView.builder(
                  itemCount: snapshot.data.data.length,
                  itemExtent: MediaQuery.of(context).size.height * 0.25,
                  itemBuilder: (BuildContext context, int index) {
                    return _coinAmountsContainer(snapshot.data.data[index]);
                  }),
            );
          } else {
            return new Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
        });
  }


  Widget _coinAmountsContainer(CoinAmountsData data) {

    return new Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.indigoAccent,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo,
            blurRadius: 8.0, // has the effect of softening the shadow
            spreadRadius: 3.0, // has the effect of extending the shadow
            offset: Offset(
              1.0, // horizontal, move right 10
              3.0, // vertical, move down 10
            ),
          )
        ],
      ),
      child: new Row(
        children: <Widget>[
          Expanded(
            child: new Column(
              children: <Widget>[
                new Container(
                  margin: const EdgeInsets.only(left: 4, top: 4, bottom: 2),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "(${data.coinEnName})${data.coinZhName}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.only(left: 4, top: 4, bottom: 2),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "目前資產：",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w200),
                    ),
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.only(left: 4, top: 2, bottom: 2),
                  child: new Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "\$${data.amount}",
                      style: TextStyle(
                          color: Colors.lightGreen,
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.only(left: 4, top: 2, bottom: 2),
                  child: new Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "目前匯率：",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.only(left: 4, top: 2, bottom: 2),
                  child: new Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "\$${data.usdPrice}",
                      style: TextStyle(
                          color: Colors.lightGreen,
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            ),
            flex: 2,
          ),
          Expanded(
            child: new Column(
              children: <Widget>[
                Expanded(
                  child: new Container(
                    margin: const EdgeInsets.all(5.0),
                    child: (RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          side: BorderSide(color: Colors.lightGreen)),
                      child: Text(
                        "入帳\n紀錄",
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return UserCoinRecordsPage(
                            coinId: data.coinId,
                            coinName: "(${data.coinEnName})${data.coinZhName}",
                          );
                        }));
//                      FocusScope.of(context).requestFocus(FocusNode());
                      },
                      color: Colors.lightGreen,
                      highlightColor: Colors.green,
                      splashColor: Colors.green,
                    )),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: new Container(
                    margin: const EdgeInsets.all(5.0),
                    child: (RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          side: BorderSide(color: Colors.red)),
                      child: Text(
                        "兌現",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                              return UserSellCoinPage(
                                  key: globalKey,
                                coinId: data.coinId,
////                                data: data,
                                coinName: "(${data.coinEnName})${data.coinZhName}",
                              );
                            }));
//                        widget._HomePageState.goUserCoinRecords(data.coinId);
//                        goUserCoinRecords(data.coinId);
//                        SharedData.coinRecordId = data.coinId;
//                        Navigator.pushNamed(context, '/userCoinRecords');
//                      Navigator.push(context, UserCoinRecordsPage());
//                        Navigator.of(context).pushNamed("/userCoinRecords");
//                        Navigator.pushNamed(
//                          context,
//                          '/userCoinRecords',
//                          arguments: <int>{
//                            data.coinId
//                          },
//                        );

//                      FocusScope.of(context).requestFocus(FocusNode());
                      },
                      color: Colors.redAccent,
                      highlightColor: Colors.red,
                      splashColor: Colors.red,
                    )),
                  ),
                  flex: 1,
                ),
              ],
            ),
            flex: 1,
          ),
        ],
      ),
    );

  }

  void goUserCoinRecords(int coinId) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return MyPlanPage();
    }));
  }

//  Widget _coinAmountsContainer(CoinAmountsData data) {
//    return new Container(
//      margin: const EdgeInsets.all(3),
//      decoration: BoxDecoration(
//        color: Colors.indigoAccent,
//        shape: BoxShape.rectangle,
//        borderRadius: BorderRadius.all(Radius.circular(10.0)),
//      ),
//      child: new Column(
//        children: <Widget>[
//          new Stack(
//            fit: StackFit.loose,
//            alignment: Alignment.bottomLeft,
//            children: <Widget>[
//              Container(
//                  height: MediaQuery.of(context).size.height / 5,
//                  width: MediaQuery.of(context).size.width,
//                  child: ClipRRect(
//                    borderRadius: BorderRadius.only(
//                        topLeft: Radius.circular(10),
//                        topRight: Radius.circular(10)),
//                    child: Image.asset(
//                      'assets/wallet.jpg',
//                      fit: BoxFit.fitWidth,
//                    ),
//                  )),
//              Container(
//                margin: const EdgeInsets.only(left: 8),
//                child: Text(
//                  "(${data.coinEnName}) ${data.coinZhName}",
//                  style: TextStyle(
//                      color: Colors.white,
//                      fontSize: 22,
//                      fontWeight: FontWeight.w300),
//                ),
//              )
//            ],
//          ),
//          new Container(
//            child:  Column(
//              children: <Widget>[
//                new Container(
//                  margin: const EdgeInsets.only(left:4,top: 4, bottom: 2),
//                  child: Align(
//                    alignment: Alignment.centerLeft,
//                    child: Text(
//                      "目前資產：",
//                      style: TextStyle(
//                          color: Colors.white,
//                          fontSize: 22,
//                          fontWeight: FontWeight.w200),
//                    ),
//                  ),
//                ),
//                new Container(
//                  margin: const EdgeInsets.only(left:4,top: 2, bottom: 2),
//                  child: new Align(
//                    alignment: Alignment.centerLeft,
//                    child: Text(
//                      "\$${data.amount}",
//                      style: TextStyle(
//                          color: Colors.white,
//                          fontSize: 22,
//                          fontWeight: FontWeight.w500),
//                    ),
//                  ),
//                ),
//                new Container(
//                  margin: const EdgeInsets.only(left:4,top: 2, bottom: 2),
//                  child: new Align(
//                    alignment: Alignment.centerLeft,
//                    child: Text(
//                      "目前匯率：",
//                      style: TextStyle(
//                          color: Colors.white,
//                          fontSize: 22,
//                          fontWeight: FontWeight.w300),
//                    ),
//                  ),
//                ),
//                new Container(
//                  margin: const EdgeInsets.only(left:4,top: 2, bottom: 2),
//                  child: new Align(
//                    alignment: Alignment.centerLeft,
//                    child: Text(
//                      "\$${data.usdPrice}",
//                      style: TextStyle(
//                          color: Colors.white,
//                          fontSize: 22,
//                          fontWeight: FontWeight.w500),
//                    ),
//                  ),
//                )
//              ],
//            ),
////            child:Padding(
////              padding: const EdgeInsets.only(left: 5.0),
////
////            )
//          ),
//        ],
//      ),
//    );
//  }
}

class UserSellCoinPage extends StatefulWidget {
  final int coinId;
  final String coinName;
//  void callback;

//  final List<CoinAmountsData> data;
  UserSellCoinPage({Key key, @required this.coinId, @required this.coinName}): super(key: key);


//  UserSellCoinPage({Key key, @required this.coinId, @required this.coinName})

//  UserSellCoinPage({Key key})
//      : super(key: key);

//  final bool _isLoadingUserData;
//  final HomePageState _myHomePageState;

//  PlanListPage(this._myHomePageState, {Key key}) : super(key: key);

  @override
  _UserSellCoinPageState createState() => _UserSellCoinPageState();
}

class _UserSellCoinPageState extends State<UserSellCoinPage> {
  final _sellCoin = TextEditingController();
  final _sellMoney = TextEditingController();
  String _text = "USD";
  var nowAmount = 0.0;
  var nowUSD = 0.0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  void initState() {
    nowAmount = SharedData.coinAmountsData
        .firstWhere((data) => data.coinId == widget.coinId)
        .amount;
    nowUSD = SharedData.coinAmountsData
        .firstWhere((data) => data.coinId == widget.coinId)
        .usdPrice;
//    SharedService.upDateFun = updateData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SharedService.mainContext = context;
    return Scaffold(
      key: _scaffoldKey,
//        resizeToAvoidBottomInset: false,
      appBar: new AppBar(
          title: new Text(
              widget.coinName,
            style: TextStyle(
                fontSize: 22.0,
                color: Colors.white,
                fontWeight: FontWeight.w500),
          ),
          centerTitle: true),
      backgroundColor: Colors.white,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          // 触摸收起键盘
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: _coinRecordsContainer(),
      ),
    );
  }

  Widget _coinRecordsContainer() {
//    widget.callback =updateData();
//    updateData();
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
//        Container(
//          alignment: Alignment.centerLeft,
//          child:
//          Text("coin:\$1234567"),
//        ),

        Text("目前資產:\$$nowAmount"),
        Text("目前匯率:\$$nowUSD USD"),
        Container(
          margin: const EdgeInsets.all(10.0),
          child: TextField(
            onSubmitted: (text) {
//            FocusScope.of(context).requestFocus(_sellMoney);
            },
            style: TextStyle(fontSize: 22.0, color: Colors.black),
            keyboardType: TextInputType.number,
            controller: _sellCoin,
            textAlign: TextAlign.start,
//            onEditingComplete:()=>setState((){
//
//            }) ,
//            inputFormatters: ,
            onChanged: (v) => setState(() {
              if (v == "") {
                _text = "USD";
              } else {
                var count = double.parse(v) * nowUSD;
                _text = "$count";
              }
            }),
            decoration: InputDecoration(
//                      border: InputBorder.,
//                        contentPadding:
//                            const EdgeInsets.fromLTRB(3.0, 0.0, 0.0, 0.0),
//                icon: Icon(Icons.attach_money),
                labelText: "輸入兌換數量",
                enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                )),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10.0),
          child: TextField(
            onSubmitted: (text) {
//            FocusScope.of(context).requestFocus(_sellCoin);
            },
            style: TextStyle(fontSize: 22.0, color: Colors.black),
            controller: _sellMoney,
            textAlign: TextAlign.start,
            enabled: false,
            decoration: InputDecoration(
//                      border: InputBorder.,
//                        contentPadding:
//                            const EdgeInsets.fromLTRB(3.0, 0.0, 0.0, 0.0),
                labelText: "\$"+_text+ " USD",
                enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                )),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10.0),
          child: (RaisedButton(
            child: Text(
              "確認下訂",
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.white,
              ),
            ),
            onPressed: () {
                userSellAction();

              
//                      FocusScope.of(context).requestFocus(FocusNode());
            },
            color: Colors.blue,
            highlightColor: Colors.green,
            splashColor: Colors.green,
          )),
        )
      ],
    );
  }

  Future<void> userSellAction() async{
    if(_text!="USD"&&double.parse(_text)>=30) {
      SharedService.dio.options.headers["authorization"] =
      "Bearer ${SharedData.token}";

      String responseStr;

      Response response;
      try {
        response = await SharedService.dio
            .post("/userSellCoin", data: {"CoinId": widget.coinId, "Amount": double.parse(_text)});

        responseStr = response.data.toString();

        if (response.statusCode == HttpStatus.ok) {
          showAlertDialog(responseStr);

        }
      } catch (exception) {
        if(exception is DioError){
          if(exception.response.statusCode==400){

//          List<dynamic> errorStrList = json.decode(exception.response.data.toString());
            showAlertDialog(exception.response.data[0].toString());

          }
        }
      }
    }else{
      showAlertDialog("最小兌換值為\$30 USD");

    }
     
  }

  void updateData() {
    debugPrint('inUpdate start');

    setState(() {
      nowAmount = SharedData.coinAmountsData
          .firstWhere((data) => data.coinId == widget.coinId)
          .amount;
      nowUSD = SharedData.coinAmountsData
          .firstWhere((data) => data.coinId == widget.coinId)
          .usdPrice;
      debugPrint('inUpdate finish');


    });
    _showToast();
//    Future.delayed(const Duration(seconds: 60), () {
//      debugPrint('updateData: $nowAmount');
//
//
//      debugPrint('updateData:finish $nowAmount');
//
////      _showToast(context);
//    });
  }

  void _showToast() {
//    final scaffold = Scaffold.of(context);
    var setText = "匯率已更新，請檢查匯率是否變動";
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(setText),
        action: SnackBarAction(
            label: 'OK', onPressed: _scaffoldKey.currentState.hideCurrentSnackBar),
      ),
    );
  }

  void showAlertDialog(String resStr) {
//    Widget cancelButton = FlatButton(
//      color: Colors.red,
//      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
//      child: Text("取消"),
//      onPressed:  () {
//        Navigator.pop(context);
//      },
//    );
    Widget confirmButton = FlatButton(
      color: Colors.indigoAccent,
      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
      child: Text("確認"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );

    var dialog = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      content: Container(
        margin: const EdgeInsets.all(5),
//        width: MediaQuery.of(context).size.width * 0.9,
//      height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: new Container(
//            decoration: BoxDecoration(
//              border: Border.all(color: Colors.black),
//              borderRadius: BorderRadius.circular(10.0),
//            ),
            child:Text("$resStr"),
          ),
      ),
      actions: [
        confirmButton
      ],
    );


    showDialog(context: context, builder: (_) => dialog);
  }
  }
