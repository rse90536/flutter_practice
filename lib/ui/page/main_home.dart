import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'my_clipper.dart';

class MainHomePage extends StatefulWidget {
//  final bool _isLoadingUserData;
//  final HomePageState _myHomePageState;

//  PlanListPage(this._myHomePageState, {Key key}) : super(key: key);

  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ClipPath(
          clipper: MyClipper(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.black
//              gradient: LinearGradient()
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: MediaQuery.of(context).size.height * -0.1,
                  left: MediaQuery.of(context).size.width * 0.6,
                  child: SafeArea(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10.0),
                        child: Image.asset(
                          'assets/dcoin.png',
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.4,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * -0.1,
                  left: MediaQuery.of(context).size.width * 0.6,
                  child: SafeArea(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                      ""
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),

//            SafeArea(
//              child: Align(
//                alignment: Alignment.topCenter,
//                child: Container(
//                  margin: const EdgeInsets.only(bottom: 10.0),
//                  child: Image.asset(
//                    'assets/digvast_logo.png',
//                    width: MediaQuery.of(context).size.width * 0.6,
//                    height: MediaQuery.of(context).size.height * 0.6,
//                  ),
//                ),
//              ),
//            ),
      ],
    );
//      Column(
//      children: <Widget>[
////        Center(
////          child:  Container(
////            alignment: Alignment.topCenter,
////            width:MediaQuery.of(context).size.width * 0.8 ,
////            height: MediaQuery.of(context).size.height * 0.15,
////            padding: EdgeInsets.all(5),
////            decoration: BoxDecoration(
////                borderRadius:BorderRadius.circular(15),
////                color: Colors.white,
////                boxShadow:[
////                  BoxShadow(
////                      offset:Offset(0,4),
////                      blurRadius: 10,
////                      color: Colors.grey
////                  )
////                ]
////            ),
////          ),
////        )
//
////        Card()
//
//      ],
//    );
  }
}