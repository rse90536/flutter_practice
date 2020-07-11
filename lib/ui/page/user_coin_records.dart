import 'dart:convert';
import 'dart:io';

import 'package:digvast/model/userCoinRecords_data.dart';
import 'package:digvast/service/app/shared_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserCoinRecordsPage extends StatelessWidget {
  final int coinId;
  final String coinName;

//  UserCoinRecordsPage({Key key, @required this.coinId}) : super(key: key);
  UserCoinRecordsPage({Key key, @required this.coinId, @required this.coinName})
      : super(key: key);

//  final bool _isLoadingUserData;
//  final HomePageState _myHomePageState;

//  PlanListPage(this._myHomePageState, {Key key}) : super(key: key);
  Future<UserCoinRecords> callAsyncFetch() =>
      Future.delayed(Duration(seconds: 1), () => getUserCoinRecordsList());

  Future<UserCoinRecords> getUserCoinRecordsList() async {
//  List<dynamic> list;
    UserCoinRecords coinAmountsList;
//    SharedService.dio.options.headers["authorization"] =
//    "Bearer ${SharedData.token}";
    try {
      var response =
      await SharedService.dio.get("/getUserCoinRecords?coinId=$coinId");
      if (response.statusCode == HttpStatus.ok) {
        String str = json.encode(response.data);

        List<dynamic> responseList = json.decode(str);
        coinAmountsList = UserCoinRecords.fromJson(responseList);
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

  Widget build(BuildContext context) {
    return new Scaffold(
//        resizeToAvoidBottomInset: false,
      appBar: new AppBar(
          title: new Text(
            coinName,
            style: TextStyle(
                fontSize: 22.0,
                color: Colors.white,
                fontWeight: FontWeight.w500),
          ),
          centerTitle: true),
      backgroundColor: Colors.white,
      body: _coinRecordsContainer(),
    );

//    );
  }

  Widget _coinRecordsContainer() {
    return FutureBuilder<UserCoinRecords>(
        future: callAsyncFetch(),
        builder: (context, AsyncSnapshot<UserCoinRecords> snapshot) {
          if (snapshot.hasData) {
//            _myPlanList=snapshot.data.data;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "來源",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black54,
                            fontWeight: FontWeight.w200),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "獲幣時間&",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black54,
                                fontWeight: FontWeight.w200),
                          ),
                          Text(
                            "幣量",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black54,
                                fontWeight: FontWeight.w200),
                          ),
                        ],
                      ),
                      flex: 1,
                    ),
                  ],
                ),
                Divider(
                  thickness: 2.0,
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(5.0),

                      child: ListView.builder(
//                scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.data.length,
                          itemExtent: MediaQuery
                              .of(context)
                              .size
                              .height / 9,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: setRecordsRow(snapshot.data.data[index]),
                              ),
                            );
                          }),
                  ),
                )
              ],
            );
          } else {
            return new Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget setRecordsRow(UserCoinRecordsData data) {
    return new Row(
//      mainAxisAlignment: MainAxisAlignment.center,
//      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("${data.typeName}",
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w500)),
              Row(
                children: <Widget>[
                  setFormUserName(data),
                  Text("【${data.fromUserPlanName}】")
//                   Text(data.fromUserName!=null?data.fromUserName:''),
//                   Text(data.fromUserPlanName),
                ],
              )
            ],
          ),
          flex: 1,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "\$${data.amount}",
                style: TextStyle(
                    color: data.amount.toString().contains("-")
                        ? Colors.red
                        : Colors.green,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500),
              ),
//              CreatedAt
              Text(
                "${data.createdAt}",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          flex: 1,
        ),
      ],
    );
  }

  Widget setFormUserName(UserCoinRecordsData data) {
    if (data.fromUserName != null) {
      return Text(data.fromUserName);
    } else
      return null;
  }

  Widget setAmount(UserCoinRecordsData data) {
//    if (data. != null) {
//      return Text(data.fromUserName);
//    } else
//      return null;
  }
//  _UserCoinRecordsPageState createState() => _UserCoinRecordsPageState();
}

//class _UserCoinRecordsPageState extends State<UserCoinRecordsPage> {
//  @override
//
//}
