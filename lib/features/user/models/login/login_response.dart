import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.loginData,
    required this.responseMessage,
    required this.returnStatus,
    required this.isImeiExists,
  });

  String? loginData;
  String? responseMessage;
  int returnStatus;
  int? isImeiExists;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        loginData: json["LoginData"],
        responseMessage: json["ResponseMessage"],
        returnStatus: json["ReturnStatus"],
        isImeiExists: json["isIMEIExists"],
      );

  Map<String, dynamic> toJson() => {
        "LoginData": loginData,
        "ResponseMessage": responseMessage,
        "ReturnStatus": returnStatus,
        "isIMEIExists": isImeiExists,
      };
}

LogoutResponse logoutResponseFromJson(String str) =>
    LogoutResponse.fromJson(json.decode(str));

String logoutResponseToJson(LogoutResponse data) => json.encode(data.toJson());

class LogoutResponse {
  LogoutResponse({required this.responseMessage, required this.returnStatus});

  String? responseMessage;
  int returnStatus;

  factory LogoutResponse.fromJson(Map<String, dynamic> json) => LogoutResponse(
      responseMessage: json["ResponseMessage"],
      returnStatus: json["ReturnStatus"]);

  Map<String, dynamic> toJson() =>
      {"ResponseMessage": responseMessage, "ReturnStatus": returnStatus};
}
