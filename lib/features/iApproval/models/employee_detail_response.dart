import 'dart:convert';

FpnEmployeeDetailsResponse fpnEmployeeDetailsClassFromJson(String str) =>
    FpnEmployeeDetailsResponse.fromJson(json.decode(str));

String fpnEmployeeDetailsClassToJson(FpnEmployeeDetailsResponse data) =>
    json.encode(data.toJson());

class FpnEmployeeDetailsResponse {
  FpnEmployeeDetailsResponse({
    required this.responseMessage,
    required this.returnStatus,
    required this.employeeNameDetails,
  });

  String responseMessage;
  int returnStatus;
  List<EmployeeNameDetail>? employeeNameDetails;

  factory FpnEmployeeDetailsResponse.fromJson(Map<String, dynamic> json) =>
      FpnEmployeeDetailsResponse(
        responseMessage: json["ResponseMessage"],
        returnStatus: json["ReturnStatus"],
        employeeNameDetails: json["EmployeeNameDetails"] != null
            ? List<EmployeeNameDetail>.from(json["EmployeeNameDetails"]
                .map((x) => EmployeeNameDetail.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "ResponseMessage": responseMessage,
        "ReturnStatus": returnStatus,
        "EmployeeNameDetails":
            List<dynamic>.from(employeeNameDetails!.map((x) => x.toJson())),
      };
}

class EmployeeNameDetail {
  EmployeeNameDetail({
    required this.employeeCode,
    required this.employeeName,
  });

  String employeeCode;
  String employeeName;

  factory EmployeeNameDetail.fromJson(Map<String, dynamic> json) =>
      EmployeeNameDetail(
        employeeCode: json["EmployeeCode"],
        employeeName: json["EmployeeName"],
      );

  Map<String, dynamic> toJson() => {
        "EmployeeCode": employeeCode,
        "EmployeeName": employeeName,
      };
}
