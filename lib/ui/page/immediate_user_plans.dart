import 'dart:convert';
import 'dart:io';

import 'package:digvast/model/getImmediateUserPlansWithAmount_data.dart';
import 'package:digvast/service/app/shared_data.dart';
import 'package:digvast/service/app/shared_service.dart';
import 'package:digvast/ui/page/immediate_plan_detail_coin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImmediateUserPlansPage extends StatefulWidget {
  ImmediateUserPlansPage({Key key}) : super(key: key);

//  final bool _isLoadingUserData;
//  final HomePageState _myHomePageState;

//  PlanListPage(this._myHomePageState, {Key key}) : super(key: key);

  @override
  _ImmediateUserPlansPageState createState() => _ImmediateUserPlansPageState();
}

Future<GetImmediateUserPlansData> callAsyncFetch() =>
    Future.delayed(Duration(seconds: 1), () => getImmediateUserPlansList());

Future<GetImmediateUserPlansData> getImmediateUserPlansList() async {
//  List<dynamic> list;
  GetImmediateUserPlansData immediateUserPlansList;

  SharedService.dio.options.headers["authorization"] =
      "Bearer ${SharedData.token}";
  try {
    var response =
        await SharedService.dio.get("/getImmediateUserPlansWithAmount");
    if (response.statusCode == HttpStatus.ok) {
      String str = json.encode(response.data);

      List<dynamic> responseList = json.decode(str);
      immediateUserPlansList = GetImmediateUserPlansData.fromJson(responseList);
      return immediateUserPlansList;
    } else {
      debugPrint('error:netError}');
      return null;
    }
  } catch (exception) {
    debugPrint('movieTitle3: $exception');
    return null;
  }
}

class _ImmediateUserPlansPageState extends State<ImmediateUserPlansPage> {
  Future<GetImmediateUserPlansData> _listFuture;

  void initState() {
    super.initState();

    // initial load
    _listFuture = getImmediateUserPlansList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GetImmediateUserPlansData>(
        future: _listFuture,
//        callAsyncFetch(),
        builder: (context, AsyncSnapshot<GetImmediateUserPlansData> snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.all(5),
              child: ListView.builder(
                  itemCount: snapshot.data.data.length,
                  itemExtent: MediaQuery.of(context).size.height * 0.32,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
//                          height: MediaQuery.of(context).size.height * 0.25,
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (BuildContext context) {
                                    return ImmediatePlanDetailCoinPage(
                                      coinId:snapshot.data.data[index].upId ,
                                      planName: snapshot.data.data[index].userPlanName,
                                    );
                                  }));
                              },
                            child:Padding(
                            child: _coinAmountsContainer(snapshot.data.data[index]),
                            padding: EdgeInsets.all(5),
                          ),
                          )
//
                        );
//                      _coinAmountsContainer(snapshot.data.data[index]);
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

  Widget _coinAmountsContainer(ImmediateUserPlansData data) {
    List<dynamic> coinDetailData;
    coinDetailData = data.userPlanDigCoins;
    Color color;
    color = data.status == 0 ? Colors.red : Colors.green;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.assignment_turned_in,
              color: Colors.green,
            ),
            Text(
              "方案：${data.userPlanName}",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
//        Expanded(
//          child: SingleChildScrollView(
//            child:
        ListView.builder(
                shrinkWrap: true,
                itemCount: coinDetailData.length,
                physics: NeverScrollableScrollPhysics(),
//              itemExtent: MediaQuery.of(context).size.height * 0.28,
                itemBuilder: (BuildContext context, int index) {
                  return coinDetail(coinDetailData[index]);
                }),
//          ),
//          flex: 1,
//        ),
        Divider(
          thickness: 2,
        ),
        Text("啟用時間：${data.startTime}",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
        Text("到期時間：${data.endTime}",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: color),
              borderRadius: BorderRadius.circular(10.0),
              color: color),
//                margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(5),
          child: Text(data.statusName,
              style:
              TextStyle(backgroundColor: color, color: Colors.white,fontSize: 18, fontWeight: FontWeight.w500)),
        )
      ],
    );
  }

  Widget coinDetail(ImmediateUserPlansDetailData detailData) {
    String coinEnName;
    String coinZhName;
    coinEnName = detailData.coinEnName;
    coinZhName = detailData.coinZhName;
    return Row(
      children: <Widget>[
        Icon(
          Icons.attach_money,
          color: Colors.yellow,
        ),
        Text(
          "($coinEnName)$coinZhName：${detailData.amount}",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
        )
      ],
    );
  }
}
