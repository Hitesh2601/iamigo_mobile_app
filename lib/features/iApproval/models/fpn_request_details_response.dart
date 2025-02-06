// ignore_for_file: constant_identifier_names

import 'dart:convert';

FPNDetailResponse fpnRequestDetailsResponseFromJson(String str) =>
    FPNDetailResponse.fromJson(json.decode(str));

String fpnRequestDetailsResponseToJson(FPNDetailResponse data) =>
    json.encode(data.toJson());

class FPNDetailResponse {
  FPNDetailResponse({
    required this.responseMessage,
    required this.returnStatus,
    required this.fpnNo,
    required this.requestDetails,
  });

  String responseMessage;
  int returnStatus;
  String? fpnNo;
  RequestDetails? requestDetails;

  factory FPNDetailResponse.fromJson(Map<String, dynamic> json) =>
      FPNDetailResponse(
        responseMessage: json["ResponseMessage"],
        returnStatus: json["ReturnStatus"],
        fpnNo: json["FpnNo"],
        requestDetails: json["RequestDetails"] != null
            ? RequestDetails.fromJson(json["RequestDetails"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "ResponseMessage": responseMessage,
        "ReturnStatus": returnStatus,
        "FpnNo": fpnNo,
        "RequestDetails": requestDetails?.toJson(),
      };
}

class RequestDetails {
  RequestDetails({
    required this.isFincon,
    required this.applicationDetails,
    required this.auditTrail,
    required this.benefitDetails,
    required this.benefitDetailsNew,
    required this.budgetDetailsData,
    required this.caseApprovalMatrix,
    required this.caseApprovalMatrixNew,
    required this.caseDetails,
    required this.costCenterDetails,
    this.feedback,
    required this.processAttachmentDetails,
    required this.projectDetails,
    required this.finconDropdownData,
    required this.userId,
    required this.fYIFPNDetails,
    required this.sendbackDetails,
  });

  bool isFincon;
  ApplicationDetails applicationDetails;
  List<AuditTrail> auditTrail;
  List<BenefitDetail>? benefitDetails;
  BenefitDetailsNew? benefitDetailsNew;
  BudgetDetailsData budgetDetailsData;
  CaseApprovalMatrix? caseApprovalMatrix;
  CaseApprovalMatrixNew? caseApprovalMatrixNew;
  CaseDetails? caseDetails;
  List<CostCenterDetail> costCenterDetails;
  List<FeedbackResponse>? feedback;
  ProcessAttachmentDetails processAttachmentDetails;
  ProjectDetails projectDetails;
  FinconDropdownData finconDropdownData;
  List<FYIFPNDetails>? fYIFPNDetails;
  SendbackDetails? sendbackDetails;

  String? userId;

  factory RequestDetails.fromJson(Map<String, dynamic> json) => RequestDetails(
      isFincon: json["IsFincon"],
      applicationDetails:
          ApplicationDetails.fromJson(json["ApplicationDetails"]),
      auditTrail: List<AuditTrail>.from(
          json["AuditTrail"].map((x) => AuditTrail.fromJson(x))),
      benefitDetails: json["BenefitDetails"] != null
          ? List<BenefitDetail>.from(
              json["BenefitDetails"].map((x) => BenefitDetail.fromJson(x)))
          : null,
      fYIFPNDetails: json["FYIFPNDetails"] != null
          ? List<FYIFPNDetails>.from(
              json["FYIFPNDetails"].map((x) => FYIFPNDetails.fromJson(x)))
          : null,
      benefitDetailsNew: json['BenefitDetails_New'] != null
          ? BenefitDetailsNew.fromJson(json['BenefitDetails_New'])
          : null,
      budgetDetailsData: BudgetDetailsData.fromJson(json["BudgetDetailsData"]),
      caseApprovalMatrix: json["CaseApprovalMatrix"] != null
          ? CaseApprovalMatrix.fromJson(json["CaseApprovalMatrix"])
          : null,
      caseApprovalMatrixNew: json["CaseApprovalMatrixNew"] != null
          ? CaseApprovalMatrixNew.fromJson(json["CaseApprovalMatrixNew"])
          : null,
      caseDetails: json["CaseDetails"] != null
          ? CaseDetails.fromJson(json["CaseDetails"])
          : null,
      costCenterDetails: List<CostCenterDetail>.from(
          json["CostCenterDetails"].map((x) => CostCenterDetail.fromJson(x))),
      feedback: json['Feedback'] != null
          ? List<FeedbackResponse>.from(json["Feedback"].map((x) => FeedbackResponse.fromJson(x)))
          : null,
      processAttachmentDetails: ProcessAttachmentDetails.fromJson(json["ProcessAttachmentDetails"]),
      projectDetails: ProjectDetails.fromJson(json["ProjectDetails"]),
      finconDropdownData: FinconDropdownData.fromJson(json["FinconDropdownData"]),
      userId: json["UserId"],
      sendbackDetails: json['SendbackDetails'] != null ? SendbackDetails.fromJson(json['SendbackDetails']) : null);

  Map<String, dynamic> toJson() => {
        "IsFincon": isFincon,
        "ApplicationDetails": applicationDetails.toJson(),
        "AuditTrail": List<dynamic>.from(auditTrail.map((x) => x.toJson())),
        "BenefitDetails":
            List<dynamic>.from(benefitDetails!.map((x) => x.toJson())),
        "FYIFPNDetails":
            List<dynamic>.from(fYIFPNDetails!.map((x) => x.toJson())),
        "BenefitDetails_New": benefitDetailsNew?.toJson(),
        "BudgetDetailsData": budgetDetailsData.toJson(),
        "CaseApprovalMatrix": caseApprovalMatrix?.toJson(),
        "CaseApprovalMatrixNew": caseApprovalMatrixNew?.toJson(),
        "CaseDetails": caseDetails?.toJson(),
        "CostCenterDetails":
            List<dynamic>.from(costCenterDetails.map((x) => x.toJson())),
        "Feedback": feedback,
        "ProcessAttachmentDetails": processAttachmentDetails.toJson(),
        "ProjectDetails": projectDetails.toJson(),
        "FinconDropdownData": finconDropdownData.toJson(),
        "SendbackDetails": sendbackDetails!.toJson(),
        "UserId": userId,
      };
}

class SendbackDetails {
  String? finconSendbackAmt;
  String? originalFPNAmt;
  String? userSendbackAmt;
  bool? allowsendback; 

  SendbackDetails(
      {this.finconSendbackAmt, this.originalFPNAmt, this.userSendbackAmt, this.allowsendback});

  SendbackDetails.fromJson(Map<String, dynamic> json) {
    finconSendbackAmt = json['FinconSendbackAmt'];
    originalFPNAmt = json['OriginalFPNAmt'];
    userSendbackAmt = json['UserSendbackAmt'];
    allowsendback = json['Allowsendback'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['FinconSendbackAmt'] = finconSendbackAmt;
    data['OriginalFPNAmt'] = originalFPNAmt;
    data['UserSendbackAmt'] = userSendbackAmt;
    data['Allowsendback'] = allowsendback;
    return data;
  }
}

class ApplicationDetails {
  ApplicationDetails({
    required this.detailList,
    required this.totalAmount,
  });

  List<DetailList> detailList;
  String totalAmount;

  factory ApplicationDetails.fromJson(Map<String, dynamic> json) =>
      ApplicationDetails(
        detailList: List<DetailList>.from(
            json["DetailList"].map((x) => DetailList.fromJson(x))),
        totalAmount: json["TotalAmount"],
      );

  Map<String, dynamic> toJson() => {
        "DetailList": List<dynamic>.from(detailList.map((x) => x.toJson())),
        "TotalAmount": totalAmount,
      };
}

class FYIFPNDetails {
  String? empCode;
  String? empEmail;
  String? empName;
  String? isMailSent;

  FYIFPNDetails({this.empCode, this.empEmail, this.empName, this.isMailSent});

  FYIFPNDetails.fromJson(Map<String, dynamic> json) {
    empCode = json['EmpCode'];
    empEmail = json['EmpEmail'];
    empName = json['EmpName'];
    isMailSent = json['IsMailSent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['EmpCode'] = empCode;
    data['EmpEmail'] = empEmail;
    data['EmpName'] = empName;
    data['IsMailSent'] = isMailSent;
    return data;
  }
}

class DetailList {
  DetailList({
    required this.amount,
    required this.appName,
    required this.appOwnerEmpCode,
    required this.appOwnerName,
    required this.businessFhEmpCode,
    required this.businessFhName,
    required this.count,
    required this.executionOwnerEmpCode,
    required this.executionOwnerName,
    required this.projectManager,
    required this.vendorName,
  });

  String amount;
  String? appName;
  String? appOwnerEmpCode;
  String? appOwnerName;
  String? businessFhEmpCode;
  String? businessFhName;
  String? count;
  String? executionOwnerEmpCode;
  String? executionOwnerName;
  String? projectManager;
  String? vendorName;

  factory DetailList.fromJson(Map<String, dynamic> json) => DetailList(
        amount: json["Amount"],
        appName: json["AppName"],
        appOwnerEmpCode: json["AppOwnerEmpCode"],
        appOwnerName: json["AppOwnerName"],
        businessFhEmpCode: json["BusinessFHEmpCode"],
        businessFhName: json["BusinessFHName"],
        count: json["Count"],
        executionOwnerEmpCode: json["ExecutionOwnerEmpCode"],
        executionOwnerName: json["ExecutionOwnerName"],
        projectManager: json["ProjectManager"],
        vendorName: json["VendorName"],
      );

  Map<String, dynamic> toJson() => {
        "Amount": amount,
        "AppName": appName,
        "AppOwnerEmpCode": appOwnerEmpCode,
        "AppOwnerName": appOwnerName,
        "BusinessFHEmpCode": businessFhEmpCode,
        "BusinessFHName": businessFhName,
        "Count": count,
        "ExecutionOwnerEmpCode": executionOwnerEmpCode,
        "ExecutionOwnerName": executionOwnerName,
        "ProjectManager": projectManager,
        "VendorName": vendorName,
      };
}

class AuditTrail {
  AuditTrail({
    required this.actionDateTime,
    required this.actorCode,
    required this.actorName,
    required this.auditRemark,
    required this.status,
    required this.statusColor,
  });

  String? actionDateTime;
  String? actorCode;
  String? actorName;
  String? auditRemark;
  String? status;
  StatusColor statusColor;

  factory AuditTrail.fromJson(Map<String?, dynamic> json) => AuditTrail(
        actionDateTime: json["ActionDateTime"],
        actorCode: json["ActorCode"],
        actorName: json["ActorName"],
        auditRemark: json["AuditRemark"],
        status: json["Status"],
        statusColor: StatusColor.fromJson(json["StatusColor"]),
      );

  Map<String, dynamic> toJson() => {
        "ActionDateTime": actionDateTime,
        "ActorCode": actorCode,
        "ActorName": actorName,
        "AuditRemark": auditRemark,
        "Status": status,
        "StatusColor": statusColor.toJson(),
      };
}

class StatusColor {
  StatusColor({
    required this.knownColor,
    this.name,
    required this.state,
    required this.value,
  });

  int knownColor;
  dynamic name;
  int state;
  int value;

  factory StatusColor.fromJson(Map<String, dynamic> json) => StatusColor(
        knownColor: json["knownColor"],
        name: json["name"],
        state: json["state"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "knownColor": knownColor,
        "name": name,
        "state": state,
        "value": value,
      };
}

class FeedbackResponse {
  String? feedbackFromDateTime;
  String? feedbackToDateTime;
  String? queryDetail;
  String? queryFromEmpCode;
  String? queryFromName;
  String? queryToEmpCode;
  String? queryToName;
  String? replyDetail;
  String? replyFromEmpCode;
  String? replyFromName;
  bool? replyRequired;
  String? replyToEmpCode;
  String? replyToName;
  String? status;

  FeedbackResponse(
      {this.feedbackFromDateTime,
      this.feedbackToDateTime,
      this.queryDetail,
      this.queryFromEmpCode,
      this.queryFromName,
      this.queryToEmpCode,
      this.queryToName,
      this.replyDetail,
      this.replyFromEmpCode,
      this.replyFromName,
      this.replyRequired,
      this.replyToEmpCode,
      this.replyToName,
      this.status});

  FeedbackResponse.fromJson(Map<String, dynamic> json) {
    feedbackFromDateTime = json['FeedbackFromDateTime'];
    feedbackToDateTime = json['FeedbackToDateTime'];
    queryDetail = json['QueryDetail'];
    queryFromEmpCode = json['QueryFromEmpCode'];
    queryFromName = json['QueryFromName'];
    queryToEmpCode = json['QueryToEmpCode'];
    queryToName = json['QueryToName'];
    replyDetail = json['ReplyDetail'];
    replyFromEmpCode = json['ReplyFromEmpCode'];
    replyFromName = json['ReplyFromName'];
    replyRequired = json['ReplyRequired'];
    replyToEmpCode = json['ReplyToEmpCode'];
    replyToName = json['ReplyToName'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['FeedbackFromDateTime'] = feedbackFromDateTime;
    data['FeedbackToDateTime'] = feedbackToDateTime;
    data['QueryDetail'] = queryDetail;
    data['QueryFromEmpCode'] = queryFromEmpCode;
    data['QueryFromName'] = queryFromName;
    data['QueryToEmpCode'] = queryToEmpCode;
    data['QueryToName'] = queryToName;
    data['ReplyDetail'] = replyDetail;
    data['ReplyFromEmpCode'] = replyFromEmpCode;
    data['ReplyFromName'] = replyFromName;
    data['ReplyRequired'] = replyRequired;
    data['ReplyToEmpCode'] = replyToEmpCode;
    data['ReplyToName'] = replyToName;
    data['Status'] = status;
    return data;
  }
}

class BenefitDetail {
  BenefitDetail({
    required this.basis,
    required this.targetDate,
    required this.type,
    required this.value,
  });

  String? basis;
  String? targetDate;
  String? type;
  String? value;

  factory BenefitDetail.fromJson(Map<String, dynamic> json) => BenefitDetail(
        basis: json["Basis"],
        targetDate: json["TargetDate"],
        type: json["Type"],
        value: json["Value"],
      );

  Map<String, dynamic> toJson() => {
        "Basis": basis,
        "TargetDate": targetDate,
        "Type": type,
        "Value": value,
      };
}

class BenefitDetailsNew {
  List<IncrementalVolEffortList>? incrementalVolEffortList;
  List<ReducedEffortList>? reducedEffortList;

  BenefitDetailsNew({this.incrementalVolEffortList, this.reducedEffortList});

  BenefitDetailsNew.fromJson(Map<String, dynamic> json) {
    if (json['IncrementalVolEffortList'] != null) {
      incrementalVolEffortList = <IncrementalVolEffortList>[];
      json['IncrementalVolEffortList'].forEach((v) {
        incrementalVolEffortList!.add(IncrementalVolEffortList.fromJson(v));
      });
    }
    if (json['ReducedEffortList'] != null) {
      reducedEffortList = <ReducedEffortList>[];
      json['ReducedEffortList'].forEach((v) {
        reducedEffortList!.add(ReducedEffortList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (incrementalVolEffortList != null) {
      data['IncrementalVolEffortList'] =
          incrementalVolEffortList!.map((v) => v.toJson()).toList();
    }
    if (reducedEffortList != null) {
      data['ReducedEffortList'] =
          reducedEffortList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class IncrementalVolEffortList {
  String? avgTicketSizeExisting;
  String? avgTicketSizeExpected;
  String? incAnualAvgBalanceExpected;
  String? incRevenuePAExpected;
  String? productName;
  String? toBeTrackFrom;
  String? unitPerMonthExisting;
  String? unitPerMonthExpected;

  IncrementalVolEffortList(
      {this.avgTicketSizeExisting,
      this.avgTicketSizeExpected,
      this.incAnualAvgBalanceExpected,
      this.incRevenuePAExpected,
      this.productName,
      this.toBeTrackFrom,
      this.unitPerMonthExisting,
      this.unitPerMonthExpected});

  IncrementalVolEffortList.fromJson(Map<String, dynamic> json) {
    avgTicketSizeExisting = json['AvgTicketSize_Existing'];
    avgTicketSizeExpected = json['AvgTicketSize_Expected'];
    incAnualAvgBalanceExpected = json['IncAnualAvgBalance_Expected'];
    incRevenuePAExpected = json['IncRevenuePA_Expected'];
    productName = json['ProductName'];
    toBeTrackFrom = json['ToBeTrackFrom'];
    unitPerMonthExisting = json['UnitPerMonth_Existing'];
    unitPerMonthExpected = json['UnitPerMonth_Expected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['AvgTicketSize_Existing'] = avgTicketSizeExisting;
    data['AvgTicketSize_Expected'] = avgTicketSizeExpected;
    data['IncAnualAvgBalance_Expected'] = incAnualAvgBalanceExpected;
    data['IncRevenuePA_Expected'] = incRevenuePAExpected;
    data['ProductName'] = productName;
    data['ToBeTrackFrom'] = toBeTrackFrom;
    data['UnitPerMonth_Existing'] = unitPerMonthExisting;
    data['UnitPerMonth_Expected'] = unitPerMonthExpected;
    return data;
  }
}

class ReducedEffortList {
  String? effectiveRelease;
  String? functionName;
  String? processingTimeExisting;
  String? processingTimeExpected;
  String? productivityPerResourceExisting;
  String? productivityPerResourceExpected;
  String? toBeTrackFrom;
  String? unitName;

  ReducedEffortList(
      {this.effectiveRelease,
      this.functionName,
      this.processingTimeExisting,
      this.processingTimeExpected,
      this.productivityPerResourceExisting,
      this.productivityPerResourceExpected,
      this.toBeTrackFrom,
      this.unitName});

  ReducedEffortList.fromJson(Map<String, dynamic> json) {
    effectiveRelease = json['EffectiveRelease'];
    functionName = json['FunctionName'];
    processingTimeExisting = json['ProcessingTime_Existing'];
    processingTimeExpected = json['ProcessingTime_Expected'];
    productivityPerResourceExisting = json['ProductivityPerResource_Existing'];
    productivityPerResourceExpected = json['ProductivityPerResource_Expected'];
    toBeTrackFrom = json['ToBeTrackFrom'];
    unitName = json['UnitName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['EffectiveRelease'] = effectiveRelease;
    data['FunctionName'] = functionName;
    data['ProcessingTime_Existing'] = processingTimeExisting;
    data['ProcessingTime_Expected'] = processingTimeExpected;
    data['ProductivityPerResource_Existing'] = productivityPerResourceExisting;
    data['ProductivityPerResource_Expected'] = productivityPerResourceExpected;
    data['ToBeTrackFrom'] = toBeTrackFrom;
    data['UnitName'] = unitName;
    return data;
  }
}

class BudgetDetailsData {
  BudgetDetailsData({
    required this.budgetDetails,
    required this.totalBudgetAmount,
  });

  List<BudgetDetail> budgetDetails;
  String totalBudgetAmount;

  factory BudgetDetailsData.fromJson(Map<String, dynamic> json) =>
      BudgetDetailsData(
        budgetDetails: List<BudgetDetail>.from(
            json["BudgetDetails"].map((x) => BudgetDetail.fromJson(x))),
        totalBudgetAmount: json["TotalBudgetAmount"],
      );

  Map<String, dynamic> toJson() => {
        "BudgetDetails":
            List<dynamic>.from(budgetDetails.map((x) => x.toJson())),
        "TotalBudgetAmount": totalBudgetAmount,
      };
}

class BudgetDetail {
  BudgetDetail({
    required this.availableAmt,
    required this.desciption,
    required this.requestedAmt,
    required this.serialNo,
    required this.type,
    required this.utilizedAmt,
    required this.value,
  });

  String? availableAmt;
  String? desciption;
  String? requestedAmt;
  String? serialNo;
  String? type;
  String? utilizedAmt;
  String? value;

  factory BudgetDetail.fromJson(Map<String, dynamic> json) => BudgetDetail(
        availableAmt: json["AvailableAmt"],
        desciption: json["Desciption"],
        requestedAmt: json["RequestedAmt"],
        serialNo: json["SerialNo"],
        type: json["Type"],
        utilizedAmt: json["UtilizedAmt"],
        value: json["Value"],
      );

  Map<String, dynamic> toJson() => {
        "AvailableAmt": availableAmt,
        "Desciption": desciption,
        "RequestedAmt": requestedAmt,
        "SerialNo": serialNo,
        "Type": type,
        "UtilizedAmt": utilizedAmt,
        "Value": value,
      };
}

class CaseApprovalMatrix {
  CaseApprovalMatrix(
      {this.analystRemark,
      required this.approved,
      required this.approverLevel1,
      this.finconAmt,
      this.finconAnalyst,
      this.finconApprover,
      this.finconApprover2,
      this.finconApprover3,
      this.finconOldAmt,
      this.mdApprover,
      required this.recommended,
      required this.reviewed,
      required this.concurred});

  String? analystRemark;

  ApproverLevel1? approverLevel1;
  String? finconAmt;
  FinconApproved? finconAnalyst;
  FinconApproved? finconApprover;
  FinconApproved? finconApprover2;
  FinconApproved? finconApprover3;
  String? finconOldAmt;
  FinconApproved? mdApprover;
  Approved? recommended;
  Approved? reviewed;
  Approved? approved;
  Approved? concurred;
  factory CaseApprovalMatrix.fromJson(Map<String, dynamic> json) =>
      CaseApprovalMatrix(
        analystRemark: json["AnalystRemark"],
        approved: json["Approved"] != null
            ? Approved.fromJson(json["Approved"])
            : null,
        approverLevel1: json["ApproverLevel1"] != null
            ? ApproverLevel1.fromJson(json["ApproverLevel1"])
            : null,
        finconAmt: json["FinconAmt"],
        finconAnalyst: json["FinconAnalyst"] != null
            ? FinconApproved.fromJson(json["FinconAnalyst"])
            : null,
        finconApprover: json["FinconApprover"] != null
            ? FinconApproved.fromJson(json["FinconApprover"])
            : null,
        finconApprover2: json["FinconApprover2"] != null
            ? FinconApproved.fromJson(json["FinconApprover2"])
            : null,
        finconApprover3: json["FinconApprover3"] != null
            ? FinconApproved.fromJson(json["FinconApprover3"])
            : null,
        finconOldAmt: json["FinconOldAmt"],
        mdApprover: json["MDApprover"] != null
            ? FinconApproved.fromJson(json["MDApprover"])
            : null,
        recommended: json["Recommended"] != null
            ? Approved.fromJson(json["Recommended"])
            : null,
        reviewed: json["Reviewed"] != null
            ? Approved.fromJson(json["Reviewed"])
            : null,
        concurred: json["Concurred"] != null
            ? Approved.fromJson(json["Concurred"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "AnalystRemark": analystRemark,
        "Approved": approved?.toJson(),
        "ApproverLevel1": approverLevel1?.toJson(),
        "FinconAmt": finconAmt,
        "FinconAnalyst": finconAnalyst,
        "FinconApprover": finconApprover,
        "FinconApprover2": finconApprover2,
        "FinconApprover3": finconApprover3,
        "FinconOldAmt": finconOldAmt,
        "MDApprover": mdApprover,
        "Recommended": recommended!.toJson(),
        "Reviewed": reviewed!.toJson(),
        "Concurred": concurred!.toJson(),
      };
}

class Approved {
  Approved({
    required this.level1,
    this.level2,
    this.level3,
    this.level4,
    this.level5,
  });

  List<Level>? level1;
  List<Level>? level2;
  List<Level>? level3;
  List<Level>? level4;
  List<Level>? level5;

  factory Approved.fromJson(Map<String, dynamic> json) => Approved(
        level1: json["Level1"] != null
            ? List<Level>.from(json["Level1"].map((x) => Level.fromJson(x)))
            : null,
        level2: json["Level2"] != null
            ? List<Level>.from(json["Level2"].map((x) => Level.fromJson(x)))
            : null,
        level3: json["Level3"] != null
            ? List<Level>.from(json["Level3"].map((x) => Level.fromJson(x)))
            : null,
        level4: json["Level4"] != null
            ? List<Level>.from(json["Level4"].map((x) => Level.fromJson(x)))
            : null,
        level5: json["Level5"] != null
            ? List<Level>.from(json["Level5"].map((x) => Level.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "Level1": List<Level>.from(level1!.map((x) => x.toJson())),
        "Level2": List<Level>.from(level2!.map((x) => x.toJson())),
        "Level3": List<Level>.from(level3!.map((x) => x.toJson())),
        "Level4": List<Level>.from(level4!.map((x) => x.toJson())),
        "Level5": List<Level>.from(level5!.map((x) => x.toJson())),
      };
}

class FinconApproved {
  FinconApproved({
    this.level1,
  });

  List<Level>? level1;

  factory FinconApproved.fromJson(Map<String, dynamic> json) => FinconApproved(
        level1: json["Level1"] != null
            ? List<Level>.from(json["Level1"].map((x) => Level.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "Level1": List<Level>.from(level1!.map((x) => x.toJson())),
      };
}

class Level {
  Level({
    required this.code,
    required this.matrixColor,
    required this.name,
    required this.status,
    this.department,
  });

  String? code;
  String? matrixColor;
  String? name;
  Status? status;
  String? department;

  factory Level.fromJson(Map<String?, dynamic> json) => Level(
        code: json["Code"],
        matrixColor: json["MatrixColor"],
        name: json["Name"],
        status:
            json["Status"] != null ? statusValues.map[json["Status"]] : null,
        department: json["Department"],
      );

  Map<String, dynamic> toJson() => {
        "Code": code,
        "MatrixColor": matrixColor,
        "Name": name,
        "Status": statusValues.reverse[status],
        "Department": department,
      };
}

enum Status { NOT_INITIATED, PENDING, APPROVED }

final statusValues = EnumValues({
  "Approved": Status.APPROVED,
  "NOT INITIATED": Status.NOT_INITIATED,
  "PENDING": Status.PENDING
});

class ApproverLevel1 {
  ApproverLevel1({
    required this.isg,
    this.fincon,
    this.level3,
    this.level4,
    this.level5,
  });

  List<Level> isg;
  dynamic fincon;
  dynamic level3;
  dynamic level4;
  dynamic level5;

  factory ApproverLevel1.fromJson(Map<String, dynamic> json) => ApproverLevel1(
        isg: List<Level>.from(json["ISG"].map((x) => Level.fromJson(x))),
        fincon: json["FINCON"],
        level3: json["Level3"],
        level4: json["Level4"],
        level5: json["Level5"],
      );

  Map<String, dynamic> toJson() => {
        "ISG": List<dynamic>.from(isg.map((x) => x.toJson())),
        "FINCON": fincon,
        "Level3": level3,
        "Level4": level4,
        "Level5": level5,
      };
}

class CaseApprovalMatrixNew {
  CaseApprovalMatrixNew({
    required this.departmentData,
  });

  List<DepartmentDatum> departmentData;

  factory CaseApprovalMatrixNew.fromJson(Map<String, dynamic> json) =>
      CaseApprovalMatrixNew(
        departmentData: List<DepartmentDatum>.from(
            json["DepartmentData"].map((x) => DepartmentDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "DepartmentData":
            List<dynamic>.from(departmentData.map((x) => x.toJson())),
      };
}

class DepartmentDatum {
  DepartmentDatum({
    required this.departmentName,
    required this.level1,
    this.level2,
    required this.level3,
    this.level4,
  });

  String? departmentName;
  Level? level1;
  Level? level2;
  Level? level3;
  Level? level4;

  factory DepartmentDatum.fromJson(Map<String, dynamic> json) =>
      DepartmentDatum(
        departmentName: json["DepartmentName"],
        level1: json["Level1"] == null ? null : Level.fromJson(json["Level1"]),
        level2: json["Level2"] == null ? null : Level.fromJson(json["Level2"]),
        level3: json["Level3"] == null ? null : Level.fromJson(json["Level3"]),
        level4: json["Level4"] == null ? null : Level.fromJson(json["Level4"]),
      );

  Map<String, dynamic> toJson() => {
        "DepartmentName": departmentName,
        "Level1": level1?.toJson(),
        "Level2": level2?.toJson(),
        "Level3": level3?.toJson(),
        "Level4": level4?.toJson(),
      };
}

class CaseDetails {
  CaseDetails({
    required this.ariba,
    required this.autionRefNo,
    required this.cabChangesApproved,
    required this.fpnDescription,
    required this.pnsiChange,
    required this.parentFpnAmount,
    required this.parentFpnAmtUtilized,
    required this.parentFpnProjectName,
    required this.parentFpnNo,
    required this.refNo,
    required this.specifyChangeInScope,
    required this.supplementaryFpn,
    required this.tentativeDate,
    required this.validJustification,
    required this.justification,
    required this.vSpecifychangeinScope,
  });

  String? ariba;
  String? autionRefNo;
  String? cabChangesApproved;
  String? fpnDescription;
  String? pnsiChange;
  String? parentFpnAmount;
  String? parentFpnAmtUtilized;
  String? parentFpnProjectName;
  String? parentFpnNo;
  String? refNo;
  String? specifyChangeInScope;
  String? supplementaryFpn;
  String? tentativeDate;
  String? validJustification;
  String? justification;
  String? vSpecifychangeinScope;

  factory CaseDetails.fromJson(Map<String, dynamic> json) => CaseDetails(
        ariba: json["Ariba"],
        autionRefNo: json["AutionRefNo"],
        cabChangesApproved: json["CabChangesApproved"],
        fpnDescription: json["FpnDescription"],
        pnsiChange: json["PNSIChange"],
        parentFpnAmount: json["ParentFpnAmount"],
        parentFpnAmtUtilized: json["ParentFpnAmtUtilized"],
        parentFpnProjectName: json["ParentFpnProjectName"],
        parentFpnNo: json["ParentFpnNo"],
        refNo: json["RefNo"],
        specifyChangeInScope: json["SpecifyChangeInScope"],
        supplementaryFpn: json["SupplementaryFpn"],
        tentativeDate: json["TentativeDate"],
        validJustification: json["ValidJustification"],
        justification: json["Justification"],
        vSpecifychangeinScope: json["vSpecifychangeinScope"],
      );

  Map<String, dynamic> toJson() => {
        "Ariba": ariba,
        "AutionRefNo": autionRefNo,
        "CabChangesApproved": cabChangesApproved,
        "FpnDescription": fpnDescription,
        "PNSIChange": pnsiChange,
        "ParentFpnAmount": parentFpnAmount,
        "ParentFpnAmtUtilized": parentFpnAmtUtilized,
        "ParentFpnProjectName": parentFpnProjectName,
        "ParentFpnNo": parentFpnNo,
        "RefNo": refNo,
        "SpecifyChangeInScope": specifyChangeInScope,
        "SupplementaryFpn": supplementaryFpn,
        "TentativeDate": tentativeDate,
        "ValidJustification": validJustification,
        "Justification": justification,
        "vSpecifychangeinScope": vSpecifychangeinScope,
      };
}

class CostCenterDetail {
  CostCenterDetail({
    required this.costCenterCode,
    required this.costCenterName,
    required this.costCenterPercentage,
  });

  String? costCenterCode;
  String? costCenterName;
  String? costCenterPercentage;

  factory CostCenterDetail.fromJson(Map<String, dynamic> json) =>
      CostCenterDetail(
        costCenterCode: json["CostCenterCode"],
        costCenterName: json["CostCenterName"],
        costCenterPercentage: json["CostCenterPercentage"],
      );

  Map<String, dynamic> toJson() => {
        "CostCenterCode": costCenterCode,
        "CostCenterName": costCenterName,
        "CostCenterPercentage": costCenterPercentage,
      };
}

class FinconDropdownData {
  FinconDropdownData({
    required this.projectRelevanceList,
    required this.fpnCategoies,
    required this.benefitTypes,
  });

  List<FpnCategoy> projectRelevanceList;
  List<FpnCategoy> fpnCategoies;
  List<BenefitType> benefitTypes;

  factory FinconDropdownData.fromJson(Map<String, dynamic> json) =>
      FinconDropdownData(
        projectRelevanceList: List<FpnCategoy>.from(
            json["ProjectRelevanceList"].map((x) => FpnCategoy.fromJson(x))),
        fpnCategoies: List<FpnCategoy>.from(
            json["FPNCategoies"].map((x) => FpnCategoy.fromJson(x))),
        benefitTypes: List<BenefitType>.from(
            json["BenefitTypes"].map((x) => BenefitType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ProjectRelevanceList":
            List<dynamic>.from(projectRelevanceList.map((x) => x.toJson())),
        "FPNCategoies": List<dynamic>.from(fpnCategoies.map((x) => x.toJson())),
        "BenefitTypes": List<dynamic>.from(benefitTypes.map((x) => x.toJson())),
      };
}

class BenefitType {
  BenefitType({
    required this.label,
    required this.value,
  });

  String? label;
  Value value;

  factory BenefitType.fromJson(Map<String, dynamic> json) => BenefitType(
        label: json["Label"],
        value: Value.fromJson(json["Value"]),
      );

  Map<String, dynamic> toJson() => {
        "Label": label,
        "Value": value.toJson(),
      };
}

class Value {
  Value({
    required this.textValue,
    required this.textValueId,
  });

  String? textValue;
  String? textValueId;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        textValue: json["TextValue"],
        textValueId: json["TextValue_Id"],
      );

  Map<String, dynamic> toJson() => {
        "TextValue": textValue,
        "TextValue_Id": textValueId,
      };
}

class FpnCategoy {
  FpnCategoy({
    required this.label,
    required this.value,
    required this.subCategories,
  });

  String? label;
  Value value;
  List<BenefitType> subCategories;

  factory FpnCategoy.fromJson(Map<String, dynamic> json) => FpnCategoy(
        label: json["Label"],
        value: Value.fromJson(json["Value"]),
        subCategories: List<BenefitType>.from(
            json["SubCategories"].map((x) => BenefitType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Label": label,
        "Value": value.toJson(),
        "SubCategories":
            List<dynamic>.from(subCategories.map((x) => x.toJson())),
      };
}

class ProcessAttachmentDetails {
  ProcessAttachmentDetails({
    required this.competition,
    required this.current,
    required this.downloadLink,
    required this.processAttachmentDetailsNew,
  });

  String? competition;
  String? current;
  String? downloadLink;
  String? processAttachmentDetailsNew;

  factory ProcessAttachmentDetails.fromJson(Map<String, dynamic> json) =>
      ProcessAttachmentDetails(
        competition: json["Competition"],
        current: json["Current"],
        downloadLink: json["DownloadLink"],
        processAttachmentDetailsNew: json["New"],
      );

  Map<String, dynamic> toJson() => {
        "Competition": competition,
        "Current": current,
        "DownloadLink": downloadLink,
        "New": processAttachmentDetailsNew,
      };
}

class NoOfPhase {
  String? days;
  String? phase;

  NoOfPhase({this.days, this.phase});

  NoOfPhase.fromJson(Map<String, dynamic> json) {
    days = json['Days'];
    phase = json['Phase'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Days'] = this.days;
    data['Phase'] = this.phase;
    return data;
  }
}

class ProjectDetails {
  ProjectDetails({
    required this.amcRemark,
    required this.cashFlow,
    required this.cashFlowWords,
    required this.conceptInitiatorDate,
    required this.conceptInitiatorEmpCode,
    required this.conceptInitiatorName,
    required this.days,
    required this.fpnAmount,
    required this.fpnAmountWords,
    required this.fpnCategory,
    required this.fpnSubCategory,
    required this.functionHeadEmpCode,
    required this.functionHeadName,
    required this.functionName,
    required this.groupHeadEmpCode,
    required this.groupHeadName,
    required this.isHardwareAmcvAlidated,
    required this.nsiProject,
    required this.nonCashFlow,
    required this.nonCashFlowWords,
    required this.noOfPhase,
    required this.ppmProjectId,
    required this.projBudgetCategory,
    required this.projectDescription,
    required this.projectId,
    required this.projectName,
    required this.vIsitaNsiProject,
    required this.vPpmProjectId,
    required this.projectRelevance,
  });

  String? amcRemark;
  String? cashFlow;
  String? cashFlowWords;
  String? conceptInitiatorEmpCode;
  String? conceptInitiatorName;
  String? days;
  String? fpnAmount;
  String? fpnAmountWords;
  String? fpnCategory;
  String? fpnSubCategory;
  String? functionHeadEmpCode;
  String? functionHeadName;
  String? functionName;
  String? groupHeadEmpCode;
  String? groupHeadName;
  String? isHardwareAmcvAlidated;
  String? nsiProject;
  String? nonCashFlow;
  String? nonCashFlowWords;

  List<NoOfPhase>? noOfPhase;
  String? ppmProjectId;
  String? projectDescription;
  String? projectId;
  String? projectName;
  String? vIsitaNsiProject;
  String? vPpmProjectId;
  String? projectRelevance;

  String? conceptInitiatorDate;
  String? projBudgetCategory;

  factory ProjectDetails.fromJson(Map<String, dynamic> json) => ProjectDetails(
        amcRemark: json["AMCRemark"],
        cashFlow: json["CashFlow"],
        cashFlowWords: json["CashFlowWords"],
        conceptInitiatorDate: json['ConceptInitiatorDate'],
        conceptInitiatorEmpCode: json["ConceptInitiatorEmpCode"],
        conceptInitiatorName: json["ConceptInitiatorName"],
        days: json["Days"],
        fpnAmount: json["FpnAmount"],
        fpnAmountWords: json["FpnAmountWords"],
        fpnCategory: json["FpnCategory"],
        fpnSubCategory: json["FpnSubCategory"],
        functionHeadEmpCode: json["FunctionHeadEmpCode"],
        functionHeadName: json["FunctionHeadName"],
        functionName: json["FunctionName"],
        groupHeadEmpCode: json["GroupHeadEmpCode"],
        groupHeadName: json["GroupHeadName"],
        isHardwareAmcvAlidated: json["IsHardwareAMCVAlidated"],
        nsiProject: json["NSIProject"],
        nonCashFlow: json["NonCashFlow"],
        nonCashFlowWords: json["NonCashFlowWords"],
        ppmProjectId: json["PPMProjectID"],
        projBudgetCategory: json["ProjBudgetCategory"],
        projectDescription: json["ProjectDescription"],
        projectId: json["ProjectId"],
        projectName: json["ProjectName"],
        vIsitaNsiProject: json["vIsitaNSIProject"],
        vPpmProjectId: json["vPPMProjectID"],
        projectRelevance: json["ProjectRelevance"],
        noOfPhase: json["NoOfPhase"] != null
            ? List<NoOfPhase>.from(
                json["NoOfPhase"].map((x) => NoOfPhase.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "AMCRemark": amcRemark,
        "CashFlow": cashFlow,
        "CashFlowWords": cashFlowWords,
        "ConceptInitiatorDate": conceptInitiatorDate,
        "ConceptInitiatorEmpCode": conceptInitiatorEmpCode,
        "ConceptInitiatorName": conceptInitiatorName,
        "Days": days,
        "FpnAmount": fpnAmount,
        "FpnAmountWords": fpnAmountWords,
        "FpnCategory": fpnCategory,
        "FpnSubCategory": fpnSubCategory,
        "FunctionHeadEmpCode": functionHeadEmpCode,
        "FunctionHeadName": functionHeadName,
        "FunctionName": functionName,
        "GroupHeadEmpCode": groupHeadEmpCode,
        "GroupHeadName": groupHeadName,
        "IsHardwareAMCVAlidated": isHardwareAmcvAlidated,
        "NSIProject": nsiProject,
        "NonCashFlow": nonCashFlow,
        "NonCashFlowWords": nonCashFlowWords,
        "PPMProjectID": ppmProjectId,
        "ProjBudgetCategory": projBudgetCategory,
        "ProjectDescription": projectDescription,
        "ProjectId": projectId,
        "ProjectName": projectName,
        "vIsitaNSIProject": vIsitaNsiProject,
        "vPPMProjectID": vPpmProjectId,
        "ProjectRelevance": projectRelevance,
        "NoOfPhase": noOfPhase!.map((v) => v.toJson()).toList()
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
