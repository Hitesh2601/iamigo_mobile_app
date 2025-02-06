import 'dart:convert';

FpnFeedbackReplyClass fpnFeedbackReplyClassFromJson(String str) =>
    FpnFeedbackReplyClass.fromJson(json.decode(str));

String fpnFeedbackReplyClassToJson(FpnFeedbackReplyClass data) =>
    json.encode(data.toJson());

class FpnFeedbackReplyClass {
  FpnFeedbackReplyClass({
    required this.responseMessage,
    required this.returnStatus,
    required this.fpnReplyData,
  });

  String responseMessage;
  int returnStatus;
  String fpnReplyData;

  factory FpnFeedbackReplyClass.fromJson(Map<String, dynamic> json) =>
      FpnFeedbackReplyClass(
        responseMessage: json["ResponseMessage"],
        returnStatus: json["ReturnStatus"],
        fpnReplyData: json["FPNReplyData"],
      );

  Map<String, dynamic> toJson() => {
        "ResponseMessage": responseMessage,
        "ReturnStatus": returnStatus,
        "FPNReplyData": fpnReplyData,
      };
}
