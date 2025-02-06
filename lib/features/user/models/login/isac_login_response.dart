import 'dart:convert';

ISACLoginResponse? isacLoginClassFromJson(String str) =>
    ISACLoginResponse.fromJson(json.decode(str));

String isacLoginClassToJson(ISACLoginResponse? data) =>
    json.encode(data!.toJson());

class ISACLoginResponse {
  String? responseMessage;
  int? returnStatus;
  ISACLogindata? isacLoginData;
  int? isImeiExists;

  ISACLoginResponse({
    this.responseMessage,
    this.returnStatus,
    this.isacLoginData,
    this.isImeiExists,
  });

  factory ISACLoginResponse.fromJson(Map<String, dynamic> json) =>
      ISACLoginResponse(
        responseMessage: json["ResponseMessage"],
        returnStatus: json["ReturnStatus"],
        isacLoginData: ISACLogindata.fromJson(json["LoginData"]),
        isImeiExists: json["isIMEIExists"],
      );

  Map<String, dynamic> toJson() => {
        "ResponseMessage": responseMessage,
        "ReturnStatus": returnStatus,
        "LoginData": isacLoginData!.toJson(),
        "isIMEIExists": isImeiExists,
      };
}

class ISACLogindata {
  ISACLogindata({
    this.userId,
    this.psd,
    this.identityStoreID,
    this.empCode,
    this.empName,
    this.costCode,
    this.costCodeId,
    this.costName,
    this.branchId,
    this.branchName,
    this.emailId,
    this.companyTypeName,
    this.companyTypeId,
    this.companyName,
    this.companyId,
    this.supervisorEmpcode,
    this.empActiveDirectoryId,
    this.isRequestWorkFlow,
    this.isModifyRequest,
    this.isNewRequestCreation,
    this.costCodeList,
    this.costCodeIdList,
    this.costCodeNameList,
    this.token,
    this.iPAddress,
    this.ownerEmail,
    this.emailFrom,
    this.emailTo,
    this.emailSubject,
    this.emailBody,
    this.sessionTimeOut,
    this.approverID,
    this.requestID,
    this.formID,
    this.welcomeLable,
    this.welcomeText,
    this.eNCApproverID,
    this.loggedOn,
    this.loggedOnDate,
    this.pendingCountData,
    this.branchCode,
  });

  String? branchCode;
  String? userId;
  String? psd;
  int? identityStoreID;
  String? empCode;
  String? empName;
  String? costCode;
  int? costCodeId;
  String? costName;
  int? branchId;
  String? branchName;
  String? emailId;
  String? companyTypeName;
  int? companyTypeId;
  String? companyName;
  int? companyId;
  String? supervisorEmpcode;
  String? empActiveDirectoryId;
  bool? isRequestWorkFlow;
  bool? isModifyRequest;
  bool? isNewRequestCreation;
  String? costCodeList;
  String? costCodeIdList;
  String? costCodeNameList;
  String? token;
  String? iPAddress;
  String? ownerEmail;
  String? emailFrom;
  String? emailTo;
  String? emailSubject;
  String? emailBody;
  int? sessionTimeOut;
  int? approverID;
  int? requestID;
  int? formID;
  String? welcomeLable;
  String? welcomeText;
  String? eNCApproverID;
  String? loggedOn;
  String? loggedOnDate;
  int? pendingCountData;

  factory ISACLogindata.fromJson(Map<String, dynamic> json) => ISACLogindata(
        approverID: json["ApproverID"],
        branchCode: json["Branchcode"],
        userId: json["UserId"],
        psd: json["Password"],
        identityStoreID: json["IdentityStoreID"],
        empCode: json["EmpCode"],
        empName: json["EmpName"],
        costCode: json["CostCode"],
        costCodeId: json["CostCodeId"],
        costName: json["CostName"],
        branchId: json["BranchId"],
        branchName: json["BranchName"],
        emailId: json["EmailId"],
        companyTypeName: json["CompanyTypeName"],
        companyTypeId: json["CompanyTypeId"],
        companyName: json["CompanyName"],
        companyId: json["CompanyId"],
        supervisorEmpcode: json["SupervisorEmpcode"],
        empActiveDirectoryId: json["EmpActiveDirectoryId"],
        isRequestWorkFlow: json["IsRequestWorkFlow"],
        isModifyRequest: json["IsModifyRequest"],
        isNewRequestCreation: json["IsNewRequestCreation"],
        costCodeList: json["CostCodeList"],
        costCodeIdList: json["CostCodeIdList"],
        costCodeNameList: json["CostCodeNameList"],
        token: json["Token"],
        iPAddress: json["IPAddress"],
        ownerEmail: json["OwnerEmail"],
        emailFrom: json["EmailFrom"],
        emailTo: json["EmailTo"],
        emailSubject: json["EmailSubject"],
        emailBody: json["EmailBody"],
        sessionTimeOut: json["SessionTimeOut"],
        requestID: json["RequestID"],
        formID: json["FormID"],
        welcomeLable: json["WelcomeLable"],
        welcomeText: json["WelcomeText"],
        eNCApproverID: json["ENCApproverID"],
        loggedOn: json["LoggedOn"],
        loggedOnDate: json["LoggedOnDate"],
        pendingCountData: json["PendingCountData"],
      );

  Map<String, dynamic> toJson() => {
        "UserId": userId,
        "Password": psd,
        "IdentityStoreID": identityStoreID,
        "EmpCode": empCode,
        "EmpName": empName,
        "CostCode": costCode,
        "CostCodeId": costCodeId,
        "CostName": costName,
        "BranchId": branchId,
        "BranchName": branchName,
        "EmailId": emailId,
        "CompanyTypeName": companyTypeName,
        "CompanyTypeId": companyTypeId,
        "CompanyName": companyName,
        "CompanyId": companyId,
        "SupervisorEmpcode": supervisorEmpcode,
        "EmpActiveDirectoryId": empActiveDirectoryId,
        "IsRequestWorkFlow": isRequestWorkFlow,
        "IsModifyRequest": isModifyRequest,
        "IsNewRequestCreation": isNewRequestCreation,
        "CostCodeList": costCodeList,
        "CostCodeIdList": costCodeIdList,
        "CostCodeNameList": costCodeNameList,
        "Token": token,
        "IPAddress": iPAddress,
        "OwnerEmail": ownerEmail,
        "EmailFrom": emailFrom,
        "EmailTo": emailTo,
        "EmailSubject": emailSubject,
        "EmailBody": emailBody,
        "SessionTimeOut": sessionTimeOut,
        "ApproverID": approverID,
        "RequestID": requestID,
        "FormID": formID,
        "WelcomeLable": welcomeLable,
        "WelcomeText": welcomeText,
        "ENCApproverID": eNCApproverID,
        "LoggedOn": loggedOn,
        "LoggedOnDate": loggedOnDate,
        "PendingCountData": pendingCountData,
        "BranchCode": branchCode,
      };
}
