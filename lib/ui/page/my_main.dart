import 'package:flutter/cupertino.dart';

import 'home.dart';
import 'login.dart';

class MyMainPage extends StatefulWidget {
  MyMainPage({Key key}) : super(key: key);

  @override
  MyMainPageState createState() => MyMainPageState();
}

class MyMainPageState extends State<MyMainPage> {
  var _isLogin = true;

  @override
  Widget build(BuildContext context) {
    if (_isLogin)
      return LoginPage(this);
    else
      return HomePage(this);

  }
  void goLogin() {
    setState(() {
      _isLogin = true;
    });
  }

  void loginSuccess() {
    setState(() {
      _isLogin = false;
    });
  }

}
