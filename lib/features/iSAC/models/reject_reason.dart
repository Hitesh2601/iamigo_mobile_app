class RejectReason {
  String? responseMessage;
  List<ReturnReasonData>? returnReasonData;
  int? returnStatus;

  RejectReason(
      {this.responseMessage, this.returnReasonData, this.returnStatus});

  RejectReason.fromJson(Map<String, dynamic> json) {
    responseMessage = json['ResponseMessage'];
    if (json['ReturnReasonData'] != null) {
      returnReasonData = <ReturnReasonData>[];
      json['ReturnReasonData'].forEach((v) {
        returnReasonData!.add(ReturnReasonData.fromJson(v));
      });
    }
    returnStatus = json['ReturnStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ResponseMessage'] = responseMessage;
    if (returnReasonData != null) {
      data['ReturnReasonData'] =
          returnReasonData!.map((v) => v.toJson()).toList();
    }
    data['ReturnStatus'] = returnStatus;
    return data;
  }
}

class ReturnReasonData {
  String? androidSource;
  String? categoryDesc;
  int? categoryId;
  String? iOSSource;
  String? isEnable;
  String? reasonDesc;
  String? wINSource;
  bool? bAuthorised;
  String? cAuthStatus;
  String? cMakerId;
  String? cRejectRemarks;
  int? cid;
  String? dMakerDate;

  ReturnReasonData(
      {this.androidSource,
      this.categoryDesc,
      this.categoryId,
      this.iOSSource,
      this.isEnable,
      this.reasonDesc,
      this.wINSource,
      this.bAuthorised,
      this.cAuthStatus,
      this.cMakerId,
      this.cRejectRemarks,
      this.cid,
      this.dMakerDate});

  ReturnReasonData.fromJson(Map<String, dynamic> json) {
    androidSource = json['AndroidSource'];
    categoryDesc = json['CategoryDesc'];
    categoryId = json['CategoryId'];
    iOSSource = json['IOSSource'];
    isEnable = json['IsEnable'];
    reasonDesc = json['Reason_Desc'];
    wINSource = json['WINSource'];
    bAuthorised = json['bAuthorised'];
    cAuthStatus = json['cAuthStatus'];
    cMakerId = json['cMakerId'];
    cRejectRemarks = json['cRejectRemarks'];
    cid = json['cid'];
    dMakerDate = json['dMakerDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AndroidSource'] = androidSource;
    data['CategoryDesc'] = categoryDesc;
    data['CategoryId'] = categoryId;
    data['IOSSource'] = iOSSource;
    data['IsEnable'] = isEnable;
    data['Reason_Desc'] = reasonDesc;
    data['WINSource'] = wINSource;
    data['bAuthorised'] = bAuthorised;
    data['cAuthStatus'] = cAuthStatus;
    data['cMakerId'] = cMakerId;
    data['cRejectRemarks'] = cRejectRemarks;
    data['cid'] = cid;
    data['dMakerDate'] = dMakerDate;
    return data;
  }
}
