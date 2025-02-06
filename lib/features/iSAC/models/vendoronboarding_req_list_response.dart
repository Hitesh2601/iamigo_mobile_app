class ISACVendorOnboardingRequestListClass {
  String? responseMessage;
  int? returnStatus;
  List<RequestListDataVO>? returnListData;
  List<RejectReasonListData>? rejectreasonListData;

  ISACVendorOnboardingRequestListClass(
      {this.responseMessage, this.returnStatus, this.returnListData});

  ISACVendorOnboardingRequestListClass.fromJson(Map<String, dynamic> json) {
    responseMessage = json['ResponseMessage'];
    returnStatus = json['ReturnStatus'];
    if (json['ReturnListData'] != null) {
      returnListData = <RequestListDataVO>[];
      json['ReturnListData'].forEach((v) {
        returnListData!.add(RequestListDataVO.fromJson(v));
      });
    }
    if (json['RejectReasonList'] != null) {
      rejectreasonListData = <RejectReasonListData>[];
      json['RejectReasonList'].forEach((v) {
        rejectreasonListData!.add(RejectReasonListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['ResponseMessage'] = responseMessage;
    data['ReturnStatus'] = returnStatus;
    if (returnListData != null) {
      data['ReturnListData'] = returnListData!.map((v) => v.toJson()).toList();
      data['RejectReasonList'] =
          returnListData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RequestListDataVO {
  String? ticketNumber;
  String? companyName;
  String? eNCCid;
  String? lineMgrCode;
  String? requestorName;
  String? staffName;

  RequestListDataVO({
    this.ticketNumber,
    this.companyName,
    this.eNCCid,
    this.lineMgrCode,
    this.requestorName,
    this.staffName,
  });

  RequestListDataVO.fromJson(Map<String, dynamic> json) {
    ticketNumber = json['TicketNumber'];
    companyName = json['CompanyName'];
    eNCCid = json['ENC_Cid'];
    lineMgrCode = json['Line_Mgr_Code'];
    requestorName = json['RequestorName'];
    staffName = json['Staff_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TicketNumber'] = ticketNumber;
    data['CompanyName'] = companyName;
    data['ENC_Cid'] = eNCCid;
    data['Line_Mgr_Code'] = lineMgrCode;
    data['RequestorName'] = requestorName;
    data['Staff_Name'] = staffName;

    return data;
  }
}

class RejectReasonListData {
  String? reasonDesc;
  int? cid;

  RejectReasonListData({
    this.reasonDesc,
    this.cid,
  });

  RejectReasonListData.fromJson(Map<String, dynamic> json) {
    reasonDesc = json['Reason_Desc'];
    cid = json['cid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Reason_Desc'] = reasonDesc;
    data['cid'] = cid;

    return data;
  }
}
