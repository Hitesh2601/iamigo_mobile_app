import 'dart:convert';

FpnLoginResponse? fpnLoginClassFromJson(String str) =>
    FpnLoginResponse.fromJson(json.decode(str));

String fpnLoginClassToJson(FpnLoginResponse? data) =>
    json.encode(data!.toJson());

class FpnLoginResponse {
  FpnLoginResponse({
    this.responseMessage,
    this.returnStatus,
    this.fpnLoginData,
    this.isImeiExists,
  });

  String? responseMessage;
  int? returnStatus;
  FpnLoginData? fpnLoginData;
  int? isImeiExists;

  factory FpnLoginResponse.fromJson(Map<String, dynamic> json) =>
      FpnLoginResponse(
        responseMessage: json["ResponseMessage"],
        returnStatus: json["ReturnStatus"],
        fpnLoginData: json["FPNLoginData"] == null
            ? null
            : FpnLoginData.fromJson(json["FPNLoginData"]),
        isImeiExists: json["isIMEIExists"],
      );

  Map<String, dynamic> toJson() => {
        "ResponseMessage": responseMessage,
        "ReturnStatus": returnStatus,
        "FPNLoginData": fpnLoginData!.toJson(),
        "isIMEIExists": isImeiExists,
      };
}

class FpnLoginData {
  FpnLoginData({
    this.currentLoginDate,
    this.empCode,
    this.empName,
    this.lastLoginDate,
    this.profile,
  });

  String? currentLoginDate;
  String? empCode;
  String? empName;
  String? lastLoginDate;
  String? profile;

  factory FpnLoginData.fromJson(Map<String, dynamic> json) => FpnLoginData(
        currentLoginDate: json["CurrentLoginDate"],
        empCode: json["EmpCode"],
        empName: json["EmpName"],
        lastLoginDate: json["LastLoginDate"],
        profile: json["Profile"],
      );

  Map<String, dynamic> toJson() => {
        "CurrentLoginDate": currentLoginDate,
        "EmpCode": empCode,
        "EmpName": empName,
        "LastLoginDate": lastLoginDate,
        "Profile": profile,
      };
}
