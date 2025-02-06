class FpnRequestListResponse {
  String? responseMessage;
  int? returnStatus;
  List<FPNData>? data;

  FpnRequestListResponse({this.responseMessage, this.returnStatus, this.data});

  FpnRequestListResponse.fromJson(Map<String, dynamic> json) {
    responseMessage = json['ResponseMessage'];
    returnStatus = json['ReturnStatus'];
    if (json['data'] != null) {
      data = <FPNData>[];
      json['data'].forEach((v) {
        data!.add(FPNData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ResponseMessage'] = responseMessage;
    data['ReturnStatus'] = returnStatus;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FPNData {
  String? cashFlowAmount;
  String? fPNAmount;
  String? fPNCategory;
  String? fPNNumber;
  String? fPNSubCategory;
  String? feedbackText;
  String? finConAnalystRemark;
  String? nonCashFlowAmount;
  String? projectDescription;
  String? projectName;
  String? receiverEmpCode;
  String? userLevel;

  FPNData(
      {this.cashFlowAmount,
      this.fPNAmount,
      this.fPNCategory,
      this.fPNNumber,
      this.fPNSubCategory,
      this.feedbackText,
      this.finConAnalystRemark,
      this.nonCashFlowAmount,
      this.projectDescription,
      this.projectName,
      this.receiverEmpCode,
      this.userLevel});

  FPNData.fromJson(Map<String, dynamic> json) {
    cashFlowAmount = json['CashFlowAmount'];
    fPNAmount = json['FPNAmount'];
    fPNCategory = json['FPNCategory'];
    fPNNumber = json['FPNNumber'];
    fPNSubCategory = json['FPNSubCategory'];
    feedbackText = json['FeedbackText'];
    finConAnalystRemark = json['FinConAnalystRemark'];
    nonCashFlowAmount = json['NonCashFlowAmount'];
    projectDescription = json['ProjectDescription'];
    projectName = json['ProjectName'];
    receiverEmpCode = json['ReceiverEmpCode'];
    userLevel = json['UserLevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CashFlowAmount'] = cashFlowAmount;
    data['FPNAmount'] = fPNAmount;
    data['FPNCategory'] = fPNCategory;
    data['FPNNumber'] = fPNNumber;
    data['FPNSubCategory'] = fPNSubCategory;
    data['FeedbackText'] = feedbackText;
    data['FinConAnalystRemark'] = finConAnalystRemark;
    data['NonCashFlowAmount'] = nonCashFlowAmount;
    data['ProjectDescription'] = projectDescription;
    data['ProjectName'] = projectName;
    data['ReceiverEmpCode'] = receiverEmpCode;
    data['UserLevel'] = userLevel;
    return data;
  }
}
