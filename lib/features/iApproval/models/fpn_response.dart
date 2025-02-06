class FpnResponse {
  String? responseMessage;
  int? returnStatus;

  FpnResponse({
    required this.responseMessage,
    required this.returnStatus,
  });

  factory FpnResponse.fromJson(Map<String, dynamic> json) => FpnResponse(
        responseMessage: json["ResponseMessage"],
        returnStatus: json["ReturnStatus"],
      );

  Map<String, dynamic> toJson() => {
        "ResponseMessage": responseMessage,
        "ReturnStatus": returnStatus,
      };
}
