import 'package:flutter/cupertino.dart';

class AllPlanData {
  final List<PlanData> data;

  AllPlanData(this.data);

  factory AllPlanData.fromJson(List<dynamic> jsonParsed) {
    var list = jsonParsed;
    List<PlanData> dataList = list.map((i) =>
        PlanData.fromJson(i)
    ).toList();

    return AllPlanData(dataList);
  }
}

class PlanData {

  final int planId;
  final String power;
  final int period;
  final String periodUnit;
  final String fullPeriod;
  final String currencyEnName;
  final String currencyZhName;
  final int amount;
  final int gbPower;
  final bool trial;


  PlanData({this.planId, this.power, this.period, this.periodUnit, this.fullPeriod,
    this.currencyEnName, this.currencyZhName, this.amount,this.gbPower,this.trial});

  factory PlanData.fromJson(Map<String, dynamic> parsedJson) {
    return PlanData(
        planId: parsedJson['PlanId'],
        power: parsedJson['Power'],
        period: parsedJson['Period'],
        periodUnit: parsedJson['PeriodUnit'],
        fullPeriod: parsedJson['FullPeriod'],
        currencyEnName: parsedJson['CurrencyEnName'],
        currencyZhName: parsedJson['CurrencyZhName'],
        amount: parsedJson['Amount'],
        gbPower: parsedJson['GbPower'],
        trial: parsedJson['Trial']
    );
  }
}
