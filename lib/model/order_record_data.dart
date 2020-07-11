
class OrderRecordData {
  final List<RecordData> data;

  OrderRecordData(this.data);

  factory OrderRecordData.fromJson(List<dynamic> jsonParsed) {
    var list = jsonParsed;
    List<RecordData> dataList =
        list.map((i) => RecordData.fromJson(i)).toList();

    return OrderRecordData(dataList);
  }
}

class RecordData {
  final dynamic bprId;
  final dynamic power;
  final dynamic period;
  final dynamic periodUnit;
  final dynamic fullPeriod;
  final dynamic discountId;
  final dynamic referrerUserName;
  final dynamic referrerUserProfilePic;
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

  RecordData(
      {this.bprId,
      this.power,
      this.period,
      this.periodUnit,
      this.fullPeriod,
      this.discountId,
      this.status,
      this.referrerUserName,
      this.referrerUserProfilePic,
      this.createdAt,
      this.statusName});

  factory RecordData.fromJson(Map<String, dynamic> parsedJson) {
    return RecordData(
        bprId: parsedJson['BprId'],
        power: parsedJson['Power'],
        period: parsedJson['Period'],
        periodUnit: parsedJson['PeriodUnit'],
        fullPeriod: parsedJson['FullPeriod'],
        discountId: parsedJson['DiscountId'],
        status: parsedJson['Status'],
        referrerUserName: parsedJson['ReferrerUserName'],
        referrerUserProfilePic: parsedJson['ReferrerUserProfilePic'],
        statusName: parsedJson['StatusName'],
        createdAt: parsedJson['CreatedAt']);
  }
}
