class ISACRequestListResponse {
  String? responseMessage;
  int? returnStatus;
  List<ISACData>? returnListData;

  ISACRequestListResponse(
      {this.responseMessage, this.returnStatus, this.returnListData});

  ISACRequestListResponse.fromJson(Map<String, dynamic> json) {
    responseMessage = json['ResponseMessage'];
    returnStatus = json['ReturnStatus'];
    if (json['ReturnListData'] != null) {
      returnListData = <ISACData>[];
      json['ReturnListData'].forEach((v) {
        returnListData!.add(ISACData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> listData = <String, dynamic>{};
    listData['ResponseMessage'] = responseMessage;
    listData['ReturnStatus'] = returnStatus;
    if (returnListData != null) {
      listData['ReturnListData'] =
          returnListData!.map((v) => v.toJson()).toList();
    }
    return listData;
  }
}

class ISACData {
  int? requestID;
  String? ticketNumber;
  String? templateName;
  String? applicationName;
  String? requestEntryDate;
  int? requestStatusID;
  String? typeOfRequest;
  int? requestTicketTypeID;
  String? empCode;
  String? branchCode;
  String? encRequestID;
  String? encRequestTicketTypeID;
  String? encFormID;
  int? isforApproval;
  String? reasonDesc;
  String? ticketStatus;
  String? modifiedDate;
  String? searchTxt;
  String? commandParam;
  String? empName;
  String? environment;
  String? environmentColor;
  bool? isAuth;

  ISACData(
      {this.requestID,
      this.ticketNumber,
      this.templateName,
      this.applicationName,
      this.requestEntryDate,
      this.requestStatusID,
      this.typeOfRequest,
      this.requestTicketTypeID,
      this.empCode,
      this.branchCode,
      this.encRequestID,
      this.encRequestTicketTypeID,
      this.encFormID,
      this.isforApproval,
      this.reasonDesc,
      this.ticketStatus,
      this.modifiedDate,
      this.commandParam,
      this.empName,
      this.environment,
      this.environmentColor,
      this.searchTxt,
      this.isAuth});

  ISACData.fromJson(Map<String, dynamic> json) {
    requestID = json['RequestID'];
    ticketNumber = json['TicketNumber'];
    templateName = json['TemplateName'];
    applicationName = json['ApplicationName'];
    requestEntryDate = json['RequestEntryDate'];
    requestStatusID = json['RequestStatusID'];
    typeOfRequest = json['TypeOfRequest'];
    requestTicketTypeID = json['RequestTicketTypeID'];
    empCode = json['EmpCode'];
    branchCode = json['Branch_Code'];
    encRequestID = json['ENC_RequestID'];
    encRequestTicketTypeID = json['ENC_RequestTicketTypeID'];
    encFormID = json['ENC_FormID'];
    isforApproval = json['IsForApproval'];
    reasonDesc = json['ReasonDesc'];
    ticketStatus = json['TicketStatus'];
    modifiedDate = json['ModifiedDate'];
    empName = json['Emp_Name'];
    environment = json['Environment'];
    environmentColor = json['EnvironmentColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['RequestID'] = requestID;
    data['TicketNumber'] = ticketNumber;
    data['TemplateName'] = templateName;
    data['ApplicationName'] = applicationName;
    data['RequestEntryDate'] = requestEntryDate;
    data['RequestStatusID'] = requestStatusID;
    data['TypeOfRequest'] = typeOfRequest;
    data['RequestTicketTypeID'] = requestTicketTypeID;
    data['EmpCode'] = empCode;
    data['Branch_Code'] = branchCode;
    data['ENC_RequestID'] = encRequestID;
    data['ENC_RequestTicketTypeID'] = encRequestTicketTypeID;
    data['ENC_FormID'] = encFormID;
    data['IsForApproval'] = isforApproval;
    data['ReasonDesc'] = reasonDesc;
    data['TicketStatus'] = ticketStatus;
    data['ModifiedDate'] = modifiedDate;
    data['Emp_Name'] = empName;
    data['Environment'] = environment;
    data['EnvironmentColor'] = environmentColor;
    return data;
  }
}
