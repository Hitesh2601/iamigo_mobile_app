class ICartApproveReject {
  String? responseMessage;
  int? returnStatus;
  List<ApprovalStatus>? approvalStatus;
  String? profile;
  String? requestType;
  String? userId;

  ICartApproveReject(
      {this.responseMessage,
      this.returnStatus,
      this.approvalStatus,
      this.profile,
      this.requestType,
      this.userId});

  ICartApproveReject.fromJson(Map<String, dynamic> json) {
    responseMessage = json['ResponseMessage'];
    returnStatus = json['ReturnStatus'];
    if (json['ApprovalStatus'] != null) {
      approvalStatus = <ApprovalStatus>[];
      json['ApprovalStatus'].forEach((v) {
        approvalStatus!.add(ApprovalStatus.fromJson(v));
      });
    }
    profile = json['Profile'];
    requestType = json['RequestType'];
    userId = json['UserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ResponseMessage'] = responseMessage;
    data['ReturnStatus'] = returnStatus;
    if (approvalStatus != null) {
      data['ApprovalStatus'] = approvalStatus!.map((v) => v.toJson()).toList();
    }
    data['Profile'] = profile;
    data['RequestType'] = requestType;
    data['UserId'] = userId;
    return data;
  }
}

class ApprovalStatus {
  String? errorMsg;
  String? lastLevel;
  String? requestNo;
  String? requestStatus;

  ApprovalStatus(
      {this.errorMsg, this.lastLevel, this.requestNo, this.requestStatus});

  ApprovalStatus.fromJson(Map<String, dynamic> json) {
    errorMsg = json['ErrorMsg'];
    lastLevel = json['LastLevel'];
    requestNo = json['RequestNo'];
    requestStatus = json['RequestStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ErrorMsg'] = errorMsg;
    data['LastLevel'] = lastLevel;
    data['RequestNo'] = requestNo;
    data['RequestStatus'] = requestStatus;
    return data;
  }
}
