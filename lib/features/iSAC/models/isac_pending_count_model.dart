import 'dart:convert';

IsacPendingCountModel pendingCountFromJson(String str) =>
    IsacPendingCountModel.fromJson(json.decode(str));

String pendingCountToJson(IsacPendingCountModel data) =>
    json.encode(data.toJson());

class IsacPendingCountModel {
  int pendingCount;
  String? responseMessage;
  int returnStatus;
  UserDetails? userDetails;

  IsacPendingCountModel({
    required this.pendingCount,
    required this.responseMessage,
    required this.returnStatus,
    required this.userDetails,
  });

  factory IsacPendingCountModel.fromJson(Map<String, dynamic> json) =>
      IsacPendingCountModel(
        pendingCount: json["PendingCount"],
        responseMessage: json["ResponseMessage"],
        returnStatus: json["ReturnStatus"],
        userDetails: json["UserDetails"] != null
            ? UserDetails.fromJson(json["UserDetails"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "PendingCount": pendingCount,
        "ResponseMessage": responseMessage,
        "ReturnStatus": returnStatus,
        "UserDetails": userDetails?.toJson(),
      };
}

class UserDetails {
  String branchCode;
  String branchName;
  String emailId;
  String empName;

  UserDetails({
    required this.branchCode,
    required this.branchName,
    required this.emailId,
    required this.empName,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        branchCode: json["BranchCode"],
        branchName: json["BranchName"],
        emailId: json["EmailId"],
        empName: json["EmpName"],
      );

  Map<String, dynamic> toJson() => {
        "BranchCode": branchCode,
        "BranchName": branchName,
        "EmailId": emailId,
        "EmpName": empName,
      };
}
