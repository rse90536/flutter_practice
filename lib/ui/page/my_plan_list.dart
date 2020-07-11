import 'dart:convert';
import 'dart:io';

import 'package:digvast/model/myPlan_data.dart';
import 'package:digvast/service/app/shared_data.dart';
import 'package:digvast/service/app/shared_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPlanPage extends StatefulWidget {
  MyPlanPage({Key key}) : super(key: key);

  @override
  _MyPlanPageState createState() => _MyPlanPageState();
}

Future<MyPlanData> callAsyncFetch() =>
    Future.delayed(Duration(seconds: 1), () => getMyPlanList());

Future<MyPlanData> getMyPlanList() async {
//  List<dynamic> list;
  MyPlanData myPlanList;
  SharedService.dio.options.headers["authorization"] =
      "Bearer ${SharedData.token}";
  try {
    var response = await SharedService.dio.get("/getUserPlans");
    if (response.statusCode == HttpStatus.ok) {
      String str = json.encode(response.data);

      List<dynamic> responseList = json.decode(str);
      myPlanList = MyPlanData.fromJson(responseList);
      return myPlanList;
    } else {
      debugPrint('error:netError}');
      return myPlanList;
    }
  } catch (exception) {
    debugPrint('movieTitle3: $exception');
    return myPlanList;
  }
}

class _MyPlanPageState extends State<MyPlanPage> {
//  @override
//  void initState() {
//    super.initState();
////    if(_myPlanList.length==0){
////      getMyPlanList().then(
////              (List<dynamic> list) => setState(() {_myPlanList = list;})
////      );
////    }
//  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MyPlanData>(
        future: callAsyncFetch(),
        builder: (context, AsyncSnapshot<MyPlanData> snapshot) {
          if (snapshot.hasData) {
//            _myPlanList=snapshot.data.data;
            return ListView.builder(
                itemCount: snapshot.data.data.length,
                itemExtent: MediaQuery.of(context).size.height * 0.45,
                itemBuilder: (BuildContext context, int index) {
                  return _planContainer(snapshot.data.data[index]);
                });
          } else {
            return new Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
        });

//      ListView.builder(
//        itemCount: _myPlanList.length,
//        itemExtent: MediaQuery.of(context).size.height * 0.28,
//        itemBuilder: (BuildContext context, int index) {
//          return _planContainer(index);
//        });
  }

  Widget _planContainer(Data data) {
    return new GestureDetector(
      onTap: () {
        showAlertDialog(data);
//        showAlertDialog(index);
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width * 0.9,
//      height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: new Column(children: <Widget>[
          new Container(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
//                Expanded(
                new IconTheme(
                  data: new IconThemeData(color: Colors.green),
                  child: new Icon(Icons.beenhere),
                ),
//                ),
//                Expanded(
                Text(
                  "${data.userPlanName}",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
//                ),
              ],
            ),
          ),
          Divider(thickness: 2),
          new Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 20.0),
                  child: Text(
                    "推薦人：",
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 20.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
//                        _getImage(),
                      new Container(
                          width: 45.0,
                          height: 45.0,
                          margin: const EdgeInsets.only(right: 3),
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: new NetworkImage(
                                      "https://www.digvast.com/images/profilePics/thumbnail/${data.referrerUserProfilePic}")))),
                      Text(
                        "${data.referrerUserName != null ? data.referrerUserName : "無"}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                flex: 1,
              ),
            ],
          ),
          _setRow("算力：", data.power),
          _setRow("服務時間：", data.fullPeriod),
          _setRow("狀態：", data.statusName),
          _setRow("方案建立時間：", data.createdAt),

        ]),
      ),
    );
  }

  void showAlertDialog(Data data) {
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
        child: new Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Text(
            "${data.userPlanName}\n方案內容",
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
          ),
          Divider(thickness: 2),
          new Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text(
                    "啟用時間：\n${data.startTime}",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.green),
                  ),
                ),
              ],
            ),
          ),
          new Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: <Widget>[
                Container(
                  child: Text(
                    "到期時間：\n${data.endTime}",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.red),
                  ),
                ),

              ],
            ),
          ),
          Divider(thickness: 2),
        ]),
      ),
      actions: <Widget>[
        CupertinoButton(
          child: Text("關閉"),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );

    showDialog(context: context, builder: (_) => dialog);
  }



  Widget _setRow(String title, String titleData) {
    return new Row(
      children: <Widget>[
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 5, bottom: 20.0),
            child: Text(
              title,
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          flex: 1,
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 5, bottom: 20.0),
            child: Text(
              titleData,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          flex: 1,
        ),
      ],
    );
  }
}
