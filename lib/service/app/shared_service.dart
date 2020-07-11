import 'package:digvast/service/app/shared_data.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class SharedService {
  static BuildContext mainContext;

  static SnackBar _sb;
  static var dio = Dio();
//  static void upDateFun={};
static void upDateFun;

  static void showMessage(BuildContext context, String text) {
    if (_sb != null) Scaffold.of(context).hideCurrentSnackBar();
    _sb = SnackBar(
      content: Text(
        text,
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.white,
        ),
      ),
    );
    Scaffold.of(context).showSnackBar(_sb);
  }

  static void showErrorMessage(BuildContext context, String text) {
//    if (_sb != null) Scaffold.of(context).hideCurrentSnackBar();
    _sb = SnackBar(
      content: Text(
        text,
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.red,
        ),
      ),
    );
    Scaffold.of(context).showSnackBar(_sb);
  }

  static void showLoadingDialog(BuildContext context) {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {},
            child: Center(
              child: SizedBox(
                width: 100.0,
                height: 100.0,
                child: CircularProgressIndicator(
                  strokeWidth: 10.0,
                ),
              ),
            ),
          );
        });
  }

  static void setDio() {
    BaseOptions options = BaseOptions(
      baseUrl: SharedData.serverUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
     dio = Dio(options);
  }

  static String formatNum(num, {point: 3}) {
    if (num != null) {
      String str = double.parse(num.toString()).toString();
      // 分开截取
      List<String> sub = str.split('.');
      // 处理值
      List val = List.from(sub[0].split(''));
      // 处理点
      List<String> points = List.from(sub[1].split(''));
      //处理分割符
      for (int index = 0, i = val.length - 1; i >= 0; index++, i--) {
        // 除以三没有余数、不等于零并且不等于1 就加个逗号
        if (index % 3 == 0 && index != 0 && i != 1) val[i] = val[i] + ',';
      }
      // 处理小数点
      for (int i = 0; i <= point - points.length; i++) {
        points.add('0');
      }
      //如果大于长度就截取
      if (points.length > point) {
        // 截取数组
        points = points.sublist(0, point);
      }
      // 判断是否有长度
      if (points.length > 0) {
        return '${val.join('')}.${points.join('')}';
      } else {
        return val.join('');
      }
    } else {
      return "0.0";
    }
  }
  static Color colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }


}
