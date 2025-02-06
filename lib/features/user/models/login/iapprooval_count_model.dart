import 'dart:convert';

IApprovalCountModel pendingCountFromJson(String str) =>
    IApprovalCountModel.fromJson(json.decode(str));

String pendingCountToJson(IApprovalCountModel data) =>
    json.encode(data.toJson());

class IApprovalCountModel {
  String responseMessage;
  int returnStatus;
  String pendingCount;

  IApprovalCountModel({
    required this.responseMessage,
    required this.returnStatus,
    required this.pendingCount,
  });
  factory IApprovalCountModel.fromJson(Map<String, dynamic> json) =>
      IApprovalCountModel(
        pendingCount: json["PendingCount"],
        responseMessage: json["ResponseMessage"],
        returnStatus: json["ReturnStatus"],
      );

  Map<String, dynamic> toJson() => {
        "PendingCount": pendingCount,
        "ResponseMessage": responseMessage,
        "ReturnStatus": returnStatus,
      };
}
