import 'dart:convert';
import 'dart:io';

import 'package:digvast/model/planCoinDetail_data.dart';
import 'package:digvast/model/userCoinRecords_data.dart';
import 'package:digvast/service/app/shared_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImmediatePlanDetailCoinPage extends StatelessWidget {
  final int coinId;
  final String planName;

//  UserCoinRecordsPage({Key key, @required this.coinId}) : super(key: key);
  ImmediatePlanDetailCoinPage({Key key, @required this.coinId, @required this.planName})
      : super(key: key);

  Future<PlanCoinData> callAsyncFetch() =>
      Future.delayed(Duration(seconds: 1), () => getCoinDetailList());

  Future<PlanCoinData> getCoinDetailList() async {
//  List<dynamic> list;
    PlanCoinData planCoinDetailList;

    try {
      var response =
          await SharedService.dio.get("/getImmediateUserPlanDigCoinRecords?upId=$coinId");
      if (response.statusCode == HttpStatus.ok) {
        String str = json.encode(response.data);

        List<dynamic> responseList = json.decode(str);
        planCoinDetailList = PlanCoinData.fromJson(responseList);
        return planCoinDetailList;
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
            "方案：$planName",
            style: TextStyle(
                fontSize: 22.0,
                color: Colors.white,
                fontWeight: FontWeight.w500),
          ),
          centerTitle: true),
      backgroundColor: Colors.white,
      body: _coinRecordsContainer(),
    );
  }

  Widget _coinRecordsContainer() {
    return FutureBuilder<PlanCoinData>(
        future: callAsyncFetch(),
        builder: (context, AsyncSnapshot<PlanCoinData> snapshot) {
          if (snapshot.hasData) {
//            _myPlanList=snapshot.data.data;
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListView.builder(
//                scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.data.length,
                  itemExtent: MediaQuery.of(context).size.height / 9,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: rowContainer(snapshot.data.data[index]),
                      ),
                    );
                  }),
            );
          } else {
            return new Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
        });
    ;
  }

  Widget rowContainer(PlanCoinDetail data){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("幣種：(${data.coinEnName})${data.coinZhName}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
        Text("幣量：${data.amount}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400)),
        Text("獲幣時間：${data.createdAt}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400)),
      ],
    );
  }

//  _UserCoinRecordsPageState createState() => _UserCoinRecordsPageState();
}


