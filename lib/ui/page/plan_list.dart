import 'dart:convert';
import 'dart:io';

import 'package:digvast/model/allPlan_data.dart';
import 'package:digvast/service/app/shared_data.dart';
import 'package:digvast/service/app/shared_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'my_clipper.dart';

class PlanListPage extends StatefulWidget {
//  final bool _isLoadingUserData;
//  final HomePageState _myHomePageState;

//  PlanListPage(this._myHomePageState, {Key key}) : super(key: key);

  @override
  _PlanListPageState createState() => _PlanListPageState();
}

Future<AllPlanData> callAsyncFetch() =>
    Future.delayed(Duration(seconds: 1), () => getMyPlanList());

Future<AllPlanData> getMyPlanList() async {
//  List<dynamic> list;
  AllPlanData allPlanList;
  SharedService.dio.options.headers["authorization"] =
      "Bearer ${SharedData.token}";
  try {
    var response = await SharedService.dio.get("/getPlans");
    if (response.statusCode == HttpStatus.ok) {
      String str = json.encode(response.data);

      List<dynamic> responseList = json.decode(str);
      allPlanList = AllPlanData.fromJson(responseList);
      return allPlanList;
    } else {
      debugPrint('error:netError}');
      return null;
    }
  } catch (exception) {
    debugPrint('movieTitle3: $exception');
    return null;
  }
}

class _PlanListPageState extends State<PlanListPage> {
  var picHeight;
  @override
  Widget build(BuildContext context) {
    return mainContainer();

//      ListView.builder(
//        itemCount: 6,
//        itemExtent: MediaQuery.of(context).size.height * 0.28,
//        itemBuilder: (BuildContext context, int index) {
//          return _planContainer(index);
//        });
  }

  Widget futureContainer() {
    return FutureBuilder<AllPlanData>(
        future: callAsyncFetch(),
        builder: (context, AsyncSnapshot<AllPlanData> snapshot) {
          if (snapshot.hasData) {
//            _myPlanList=snapshot.data.data;
            return ListView.builder(
                itemCount: snapshot.data.data.length+1,
//                shrinkWrap: true,
//                physics: const NeverScrollableScrollPhysics(),
//                itemExtent: MediaQuery
//                    .of(context)
//                    .size
//                    .height * 0.3,
                itemBuilder: (BuildContext context, int index) {
                  return index==0?SizedBox(
                    height:picHeight*0.8
//                    MediaQuery
//                    .of(context)
//                    .size
//                    .height * 0.3 ,
                  ) :Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white
                        ),
                        child: Card(
                          color: Colors.white,
                          child: _planContainer(snapshot.data.data[index-1]),
                        ),
                      ),

                    ],
                  );
                });
          } else {
            return new Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget mainContainer() {
    picHeight =  MediaQuery.of(context).size.height * 0.3;
    return
//      SingleChildScrollView(
//        child:
        Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black,
//              gradient: LinearGradient()
          ),
        ),
        Image.asset(
          'assets/many_dcoin.png',
          height: MediaQuery.of(context).size.height * 0.3,
          width: double.infinity,
//            height: double.infinity,
        ),
        futureContainer()
//          ConstrainedBox(
//            constraints: BoxConstraints(minHeight: double.infinity),
//            child:futureContainer() ,
//          )
//        Positioned(
//          top: MediaQuery.of(context).size.height / 2,
//          left: MediaQuery.of(context).size.width * 5,
//          width: MediaQuery.of(context).size.width * 8,
//          child: Container(
//            width: MediaQuery.of(context).size.width * 8,
//            color: Colors.yellow,
////            child: futureContainer(),
//          ),
//        ),
//        SafeArea(
//            child: Align(
//          alignment: Alignment.center,
//          child: Container(
//            width: MediaQuery.of(context).size.width * 8,
//            color: Colors.yellow,
////            child: futureContainer(),
//          ),
////            futureContainer(),
//        ))
      ],
    );
//      );
  }

  Widget _planContainer(PlanData planData) {
    return new GestureDetector(
      onTap: () {
        showAlertDialog(planData);
      },
      child:
//      Container(
//        margin: const EdgeInsets.all(5),
//        width: MediaQuery.of(context).size.width * 0.9,
////        height: MediaQuery.of(context).size.height * 0.5,
//        decoration: BoxDecoration(
//          color: Colors.white,
//          shape: BoxShape.rectangle,
//          borderRadius: BorderRadius.all(Radius.circular(15.0)),
//        ),
//        child:
     Column(children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "${planData.power}月租方案",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Text(
                planData.trial ? "(免費試用)" : "",
//                (planData.gbPower > 10240 ? "(可擇一優惠方案)" : ""),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: planData.gbPower > 10240 ? Colors.red : Colors.black,
                ),
              ),
            ],
          ),
//          Text(
//            "${planData.fullPeriod}方案",
//            textAlign: TextAlign.start,
//            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
//          ),
          Divider(thickness: 2),
          new Row(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    "價格：",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      planData.trial
                          ? "免費"
                          : "${planData.currencyEnName}\$${planData.amount}",
//                      "${planData.currencyEnName}\$${planData.amount}",
//                    "TWD \$15,000",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: planData.trial ? Colors.green : Colors.black),
                    )),
                flex: 1,
              ),
            ],
          ),
          new Row(
            children: <Widget>[
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "算力：",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    )),
                flex: 1,
              ),
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "${planData.power}",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    )),
                flex: 1,
              ),
            ],
          ),
          new Row(
            children: <Widget>[
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "服務時間：",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    )),
                flex: 1,
              ),
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "${planData.fullPeriod}",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    )),
                flex: 1,
              ),
            ],
          )
        ]),
//      ),
    );
  }

  void showAlertDialog(PlanData planData) {
    bool _checkboxSelected = false;
    bool _recommend = false;
    final _hasRecommend = TextEditingController();
    int _discountId = 1;

    Widget cancelButton = FlatButton(
      color: Colors.red,
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
      child: Text("取消"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      color: Colors.indigoAccent,
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
      child: Text("下訂"),
      onPressed: () {
        if (_checkboxSelected) {
//          debugPrint("${planData.planId},$_discountId,${_hasRecommend.text}");
//          if (planData.trial) {
//            _hasRecommend.text = null;
//            _discountId = null;
//          }else if(planData.gbPower){
//
//          }
          _buyPlan(planData, _hasRecommend.text, _discountId);
//        Navigator.pop(context);
        } else {}
      },
    );

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                // 触摸收起键盘
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                content: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
//                child:
//            Container(
//                  margin: const EdgeInsets.all(5),
//                  width: MediaQuery.of(context).size.width * 0.9,
//                  height: MediaQuery.of(context).size.height * 0.5,
//                  decoration: BoxDecoration(
//                    color: Colors.white,
//                    shape: BoxShape.rectangle,
//                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
//                  ),
                  child: new Column(mainAxisSize: MainAxisSize.min, children: <
                      Widget>[
                    Text(
                      "確認購買",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                    Divider(thickness: 2),
                    new Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          new IconTheme(
                            data: new IconThemeData(color: Colors.green),
                            child: new Icon(Icons.attach_money),
                          ),
                          Container(
                            child: Text(
                              "價格：",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green),
                            ),
                          ),
                          Container(
                              child: Text(
                            planData.trial
                                ? "免費"
                                : "${planData.currencyEnName}\$${planData.amount}",
//                    "TWD \$15,000",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.green),
                          )),
                        ],
                      ),
                    ),
                    new Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: <Widget>[
                          new IconTheme(
                            data: new IconThemeData(color: Colors.indigoAccent),
                            child: new Icon(Icons.build),
                          ),
                          Container(
                            child: Text(
                              "算力：",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.indigoAccent),
                            ),
                          ),
                          Container(
                              child: Text(
                            "${planData.power}",
//                    "TWD \$15,000",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.indigoAccent),
                          )),
                        ],
                      ),
                    ),
                    new Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: <Widget>[
                          new IconTheme(
                            data: new IconThemeData(color: Colors.black),
                            child: new Icon(Icons.access_time),
                          ),
                          Container(
                            child: Text(
                              "服務時間：",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                              child: Text(
                            "${planData.fullPeriod}",
//                    "TWD \$15,000",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          )),
                        ],
                      ),
                    ),
                    planData.trial
                        ? Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: <Widget>[
                                new IconTheme(
                                  data: new IconThemeData(color: Colors.red),
                                  child: new Icon(Icons.help),
                                ),
                                Expanded(
                                  child: Text(
                                    "試用方案所得之虛擬貨幣需在續約正式服務方案後才可提領及兌現。",
//                    "TWD \$15,000",
                                    textAlign: TextAlign.start,
//                      softWrap: true,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red),
                                  ),
                                  flex: 1,
                                ),
                              ],
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Divider(
                                thickness: 2,
                              ),
                              Text("推薦人",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black)),
                              Row(
                                children: <Widget>[
                                  Checkbox(
                                    value: _recommend,
                                    activeColor: Colors.red,
                                    onChanged: (bool value) {
                                      setState(() {
                                        _recommend = value;
                                      });
                                    },
                                  ),
                                  Expanded(
                                    child: Text(
                                      "填寫推薦人？",
                                      textAlign: TextAlign.start,
                                    ),
                                    flex: 1,
                                  ),
                                ],
                              ),
                              _recommend
                                  ? Container(
                                      child: TextField(
                                        style: TextStyle(
                                            height: 1,
                                            fontSize: 15.0,
                                            color: Colors.black),
                                        controller: _hasRecommend,
                                        textAlign: TextAlign.start,
                                        decoration: InputDecoration(
                                            labelText: "填寫推薦人Email",
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.grey,
                                                  width: 1.0),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            )),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
//                    planData.gbPower > 10240
//                        ? Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: <Widget>[
//                        Divider(
//                          thickness: 2,
//                        ),
//                        Text("選擇優惠方案",
//                            textAlign: TextAlign.start,
//                            style: TextStyle(
//                                fontSize: 18,
//                                fontWeight: FontWeight.w600,
//                                color: Colors.black)),
//                        RadioListTile<int>(
//                          value: 1,
//                          title: Text(
//                              "保留三個月內可退款之權益，一個月內退款 60 %，三個月內退款 30 %。",
//                              style: TextStyle(
//                                  fontSize: 15,
//                                  fontWeight: FontWeight.w600,
//                                  color: Colors.black)),
//                          groupValue: _discountId,
//                          onChanged: (value) {
//                            setState(() {
//                              _discountId = value;
//                            });
//                          },
//                        ),
//                        RadioListTile<int>(
//                          value: 2,
//                          title: Text("額外提供三個月免費挖礦服務。",
//                              style: TextStyle(
//                                  fontSize: 15,
//                                  fontWeight: FontWeight.w600,
//                                  color: Colors.black)),
//                          groupValue: _discountId,
//                          onChanged: (value) {
//                            setState(() {
//                              _discountId = value;
//                            });
//                          },
//                        ),
//                        Divider(
//                          thickness: 2,
//                        )
//                      ],
//                    )
//                        : Container(),
                    Row(
                      children: <Widget>[
                        Checkbox(
//                        tristate: true,
                          value: _checkboxSelected,
                          activeColor: Colors.red,
                          onChanged: (bool value) {
                            setState(() {
                              _checkboxSelected = value;
                            });
                          },
                        ),
                        Expanded(
                          child: AnimatedDefaultTextStyle(
                            style: _checkboxSelected
                                ? TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black)
                                : TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red),
                            child: Text(
                              "我以詳閱並同意所有服務條款。",
//                    "TWD \$15,000",
                              textAlign: TextAlign.start,
//                      softWrap: true,
//                            style: TextStyle(
//                                fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            duration: Duration(milliseconds: 500),
                          ),
                          flex: 1,
                        ),
                      ],
                    ),
                  ]),
//                ),
                ),
                actions: <Widget>[
                  cancelButton,
                  continueButton,
                ],
              ),
            );
          },
        );
      },
    );

//    showDialog(context: context, builder: (_) => dialog);
  }

  Future<void> _buyPlan(
      PlanData planData, String recommend, int discountId) async {
    Response response;
    FormData formData;

    if (planData.trial) {
      discountId = null;
    } else if (planData.gbPower <= 10240) {
      discountId = null;
    }

    if (recommend == "") {
      recommend = null;
    }

    formData = FormData.fromMap({
      "PlanId": planData.planId,
      "DiscountId": discountId,
      "ReferrerUserEmail": recommend
    });

//    if (recommend != "" && discountId != 0) {
//      formData = FormData.fromMap({
//        "PlanId": planId,
//        "DiscountId": discountId,
//        "ReferrerUserEmail": recommend
//      });
//    } else if (recommend != "" && discountId == 0) {
//      formData =
//          FormData.fromMap({"PlanId": planId, "ReferrerUserEmail": recommend});
//    } else if (recommend == "" && discountId != 0) {
//      formData = FormData.fromMap({"PlanId": planId, "DiscountId": discountId});
//    } else {
//      formData = FormData.fromMap({
//        "PlanId": planId,
//      });
//    }

    try {
      response =
          await SharedService.dio.post("/createBuyPlanRecord", data: formData);
      var str = response.data.toString();
      str == "success" ? _showToast(context, true) : _showToast(context, false);
    } catch (exception) {
      if (exception is DioError) {
        if (exception.response.statusCode == 400) {
//          List<dynamic> errorStrList = json.decode(exception.response.data.toString());
          debugPrint("${exception.response.data[0].toString()}");
        }
      }
    }
  }

  void _showToast(BuildContext context, bool isSusses) {
    final scaffold = Scaffold.of(context);
    var setText = isSusses ? "下單成功，請等待審核" : "下單失敗";
    scaffold.showSnackBar(
      SnackBar(
        content: Text(setText),
        action: SnackBarAction(
            label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
