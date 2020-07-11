import 'dart:convert';
import 'dart:io';

import 'package:digvast/model/getImmediateUserPlansWithAmount_data.dart';
import 'package:digvast/model/planCoinDetail_data.dart';
import 'package:digvast/service/app/shared_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserPlansAmountDetailPage extends StatefulWidget {
  final int coinId;
  final String planName;

  UserPlansAmountDetailPage(
      {Key key, @required this.coinId, @required this.planName})
      : super(key: key);

  @override
  _UserPlansAmountDetailPageState createState() =>
      _UserPlansAmountDetailPageState();
}

int udcrId;

//var detailList = List();
PlanCoinData detailList;

Future<PlanCoinData> callAsyncFetch(int coinId) =>
    Future.delayed(Duration(seconds: 1), () => getUserPlansList(coinId));

Future<PlanCoinData> getUserPlansList(int coinId) async {
//  List<dynamic> list;
  PlanCoinData userPlansList;

  try {
    var response = await SharedService.dio
        .get("/getUserPlanDigCoinRecords?upId=$coinId&udcrId=$udcrId");
    if (response.statusCode == HttpStatus.ok) {
      String str = json.encode(response.data);

      List<dynamic> responseList = json.decode(str);
      userPlansList = PlanCoinData.fromJson(responseList);
//      for(var item in userPlansList.data){
//        detailList.add(item);
//      }
      if (detailList == null) {
        detailList = userPlansList;
//        detailList.data.where((f) => f.startsWith('a')).toList();
      } else {
        detailList.data.addAll(userPlansList.data);
      }

      return detailList;
    } else {
      debugPrint('error:netError}');
      return null;
    }
  } catch (exception) {
    debugPrint('movieTitle3: $exception');
    return null;
  }
}

class _UserPlansAmountDetailPageState extends State<UserPlansAmountDetailPage> {
  Future<PlanCoinData> _detailList;
  ScrollController controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _detailList = getUserPlansList(widget.coinId);
    controller = new ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    print(controller.position.extentAfter);
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      udcrId = detailList.data.last.udcrId;
      if (this.mounted) {
        setState(() {
         getUserPlansList(widget.coinId);
//        items.addAll(new List.generate(42, (index) => 'Inserted $index'));
        });
      }

    }
  }
  void setLoading(){
    setState(() {
      _isLoading = false;

//        items.addAll(new List.generate(42, (index) => 'Inserted $index'));
    });
  }

  @override
  void dispose() {
    //为了避免内存泄露，需要调用_controller.dispose
    detailList = null;
    debugPrint("destroy");
    controller.removeListener(_scrollListener);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
//        resizeToAvoidBottomInset: false,
      appBar: new AppBar(
          title: new Text(
            "方案：" + widget.planName,
            style: TextStyle(
                fontSize: 22.0,
                color: Colors.white,
                fontWeight: FontWeight.w500),
          ),
          centerTitle: true),
      backgroundColor: Colors.white,
      body: _detailContainer(),
    );
  }

  Widget rowContainer(PlanCoinDetail data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "幣種：(${data.coinEnName})${data.coinZhName}",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        Text("幣量：${data.amount}",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
        Text("獲幣時間：${data.createdAt}",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
      ],
    );
  }

  Widget _detailContainer() {
    return FutureBuilder<PlanCoinData>(
        future: _detailList,
        builder: (context, AsyncSnapshot<PlanCoinData> snapshot) {
          if (snapshot.hasData) {
//            _myPlanList=snapshot.data.data;
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListView.builder(
//                scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.data.length,
                  itemExtent: MediaQuery.of(context).size.height / 9,
                  controller: controller,
                  itemBuilder: (BuildContext context, int index) {
//                    if(controller.position.)
//                    if (index == detailList.data.length - 5) {
//                      udcrId = detailList.data.last.udcrId;
//                      Future.delayed(Duration(milliseconds: 200)).then((e) {
//                        setState(() {
//                          Future.delayed(Duration(seconds: 1),
//                              () => getUserPlansList(widget.coinId));
//                        });
//                      });
////                        udcrId = detailList.last().
//                    }
//                    if (index >= detailList.data.length) {
//                      // Don't trigger if one async loading is already under way
//                      return Center(
//                        child: SizedBox(
//                          child: CircularProgressIndicator(),
//                          height: 24,
//                          width: 24,
//                        ),
//                      );
//                    }

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
  }
}
