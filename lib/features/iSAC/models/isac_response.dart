import 'dart:convert';

ISACResponse iSACResponseFromJson(String str) =>
    ISACResponse.fromJson(json.decode(str));

String iSACResponseToJson(ISACResponse data) => json.encode(data.toJson());

class ISACResponse {
  ISACResponse({
    required this.responseMessage,
    required this.returnStatus,
  });

  String? responseMessage;
  int? returnStatus;

  factory ISACResponse.fromJson(Map<String, dynamic> json) => ISACResponse(
        responseMessage: json["ResponseMessage"],
        returnStatus: json["ReturnStatus"],
      );

  Map<String, dynamic> toJson() => {
        "ResponseMessage": responseMessage,
        "ReturnStatus": returnStatus,
      };
}
