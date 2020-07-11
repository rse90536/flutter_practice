import 'package:flutter/cupertino.dart';

class MyPlanData {
  final List<Data> data;

  MyPlanData(this.data);

  factory MyPlanData.fromJson(List<dynamic> jsonParsed) {
    var list = jsonParsed;
    List<Data> dataList = list.map((i) =>
        Data.fromJson(i)
    ).toList();

    return MyPlanData(dataList);
  }
}

class Data {
  final dynamic upId;
  final dynamic power;
  final dynamic period;
  final dynamic periodUnit;
  final dynamic fullPeriod;
  final dynamic userPlanName;
  final dynamic referrerUserId;
  final dynamic referrerUserName;
  final dynamic referrerUserProfilePic;
  final dynamic startTime;
  final dynamic endTime;
  final dynamic stopTime;
  final dynamic status;
  final dynamic statusName;
  final dynamic createdAt;
//  final int upId;
//  final String power;
//  final int period;
//  final String periodUnit;
//  final String fullPeriod;
//  final String userPlanName;
//  final int referrerUserId;
//  final String referrerUserName;
//  final String referrerUserProfilePic;
//  final String startTime;
//  final String endTime;
//  final dynamic stopTime;
//  final int status;
//  final String statusName;
//  final String createdAt;

  Data({this.upId, this.power, this.period, this.periodUnit, this.fullPeriod,
      this.userPlanName, this.referrerUserId, this.referrerUserName,
      this.referrerUserProfilePic, this.startTime, this.endTime, this.stopTime,
      this.status, this.statusName, this.createdAt});

  factory Data.fromJson(Map<String, dynamic> parsedJson) {
    return Data(
        upId: parsedJson['UpId'],
        power: parsedJson['Power'],
        period: parsedJson['Period'],
        periodUnit: parsedJson['PeriodUnit'],
        fullPeriod: parsedJson['FullPeriod'],
        userPlanName: parsedJson['UserPlanName'],
        referrerUserId: parsedJson['ReferrerUserId'],
        referrerUserName: parsedJson['ReferrerUserName'],
        referrerUserProfilePic: parsedJson['ReferrerUserProfilePic'],
        startTime: parsedJson['StartTime'],
        endTime: parsedJson['EndTime'],
        stopTime: parsedJson['StopTime'],
        status: parsedJson['Status'],
        statusName: parsedJson['StatusName'],
        createdAt: parsedJson['EndTime']
        );
  }
}
