import 'package:flutter/cupertino.dart';

class UserCoinRecords {
  final List<UserCoinRecordsData> data;

  UserCoinRecords(this.data);

  factory UserCoinRecords.fromJson(List<dynamic> jsonParsed) {
    var list = jsonParsed;
    debugPrint(list.toString());
    List<UserCoinRecordsData> dataList = list.map((i) =>
        UserCoinRecordsData.fromJson(i)
    ).toList();

    return UserCoinRecords(dataList);
  }
}

class UserCoinRecordsData {
  final int ucrId;
  final dynamic coinId;
  final dynamic coinEnName;
  final dynamic coinZhName;
  final dynamic amount;
  final int type;
  final dynamic typeName;
  final dynamic fromUserPlanName;
  final dynamic fromUserName;
  final dynamic createdAt;


  UserCoinRecordsData({this.ucrId, this.coinId, this.coinEnName, this.coinZhName, this.amount, this.type, this.typeName, this.fromUserPlanName, this.fromUserName, this.createdAt});

  factory UserCoinRecordsData.fromJson(Map<String, dynamic> parsedJson) {
    return UserCoinRecordsData(
      ucrId: parsedJson['UcrId'],
      coinId: parsedJson['CoinId'],
      coinEnName: parsedJson['CoinEnName'],
      coinZhName: parsedJson['CoinZhName'],
      amount: parsedJson['Amount'],
      type: parsedJson['Type'],
      typeName: parsedJson['TypeName'],
      fromUserPlanName: parsedJson['FromUserPlanName'],
      fromUserName: parsedJson['FromUserName'],
      createdAt: parsedJson['CreatedAt'],
    );
  }
}
