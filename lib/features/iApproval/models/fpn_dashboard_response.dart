// To parse this JSON data, do
//
//     final fpnDashboardClass = fpnDashboardClassFromJson(jsonString);

import 'dart:convert';

FpnDashboardResponse? fpnDashboardResponseFromJson(String str) =>
    FpnDashboardResponse.fromJson(json.decode(str));

String fpnDashboardResponseToJson(FpnDashboardResponse? data) =>
    json.encode(data!.toJson());

class FpnDashboardResponse {
  FpnDashboardResponse({
    this.responseMessage,
    this.returnStatus,
    this.dashboardData,
    this.role,
  });

  String? responseMessage;
  int? returnStatus;
  DashboardData? dashboardData;
  String? role;

  factory FpnDashboardResponse.fromJson(Map<String, dynamic> json) =>
      FpnDashboardResponse(
        responseMessage: json["ResponseMessage"],
        returnStatus: json["ReturnStatus"],
        dashboardData: DashboardData.fromJson(json["DashboardData"]),
        role: json["Role"],
      );

  Map<String, dynamic> toJson() => {
        "ResponseMessage": responseMessage,
        "ReturnStatus": returnStatus,
        "DashboardData": dashboardData!.toJson(),
        "Role": role,
      };
}

class DashboardData {
  DashboardData(
      {this.awaitingFeedbackRequestCount,
      this.fpnAuthorizedCount,
      this.fpnFeedbackCount,
      this.fpnPendingCount,
      this.fpnRejectedCount,
      this.fpnLockedCount});

  int? awaitingFeedbackRequestCount;
  int? fpnAuthorizedCount;
  int? fpnFeedbackCount;
  int? fpnPendingCount;
  int? fpnRejectedCount;
  int? fpnLockedCount;

  factory DashboardData.fromJson(Map<String, dynamic> json) => DashboardData(
        awaitingFeedbackRequestCount: json["AwaitingFeedbackRequestCount"],
        fpnAuthorizedCount: json["FPNAuthorizedCount"],
        fpnFeedbackCount: json["FPNFeedbackCount"],
        fpnPendingCount: json["FPNPendingCount"],
        fpnRejectedCount: json["FPNRejectedCount"],
        fpnLockedCount: json["FPNLockedCount"],
      );

  Map<String, dynamic> toJson() => {
        "AwaitingFeedbackRequestCount": awaitingFeedbackRequestCount,
        "FPNAuthorizedCount": fpnAuthorizedCount,
        "FPNFeedbackCount": fpnFeedbackCount,
        "FPNPendingCount": fpnPendingCount,
        "FPNRejectedCount": fpnRejectedCount,
        "FPNLockedCount": fpnLockedCount
      };
}
