import 'package:digvast/service/app/shared_data.dart';
import 'package:digvast/service/app/shared_service.dart';
import 'package:digvast/ui/page/main_home.dart';
import 'package:digvast/ui/page/my_plan_list.dart';
import 'package:digvast/ui/page/order_record.dart';
import 'package:digvast/ui/page/plan_list.dart';
import 'package:digvast/ui/page/user_coin_records.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'currency.dart';
import 'my_main.dart';

class HomePage extends StatefulWidget {
//  final bool _isLoadingUserData;
  final MyMainPageState _myMainPageState;

//
//  LoginPage(this._myMainPageState, this._isLoadingUserData, {Key key}) : super(key: key);
  HomePage(this._myMainPageState, {Key key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
//  String title = "Home";
  String appBarTitle = "主頁";
  Widget currentPage = MainHomePage();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

//  currentPage = ;

  menuTapHandler(int index) {
    setState(() {
      switch (index) {
        case 0:
          {
            setTitle(0);
            currentPage = MainHomePage();
          }
          break;
        case 1:
          {
            setTitle(1);
            currentPage = PlanListPage();

//            title = "Members";
//            currentPage = MemberPage();
          }
          break;
        case 2:
          {
            setTitle(2);
            currentPage = MyPlanPage();
          }
          break;
        case 3:
          {
            setTitle(3);
            currentPage = CurrencyPage(this);
//            setTitle(3);

          }
          break;
        case 4:
          {
            setTitle(4);
            currentPage = OrderRecordPage();
//            title = "Members";
//            currentPage = MemberPage();
          }
          break;
        case 5:
          {
//            title = "Members";
//            currentPage = MemberPage();
          }
          break;
      }

      // hide menu
//      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
//        resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text(appBarTitle),
        centerTitle: true,
      ),
      drawer: new Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
              accountName: new Text("${SharedData.userData["Name"]}"),
              accountEmail: new Text("${SharedData.userData["Email"]}"),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: SharedData.userImage,
              )),
          ListTile(
              leading: new CircleAvatar(
                child: new Icon(Icons.account_balance),
              ),
              title: Text("主頁"),
              onTap: () {
                menuTapHandler(0);
                Navigator.pop(context);
              }),
          ListTile(
            leading: new CircleAvatar(
              child: new Icon(Icons.add_to_photos),
            ),
            title: Text("服務方案"),
            onTap: () {
              menuTapHandler(1);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: new CircleAvatar(
              child: new Icon(Icons.account_box),
            ),
            title: Text("我的方案"),
            onTap: () {
              menuTapHandler(2);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: new CircleAvatar(
              child: new Icon(Icons.assessment),
            ),
            title: Text("虛擬貨幣"),
            onTap: () {
//                  Navigator.push(context, Material)
//                  SharedService.mainContext = context;
              menuTapHandler(3);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: new CircleAvatar(
              child: new Icon(Icons.account_balance_wallet),
            ),
            title: Text("下訂紀錄"),
            onTap: () {
//                  Navigator.push(context, Material)
//                  SharedService.mainContext = context;
              menuTapHandler(4);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: new CircleAvatar(
              child: new Icon(Icons.call_missed),
            ),
            title: Text("登出"),
          ),
        ],
      )),
      body: currentPage,
    );
  }

  void setTitle(int index) {
    setState(() {
      switch (index) {
        case 0:
          appBarTitle = "主頁";
          break;
        case 1:
          appBarTitle = "服務方案列表";
          break;
        case 2:
          appBarTitle = "我的方案列表";
          break;
        case 3:
          appBarTitle = "加密貨幣";
          break;
        case 4:
          appBarTitle = "下訂紀錄";
          break;
      }
    });
  }
}
