import 'dart:convert';
import 'dart:io';

import 'package:digvast/model/order_record_data.dart';
import 'package:digvast/service/app/shared_data.dart';
import 'package:digvast/service/app/shared_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderRecordPage extends StatefulWidget {
//  final bool _isLoadingUserData;
//  final HomePageState _myHomePageState;

//  PlanListPage(this._myHomePageState, {Key key}) : super(key: key);

  @override
  _OrderRecordPageState createState() => _OrderRecordPageState();
}

Future<OrderRecordData> callAsyncFetch() =>
    Future.delayed(Duration(seconds: 1), () => getOrderRecordList());
//
Future<OrderRecordData> getOrderRecordList() async {
//  List<dynamic> list;
  OrderRecordData allPlanList;
  SharedService.dio.options.headers["authorization"] =
      "Bearer ${SharedData.token}";
  try {
    var response = await SharedService.dio.get("/getUserBuyPlanRecords");
    if (response.statusCode == HttpStatus.ok) {
      String str = json.encode(response.data);

      List<dynamic> responseList = json.decode(str);
      allPlanList = OrderRecordData.fromJson(responseList);
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

class _OrderRecordPageState extends State<OrderRecordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<OrderRecordData>(
          future: callAsyncFetch(),
          builder: (context, AsyncSnapshot<OrderRecordData> snapshot) {
            if (snapshot.hasData) {
//            _myPlanList=snapshot.data.data;
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "算力",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          child: Text("服務時間",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black)),
                          flex: 1,
                        ),
                        Expanded(
                          child: Text("下訂時間",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black)),
                          flex: 2,
                        ),
                      ],
                    ),
                  ),
                  Divider(thickness: 2),
                  Expanded(
                    child: RefreshIndicator(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ListView.builder(
                            itemCount: snapshot.data.data.length,
                            itemExtent:
                                MediaQuery.of(context).size.height * 0.1,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                child:
//                        Padding(
//                          padding: const EdgeInsets.all(5.0),
                                    setOrderRecordsRow(
                                        snapshot.data.data[index]),
//                        ),
                              );
//                        _planContainer(snapshot.data.data[index]);
                            }),
                      ),
                      onRefresh: getOrderRecordList,
                    ),
                    flex: 1,
                  )
                ],
              );
            } else {
              return new Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            }
          }),
      backgroundColor: Colors.white,
    );
  }

  Widget setOrderRecordsRow(RecordData data) {
    return new GestureDetector(
      onTap: () {
        showRecordDetail(data);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Text(
              "${data.power}",
              textAlign: TextAlign.center,
            ),
            flex: 1,
          ),
          Expanded(
            child: Text("${data.fullPeriod}", textAlign: TextAlign.center),
            flex: 1,
          ),
          Expanded(
            child: Text("${data.createdAt}", textAlign: TextAlign.center),
            flex: 2,
          ),
        ],
      ),
    );
  }

  void showRecordDetail(RecordData data) {
    String discountStr;
//    NetworkImage referrerImage;
//    referrerImage = NetworkImage(
//        "https://www.digvast.com/images/profilePics/thumbnail/${data.referrerUserProfilePic}");
    if (data.discountId == null) {
      discountStr = "無";
    } else {
      if (data.discountId == 1) {
        discountStr = "保留三個月內可退款之權益，一個月內退款 60 %，三個月內退款 30 %。";
      } else {
        discountStr = "額外提供三個月免費挖礦服務。";
      }
    }
    Widget okButton = FlatButton(
      color: Colors.indigoAccent,
      shape:
      RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
      child: Text("關閉"),
      onPressed: () {
       Navigator.pop(context);
      },
    );

    Color color;
    color = data.status == 0 ? Colors.red : Colors.green;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("推薦人："),
                  data.referrerUserName != null
                      ? Container(
                          child: FadeInImage(
                            image: NetworkImage(
                                "https://www.digvast.com/images/profilePics/thumbnail/${data.referrerUserProfilePic}"),
                            placeholder: AssetImage('assets/digvast_logo.png'),
                          ),
                          width: 25.0,
                          height: 25.0,
                          margin: const EdgeInsets.only(right: 3),
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                          ))
                      : Container(),
//                  Visibility(
//                    child: Container(
//                        width: 30.0,
//                        height: 30.0,
//                        margin: const EdgeInsets.only(right: 3),
//                        decoration: new BoxDecoration(
//                            shape: BoxShape.circle,
//                            image: new DecorationImage(
//                                fit: BoxFit.fill,
//                                image: new NetworkImage(
//                                    "https://www.digvast.com/images/profilePics/thumbnail/${data.referrerUserProfilePic}")))),
//                    maintainSize: true,
//                    maintainAnimation: true,
//                    maintainState: true,
//                    visible: data.referrerUserName == null ? false : true,
//                  ),
                  Text(data.referrerUserName != null
                      ? data.referrerUserName
                      : "無",textAlign: TextAlign.center,)
                ],
              ),
              SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("優惠方案："),
                    Expanded(
                      child: Text(discountStr),
                      flex: 1,
                    )
                  ],
                ),

              SizedBox(height: 10),
//              Container(
//                padding: const EdgeInsets.all(5),
//                width: MediaQuery.of(context).size.width * 0.2,
//                child: TextField(
//                  textAlign: TextAlign.center,
//                  enabled: false,
//                  decoration: InputDecoration(
//                      fillColor: data.status == 0 ? Colors.red : Colors.green,
//                      border: UnderlineInputBorder(
//                          borderRadius: BorderRadius.circular(20.0)),
//                      hintText: 'Please',
//                      hintStyle: TextStyle(
////                        backgroundColor:  data.status == 0 ? Colors.red : Colors.green,
//                          color: Colors.white)),
//                ),
//              ),
//              Text(data.statusName,
//                  style: TextStyle(
//                      backgroundColor:
//                      data.status == 0 ? Colors.red : Colors.green,
//                      color: Colors.white))
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: color),
                    borderRadius: BorderRadius.circular(10.0),
                    color: color),
//                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(5),
                child: Text(data.statusName,
                    style:
                        TextStyle(backgroundColor: color, color: Colors.white)),
              ),

//              Text(data.statusName,
//                  style: TextStyle(
//                      backgroundColor:
//                          data.status == 0 ? Colors.red : Colors.green,
//                      color: Colors.white))
//              new Container(
//                color: data.status == 0 ? Colors.red : Colors.green,
//                decoration: BoxDecoration(
//                    color: Colors.white,
//                    shape: BoxShape.rectangle,
//                    borderRadius: BorderRadius.all(Radius.circular(25.0))),
//                child: ,
//              ),
//              Text(data.statusName,
//                  style: TextStyle(backgroundColor: data.status==0?Colors.red:Colors.green,color: Colors.white))
            ],
          ),
          actions: <Widget>[
            okButton
          ],
        );
      },
    );
  }
}
