class ICartDashboardResponse {
  String? responseMessage;
  int? returnStatus;
  List<DashboardData>? dashboardData;

  ICartDashboardResponse(
      {this.responseMessage, this.returnStatus, this.dashboardData});

  ICartDashboardResponse.fromJson(Map<String, dynamic> json) {
    responseMessage = json['ResponseMessage'];
    returnStatus = json['ReturnStatus'];
    if (json['DashboardData'] != null) {
      dashboardData = <DashboardData>[];
      json['DashboardData'].forEach((v) {
        dashboardData!.add(DashboardData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ResponseMessage'] = responseMessage;
    data['ReturnStatus'] = returnStatus;
    if (dashboardData != null) {
      data['DashboardData'] = dashboardData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DashboardData {
  int? approved;
  int? delegatedPending;
  int? pending;
  String? profile;
  int? rejected;

  DashboardData(
      {this.approved,
      this.delegatedPending,
      this.pending,
      this.profile,
      this.rejected});

  DashboardData.fromJson(Map<String, dynamic> json) {
    approved = json['Approved'];
    delegatedPending = json['DelegatedPending'];
    pending = json['Pending'];
    profile = json['Profile'];
    rejected = json['Rejected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Approved'] = approved;
    data['DelegatedPending'] = delegatedPending;
    data['Pending'] = pending;
    data['Profile'] = profile;
    data['Rejected'] = rejected;
    return data;
  }
}
