import 'dart:convert';

IsacDashboardResponse? isacDashboardResponseFromJson(String str) =>
    IsacDashboardResponse.fromJson(json.decode(str));

String isacDashboardResponseToJson(IsacDashboardResponse? data) =>
    json.encode(data!.toJson());

class IsacDashboardResponse {
  IsacDashboardResponse({
    this.responseMessage,
    this.returnStatus,
    this.dashboardData,
  });

  String? responseMessage;
  int? returnStatus;
  DashboardData? dashboardData;

  factory IsacDashboardResponse.fromJson(Map<String, dynamic> json) =>
      IsacDashboardResponse(
        responseMessage: json["ResponseMessage"],
        returnStatus: json["ReturnStatus"],
        dashboardData: DashboardData.fromJson(json["DashboardData"]),
      );

  Map<String, dynamic> toJson() => {
        "ResponseMessage": responseMessage,
        "ReturnStatus": returnStatus,
        "DashboardData": dashboardData!.toJson()
      };
}

class DashboardData {
  DashboardData({
    this.identityStoreID,
    this.supervisorApprovedRequestsCount,
    this.supervisorPendingRequestsCount,
    this.supervisorRejectedRequestsCount,
    this.businessOwnerApprovedRequestsCount,
    this.businessOwnerPendingRequestsCount,
    this.businessOwnerRejectedRequestsCount,
    this.genericIDOwnerApprovedRequestsCount,
    this.genericIDOwnerPendingRequestsCount,
    this.genericIDOwnerRejectedRequestsCount,
    this.selfApprovedRequestsCount,
    this.selfPendingRequestsCount,
    this.selfRejectedRequestsCount,
    this.vendorOnboardingPendingRequestsCount,
    this.vendorOnboardingApprovedRequestsCount,
    this.vendorOnboardingRejectedRequestsCount,
    this.vendorCodePendingRequestsCount,
    this.vendorCodeApprovedRequestsCount,
    this.vendorCodeRejectedRequestsCount,
  });

  int? identityStoreID;
  int? supervisorApprovedRequestsCount;
  int? supervisorPendingRequestsCount;
  int? supervisorRejectedRequestsCount;
  int? businessOwnerApprovedRequestsCount;
  int? businessOwnerPendingRequestsCount;
  int? businessOwnerRejectedRequestsCount;
  int? genericIDOwnerApprovedRequestsCount;
  int? genericIDOwnerPendingRequestsCount;
  int? genericIDOwnerRejectedRequestsCount;
  int? selfApprovedRequestsCount;
  int? selfPendingRequestsCount;
  int? selfRejectedRequestsCount;
  int? vendorOnboardingPendingRequestsCount;
  int? vendorOnboardingApprovedRequestsCount;
  int? vendorOnboardingRejectedRequestsCount;
  int? vendorCodePendingRequestsCount;
  int? vendorCodeApprovedRequestsCount;
  int? vendorCodeRejectedRequestsCount;

  factory DashboardData.fromJson(Map<String, dynamic> json) => DashboardData(
        identityStoreID: json["IdentityStoreID"],
        supervisorApprovedRequestsCount:
            json["SupervisorApprovedRequestsCount"],
        supervisorPendingRequestsCount: json["SupervisorPendingRequestsCount"],
        supervisorRejectedRequestsCount:
            json["SupervisorRejectedRequestsCount"],
        businessOwnerApprovedRequestsCount:
            json["BusinessOwnerApprovedRequestsCount"],
        businessOwnerPendingRequestsCount:
            json["BusinessOwnerPendingRequestsCount"],
        businessOwnerRejectedRequestsCount:
            json["BusinessOwnerRejectedRequestsCount"],
        genericIDOwnerApprovedRequestsCount:
            json["GenericIDOwnerApprovedRequestsCount"],
        genericIDOwnerPendingRequestsCount:
            json["GenericIDOwnerPendingRequestsCount"],
        genericIDOwnerRejectedRequestsCount:
            json["GenericIDOwnerRejectedRequestsCount"],
        selfApprovedRequestsCount: json["SelfApprovedRequestsCount"],
        selfPendingRequestsCount: json["SelfPendingRequestsCount"],
        selfRejectedRequestsCount: json["SelfRejectedRequestsCount"],
        vendorOnboardingPendingRequestsCount:
            json["ThirdPartyPendingRequestsCount"],
        vendorOnboardingApprovedRequestsCount:
            json["ThirdPartyApprovedRequestsCount"],
        vendorOnboardingRejectedRequestsCount:
            json["ThirdPartyRejectedRequestsCount"],
        vendorCodePendingRequestsCount: json["VendorPendingRequestsCount"],
        vendorCodeApprovedRequestsCount: json["VendorApprovedRequestsCount"],
        vendorCodeRejectedRequestsCount: json["VendorRejectedRequestsCount"],
      );

  Map<String, dynamic> toJson() => {
        "IdentityStoreID": identityStoreID,
        "SupervisorApprovedRequestsCount": supervisorApprovedRequestsCount,
        "SupervisorPendingRequestsCount": supervisorPendingRequestsCount,
        "SupervisorRejectedRequestsCount": supervisorRejectedRequestsCount,
        "BusinessOwnerApprovedRequestsCount":
            businessOwnerApprovedRequestsCount,
        "BusinessOwnerPendingRequestsCount": businessOwnerPendingRequestsCount,
        "BusinessOwnerRejectedRequestsCount":
            businessOwnerRejectedRequestsCount,
        "GenericIDOwnerApprovedRequestsCount":
            genericIDOwnerApprovedRequestsCount,
        "GenericIDOwnerPendingRequestsCount":
            genericIDOwnerPendingRequestsCount,
        "GenericIDOwnerRejectedRequestsCount":
            genericIDOwnerRejectedRequestsCount,
        "SelfApprovedRequestsCount": selfApprovedRequestsCount,
        "SelfPendingRequestsCount": selfPendingRequestsCount,
        "SelfRejectedRequestsCount": selfRejectedRequestsCount,
        "ThirdPartyPendingRequestsCount": vendorOnboardingPendingRequestsCount,
        "ThirdPartyApprovedRequestsCount":
            vendorOnboardingApprovedRequestsCount,
        "ThirdPartyRejectedRequestsCount":
            vendorOnboardingRejectedRequestsCount,
        "VendorPendingRequestsCount": vendorCodePendingRequestsCount,
        "VendorApprovedRequestsCount": vendorCodeApprovedRequestsCount,
        "VendorRejectedRequestsCount": vendorCodeRejectedRequestsCount,
      };
}
