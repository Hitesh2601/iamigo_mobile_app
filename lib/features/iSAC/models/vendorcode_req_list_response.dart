// ignore_for_file: camel_case_types, unnecessary_new, prefer_collection_literals, non_constant_identifier_names

class iSACVendorCodeRequestListClass {
  String? responseMessage;
  int? returnStatus;
  List<RejectReasonList>? reasonlist;
  List<RequestListDataVC>? data;

  iSACVendorCodeRequestListClass(
      {this.responseMessage, this.returnStatus, this.data});

  iSACVendorCodeRequestListClass.fromJson(Map<String, dynamic> json) {
    responseMessage = json['ResponseMessage'];
    returnStatus = json['ReturnStatus'];
    if (json['ReturnListData'] != null) {
      data = <RequestListDataVC>[];
      json['ReturnListData'].forEach((v) {
        data!.add(RequestListDataVC.fromJson(v));
      });
    }
    if (json['RejectReasonList'] != null) {
      reasonlist = <RejectReasonList>[];
      json['RejectReasonList'].forEach((v) {
        reasonlist!.add(new RejectReasonList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ResponseMessage'] = responseMessage;
    data['ReturnStatus'] = returnStatus;
    if (this.data != null) {
      data['ReturnListData'] = this.data!.map((v) => v.toJson()).toList();
      data['RejectReasonList'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RejectReasonList {
  String? reason_Desc;
  int? cid;

  RejectReasonList(this.cid, this.reason_Desc);

  RejectReasonList.fromJson(Map<String, dynamic> json) {
    cid = json['Cid'];
    reason_Desc = json['Reason_Desc'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Cid'] = cid;
    data['Reason_Desc'] = reason_Desc;
    return data;
  }
}

class RequestListDataVC {
  String? companyName;
  String? eNCCid;
  String? requestFor;
  String? requestType;
  String? requestor;
  String? ticketNumber;

  RequestListDataVC(
      {this.companyName,
      this.eNCCid,
      this.requestFor,
      this.requestType,
      this.requestor,
      this.ticketNumber});

  RequestListDataVC.fromJson(Map<String, dynamic> json) {
    companyName = json['CompanyName'];
    eNCCid = json['ENC_Cid'];
    requestFor = json['RequestFor'];
    requestType = json['RequestType'];
    requestor = json['Requestor'];
    ticketNumber = json['TicketNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyName'] = companyName;
    data['ENC_Cid'] = eNCCid;
    data['RequestFor'] = requestFor;
    data['RequestType'] = requestType;
    data['Requestor'] = requestor;
    data['TicketNumber'] = ticketNumber;
    return data;
  }
}
