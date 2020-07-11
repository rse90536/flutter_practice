import 'package:flutter/cupertino.dart';

class UserCoinAmounts {
  final List<CoinAmountsData> data;

  UserCoinAmounts(this.data);

  factory UserCoinAmounts.fromJson(List<dynamic> jsonParsed) {
    var list = jsonParsed;
    List<CoinAmountsData> dataList = list.map((i) =>
        CoinAmountsData.fromJson(i)
    ).toList();

    return UserCoinAmounts(dataList);
  }
}

class CoinAmountsData {
  final int coinId;
  final dynamic coinEnName;
  final dynamic coinZhName;
  final dynamic amount;
  final dynamic usdPrice;


  CoinAmountsData({this.coinId, this.coinEnName, this.coinZhName, this.amount, this.usdPrice});

  factory CoinAmountsData.fromJson(Map<String, dynamic> parsedJson) {
    return CoinAmountsData(
      coinId: parsedJson['CoinId'],
      coinEnName: parsedJson['CoinEnName'],
      coinZhName: parsedJson['CoinZhName'],
      amount: parsedJson['Amount'],
      usdPrice: parsedJson['UsdPrice'],
    );
  }
}
