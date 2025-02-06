// ignore_for_file: constant_identifier_names

import 'dart:convert';

TcoDetailResponse tcoDetailClassFromJson(String str) =>
    TcoDetailResponse.fromJson(json.decode(str));

String tcoDetailClassToJson(TcoDetailResponse data) =>
    json.encode(data.toJson());

class TcoDetailResponse {
  TcoDetailResponse({
    required this.responseMessage,
    required this.returnStatus,
    required this.fpnAmt,
    required this.fpnAmtWord,
    required this.fpnNo,
    required this.tcoNo,
    required this.yearsCount,
    required this.vData,
    required this.vNewData,
  });

  String? responseMessage;
  int returnStatus;
  String? fpnAmt;
  String? fpnAmtWord;
  String? fpnNo;
  String? tcoNo;
  int yearsCount;
  String? vData;
  List<VNewDatum> vNewData;

  factory TcoDetailResponse.fromJson(Map<String, dynamic> json) =>
      TcoDetailResponse(
        responseMessage: json["ResponseMessage"],
        returnStatus: json["ReturnStatus"],
        fpnAmt: json["FpnAmt"],
        fpnAmtWord: json["FpnAmtWord"],
        fpnNo: json["FpnNo"],
        tcoNo: json["TcoNo"],
        yearsCount: json["YearsCount"],
        vData: json["vData"],
        vNewData: List<VNewDatum>.from(
            json["vNewData"].map((x) => VNewDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ResponseMessage": responseMessage,
        "ReturnStatus": returnStatus,
        "FpnAmt": fpnAmt,
        "FpnAmtWord": fpnAmtWord,
        "FpnNo": fpnNo,
        "TcoNo": tcoNo,
        "YearsCount": yearsCount,
        "vData": vData,
        "vNewData": List<dynamic>.from(vNewData.map((x) => x.toJson())),
      };
}

class VNewDatum {
  VNewDatum({
    required this.totalExpenditureCost,
    required this.serialNo,
    required this.sortOrder,
    required this.totalAmt,
    required this.year1,
    required this.year2,
    required this.year3,
    required this.year4,
    required this.year5,
    required this.displayGridStyle,
  });

  String? totalExpenditureCost;
  int serialNo;
  String? sortOrder;
  String? totalAmt;
  String? year1;
  String? year2;
  String? year3;
  String? year4;
  String? year5;
  DisplayGridStyle displayGridStyle;

  factory VNewDatum.fromJson(Map<String, dynamic> json) => VNewDatum(
        totalExpenditureCost: json["TotalExpenditureCost"],
        serialNo: json["SerialNo"],
        sortOrder: json["SortOrder"],
        totalAmt: json["TotalAmt"],
        year1: json["Year1"],
        year2: json["Year2"],
        year3: json["Year3"],
        year4: json["Year4"],
        year5: json["Year5"],
        displayGridStyle: displayGridStyleValues.map[json["DisplayGridStyle"]]!,
      );

  Map<String, dynamic> toJson() => {
        "TotalExpenditureCost": totalExpenditureCost,
        "SerialNo": serialNo,
        "SortOrder": sortOrder,
        "TotalAmt": totalAmt,
        "Year1": year1,
        "Year2": year2,
        "Year3": year3,
        "Year4": year4,
        "Year5": year5,
        "DisplayGridStyle": displayGridStyleValues.reverse[displayGridStyle],
      };
}

enum DisplayGridStyle { SUB_HEADER, EMPTY, SUB_MAIN_HEADER, TEXT }

final displayGridStyleValues = EnumValues({
  "": DisplayGridStyle.EMPTY,
  "SubHeader": DisplayGridStyle.SUB_HEADER,
  "SubMainHeader": DisplayGridStyle.SUB_MAIN_HEADER,
  "Text": DisplayGridStyle.TEXT
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
