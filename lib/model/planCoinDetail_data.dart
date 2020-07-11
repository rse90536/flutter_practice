import 'package:flutter/cupertino.dart';

class PlanCoinData {
  final List<PlanCoinDetail> data;

  PlanCoinData(this.data);

  factory PlanCoinData.fromJson(List<dynamic> jsonParsed) {
    var list = jsonParsed;
    List<PlanCoinDetail> dataList = list.map((i) =>
        PlanCoinDetail.fromJson(i)
    ).toList();

    return PlanCoinData(dataList);
  }
}

class PlanCoinDetail {
  final dynamic udcrId;
  final dynamic coinId;
  final dynamic coinEnName;
  final dynamic coinZhName;
  final dynamic amount;
  final dynamic status;
  final dynamic statusName;
  final dynamic createdAt;


  PlanCoinDetail({this.udcrId, this.coinId, this.coinEnName, this.coinZhName, this.amount, this.status, this.statusName, this.createdAt});

  factory PlanCoinDetail.fromJson(Map<String, dynamic> parsedJson) {
    return PlanCoinDetail(
        udcrId: parsedJson['UdcrId'],
        coinId: parsedJson['CoinId'],
        coinEnName: parsedJson['CoinEnName'],
        coinZhName: parsedJson['CoinZhName'],
        amount: parsedJson['Amount'],
        status: parsedJson['Status'],
        statusName: parsedJson['StatusName'],
        createdAt: parsedJson['CreatedAt'],

    );
  }
}
