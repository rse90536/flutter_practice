import 'package:flutter/cupertino.dart';

class GetImmediateUserPlansData {
  final List<ImmediateUserPlansData> data;

  GetImmediateUserPlansData(this.data);

  factory GetImmediateUserPlansData.fromJson(List<dynamic> jsonParsed) {
    var list = jsonParsed;
    List<ImmediateUserPlansData> dataList =
        list.map((i) => ImmediateUserPlansData.fromJson(i)).toList();

    return GetImmediateUserPlansData(dataList);
  }
}

class ImmediateUserPlansData {
  final dynamic upId;
  final dynamic userPlanName;
  final dynamic startTime;
  final dynamic endTime;
  final dynamic status;
  final dynamic statusName;
  final dynamic userPlanDigCoins;

  ImmediateUserPlansData(
      {this.upId,
      this.userPlanName,
      this.startTime,
      this.endTime,
      this.status,
      this.statusName,
      this.userPlanDigCoins});

  factory ImmediateUserPlansData.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson["UserPlanDigCoins"];
   List<dynamic> dataList =
        list.map((i) => ImmediateUserPlansDetailData.fromJson(i)).toList();

    return ImmediateUserPlansData(
        upId: parsedJson['UpId'],
        userPlanName: parsedJson['UserPlanName'],
        startTime: parsedJson['StartTime'],
        endTime: parsedJson['EndTime'],
        status: parsedJson['Status'],
        statusName: parsedJson['StatusName'],
        userPlanDigCoins: dataList);
  }
}

class ImmediateUserPlansDetailData {
  final dynamic upId;
  final dynamic coinId;
  final dynamic coinEnName;
  final dynamic coinZhName;
  final dynamic amount;

  ImmediateUserPlansDetailData(
      {this.upId, this.coinId, this.coinEnName, this.coinZhName, this.amount});

  factory ImmediateUserPlansDetailData.fromJson(
      Map<String, dynamic> parsedJson) {
    return ImmediateUserPlansDetailData(
      upId: parsedJson['UpId'],
      coinId: parsedJson['CoinId'],
      coinEnName: parsedJson['CoinEnName'],
      coinZhName: parsedJson['CoinZhName'],
      amount: parsedJson['Amount'],
    );
  }
}
