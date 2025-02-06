import 'dart:convert';

ICartCountModel pendingCountFromJson(String str) =>
    ICartCountModel.fromJson(json.decode(str));

String pendingCountToJson(ICartCountModel data) => json.encode(data.toJson());

class ICartCountModel {
  String responseMessage;
  int returnStatus;
  int pendingCount;

  ICartCountModel({
    required this.responseMessage,
    required this.returnStatus,
    required this.pendingCount,
  });
  factory ICartCountModel.fromJson(Map<String, dynamic> json) =>
      ICartCountModel(
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
