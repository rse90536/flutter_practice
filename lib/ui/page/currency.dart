import 'package:digvast/service/app/shared_service.dart';
import 'package:digvast/ui/page/home.dart';
import 'package:digvast/ui/page/user_plans_with_amount.dart';
import 'package:digvast/ui/page/wallet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'immediate_user_plans.dart';
import 'my_plan_list.dart';

class CurrencyPage extends StatefulWidget {
  final HomePageState _HomePageState;

  CurrencyPage(this._HomePageState, {Key key}) : super(key: key);
//  final bool _isLoadingUserData;
//  final MyMainPageState _myMainPageState;
//
//  LoginPage(this._myMainPageState, this._isLoadingUserData, {Key key}) : super(key: key);

  @override
  _CurrencyPageState createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabList.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.1),
          child: AppBar(
            backgroundColor: Colors.black,
//            flexibleSpace: Container(
//              decoration: new BoxDecoration(
//                gradient: new LinearGradient(
//                    colors: [
//                      SharedService.colorFromHex("ff0844"),
//                      SharedService.colorFromHex("ffb199"),
//
////                  const Color(0xFF00CCFF),
//                    ],
//                    begin: const FractionalOffset(0.0, 0.0),
//                    end: const FractionalOffset(1.0, 0.0),
//                    stops: [0.0, 1.0],
//                    tileMode: TileMode.clamp),
//              ),
//            ),
            bottom: TabBar(
              indicatorColor: Colors.amber,
              tabs: tabList.map((choice) {
                return Tab(
                  text: choice.title,
                  icon: Icon(choice.icon),
                );
              }).toList(),
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            WalletPage(widget._HomePageState),
//            MyPlanPage(),
            ImmediateUserPlansPage(),
            UserPlansAmountPage()
          ],
//            children:
//            tabList.map((choice) {
//          return Center(
//            child: Icon(
//              choice.icon,
//              size: 100.0,
//            ),
//          );
//        }).toList()
        ),
      ),
    );
  }
}

class TabChoice {
  final String title;
  final IconData icon;
  const TabChoice(this.title, this.icon);
}

const List<TabChoice> tabList = const <TabChoice>[
  TabChoice('錢包', Icons.attach_money),
  TabChoice('未入帳收益', Icons.call_made),
  TabChoice('已入帳收益', Icons.account_balance_wallet),
];
