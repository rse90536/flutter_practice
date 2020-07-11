import 'dart:ffi';

import 'package:digvast/service/app/shared_data.dart';
import 'package:digvast/service/app/shared_service.dart';
import 'package:digvast/ui/page/user_coin_records.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';

import 'home.dart';
import 'my_clipper.dart';
import 'my_main.dart';

class LoginPage extends StatefulWidget {
//  final bool _isLoadingUserData;
//  final MyMainPageState _myMainPageState;

  final MyMainPageState _myMainPageState;

  LoginPage(this._myMainPageState, {Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

//Future callAsyncFetch() =>
//    Future.delayed(Duration(seconds: 2), () => getCoinDetailList());

class _LoginPageState extends State<LoginPage> {
  final _accountController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  var isLoading = false;

//  GlobalKey _keyStack = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
//        resizeToAvoidBottomInset: false,
      appBar: new AppBar(title: new Text('DigVast')),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          // 触摸收起键盘
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Stack(
          children: <Widget>[
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.black
//              gradient: LinearGradient()
                    ),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.4,
              left: MediaQuery.of(context).size.width * 0.5,
              child: SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    child: Image.asset(
                      'assets/dcoin.png',
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.6,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.5,
              right: MediaQuery.of(context).size.width * 0.5,
              child: SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    child: Image.asset(
                      'assets/digvast_logo.png',
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.6,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.6,
              left: MediaQuery.of(context).size.width * 0.6,
              child: SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    child: Image.asset(
                      'assets/group46.png',
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.4,
                    ),
                  ),
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
            SafeArea(
              child: Align(
                  alignment: Alignment.center,
                  child: isLoading
                      ? CircularProgressIndicator(
                          backgroundColor: Colors.red,
                        )
                      : _setLoginBody()),
            ),
          ],
        ),
      ),

//      GestureDetector(
//        behavior: HitTestBehavior.translucent,
//        onTap: () {
//          // 触摸收起键盘
//          FocusScope.of(context).requestFocus(FocusNode());
//        },
//        child: _setLoginBody(),
//      ),
//      backgroundColor: Colors.indigo,
    );
  }

  Widget _setLoginBody() {
    return Stack(
//      overflow: Overflow.visible,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
//              crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
//                Container(
//                  margin: const EdgeInsets.only(bottom: 10.0),
//                  child: Image.asset(
//                    'assets/blockchain.png',
//                    width: 100,
//                    height: 100,
//                  ),
//                ),
//              Container(
//                padding: const EdgeInsets.only(left: 5.0),
//                color: Colors.white,
//                width: MediaQuery.of(context).size.width * 0.8,
//                margin: const EdgeInsets.only(bottom: 5.0),
//                child: TextField(
//                  onSubmitted: (text) {
//                    FocusScope.of(context).requestFocus(_passwordFocusNode);
//                  },
//                  style: TextStyle(fontSize: 22.0, color: Colors.black),
//                  controller: _accountController,
//                  textAlign: TextAlign.start,
//                  decoration: InputDecoration(
////                      border: InputBorder.,
////                        contentPadding:
////                            const EdgeInsets.fromLTRB(3.0, 0.0, 0.0, 0.0),
//                      icon: Icon(Icons.perm_identity),
//                      labelText: "帳號",
//                      enabledBorder: const OutlineInputBorder(
//                        borderSide:
//                            const BorderSide(color: Colors.grey, width: 1.0),
//                      ),
//                      border: OutlineInputBorder(
//                        borderRadius: BorderRadius.circular(15.0),
//                      )),
//                ),
//              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  onSubmitted: (text) {
                    FocusScope.of(context).requestFocus(_passwordFocusNode);
                  },
                  style: TextStyle(fontSize: 22.0, color: Colors.black),
                  controller: _accountController,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
//                      border: InputBorder.,
//                        contentPadding:
//                            const EdgeInsets.fromLTRB(3.0, 0.0, 0.0, 0.0),
                      icon: Icon(Icons.perm_identity),
                      labelText: "帳號",
                      enabledBorder: const OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  onSubmitted: (text) {
                    FocusScope.of(context).requestFocus(_passwordFocusNode);
                  },
                  obscureText: true,
                  style: TextStyle(fontSize: 22.0, color: Colors.black),
                  controller: _passwordController,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
//                      border: InputBorder.,
//                        contentPadding:
//                            const EdgeInsets.fromLTRB(3.0, 0.0, 0.0, 0.0),
                    icon: Icon(Icons.lock),
                    labelText: "密碼",
                    enabledBorder: const OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                            style: BorderStyle.solid)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ),
//              Container(
//                padding: const EdgeInsets.only(left: 5.0),
//                color: Colors.white,
//                width: MediaQuery.of(context).size.width * 0.8,
//                margin: const EdgeInsets.only(top: 5.0),
//                child: TextField(
//                  onSubmitted: (text) {
//                    FocusScope.of(context).requestFocus(_passwordFocusNode);
//                  },
//                  obscureText: true,
//                  style: TextStyle(fontSize: 22.0, color: Colors.black),
//                  controller: _passwordController,
//                  textAlign: TextAlign.start,
//                  decoration: InputDecoration(
////                      border: InputBorder.,
////                        contentPadding:
////                            const EdgeInsets.fromLTRB(3.0, 0.0, 0.0, 0.0),
//                    icon: Icon(Icons.lock),
//                    labelText: "密碼",
//                    enabledBorder: const OutlineInputBorder(
//                        borderSide: const BorderSide(
//                            color: Colors.grey,
//                            width: 1.0,
//                            style: BorderStyle.solid)),
//                    border: OutlineInputBorder(
//                      borderRadius: BorderRadius.circular(15.0),
//                    ),
//                  ),
//                ),
//              ),
              new Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: (RaisedButton(
                  child: Text(
                    "登入",
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
//                      FocusScope.of(context).requestFocus(FocusNode());
                    _login();
                  },
                  color: Colors.blue,
                  highlightColor: Colors.green,
                  splashColor: Colors.green,
                )),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void nowLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<void> _login() async {
//    final account = _accountController.text;
    final account = "fsmytsai@gmail.com";
    if (account == "") {
//      SharedService.showErrorMessage(SharedService.mainContext, "請輸入帳號");
//      return;
    }
    final password = "test01";

//    final password = _passwordController.text;

    if (password == "") {
//      SharedService.showErrorMessage(SharedService.mainContext, "請輸入密碼");
//      return;
    }
    nowLoading();
//    SharedService.showLoadingDialog(SharedService.mainContext);
    SharedService.setDio();
//     var dio = Dio();

    Response response;
    try {
      response = await SharedService.dio
          .post("/login", data: {"Email": account, "Password": password});
      debugPrint('movieTitle2: ${response.statusCode}');
      if (response.statusCode == HttpStatus.ok) {
        SharedData.token = response.data.toString();
        debugPrint('movieTitle: ${SharedData.token}');
        _getUserData();
//        widget._myMainPageState.loginSuccess();

//        Navigator.push(
//          context,
//          MaterialPageRoute(
//            builder: (context) => HomePage(),
//          ),
//        );
//        debugPrint('movieTitle4: ${response.data}');

//        print(response.data);
      } else {
        nowLoading();
        debugPrint('error:netError}');
      }
    } catch (exception) {
      nowLoading();
      debugPrint('movieTitle3: $exception');

//      result =exception.toString();
    }
  }

  Future<void> _getUserData() async {
    SharedService.dio.options.headers["authorization"] =
        "Bearer ${SharedData.token}";

    try {
      var response = await SharedService.dio.get("/getUserData");
      if (response.statusCode == HttpStatus.ok) {
        SharedData.userData = json.decode(response.toString());
        SharedData.userImage = NetworkImage(
            "https://www.digvast.com/images/profilePics/thumbnail/${SharedData.userData["ProfilePic"]}");

        widget._myMainPageState.loginSuccess();
      } else {
        debugPrint('error:netError}');
      }
    } catch (exception) {
      debugPrint('movieTitle3: $exception');

//      result =exception.toString();
    }
  }
}

//class MyClipper extends CustomClipper<Path> {
//  @override
//  Path getClip(Size size) {
//    var path = Path();
//
//    path.lineTo(0, size.height - 80);
//    path.quadraticBezierTo(
//        size.width / 2, size.height, size.width, size.height - 80);
//    path.lineTo(size.width, 0);
//    path.close();
//    return path;
//  }
//
//  @override
//  bool shouldReclip(CustomClipper<Path> oldClipper) {
//    return false;
//  }
//}
