
import 'dart:io';

import 'package:digvast/model/userCoinAmounts_data.dart';
import 'package:flutter/cupertino.dart';

class SharedData {

  static final serverUrl = "https://www.digvast.com/api";
  static var token = "";
  static var httpClient = HttpClient();
  static Map<String, dynamic> userData;
  static NetworkImage userImage;
  static List<CoinAmountsData> coinAmountsData;
  static List<double> sellInfoData;


//
//  static Map<String, dynamic> userData;
//  static List<dynamic> chatList;
}