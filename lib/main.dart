import 'package:digvast/ui/page/login.dart';
import 'package:digvast/ui/page/my_main.dart';
import 'package:digvast/ui/page/user_coin_records.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//      onGenerateRoute: (settings) {
//        final arguments = settings.arguments;
//        if(settings.name =="/userCoinRecords"){
//          return UserCoinRecordsPage();
//        }else{
//          return null;
//        }
//
//      },
      routes: {
        "/userCoinRecords": (context) => new UserCoinRecordsPage(),
      },
      title: 'DigVast',

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MaterialColor(
          0xFF000000,
          <int, Color>{
            50: Color(0xFF000000),
            100: Color(0xFF000000),
            200: Color(0xFF000000),
            300: Color(0xFF000000),
            400: Color(0xFF000000),
            500: Color(0xFF000000),
            600: Color(0xFF000000),
            700: Color(0xFF000000),
            800: Color(0xFF000000),
            900: Color(0xFF000000),
          },
        ),
      ),
      home: MyMainPage(),
    );
  }


}