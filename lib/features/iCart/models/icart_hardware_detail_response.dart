class ICartHardwareDetailModel {
  String? responseMessage;
  int? returnStatus;
  String? addtionalInfo;
  RequestDetails? requestDetails;
  String? requestNo;
  String? requestType;

  ICartHardwareDetailModel(
      {this.responseMessage,
      this.returnStatus,
      this.addtionalInfo,
      this.requestDetails,
      this.requestNo,
      this.requestType});

  ICartHardwareDetailModel.fromJson(Map<String, dynamic> json) {
    responseMessage = json['ResponseMessage'];
    returnStatus = json['ReturnStatus'];
    addtionalInfo = json['AddtionalInfo'];
    requestDetails = json['RequestDetails'] != null
        ? RequestDetails.fromJson(json['RequestDetails'])
        : null;
    requestNo = json['RequestNo'];
    requestType = json['RequestType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ResponseMessage'] = responseMessage;
    data['ReturnStatus'] = returnStatus;
    data['AddtionalInfo'] = addtionalInfo;
    if (requestDetails != null) {
      data['RequestDetails'] = requestDetails!.toJson();
    }
    data['RequestNo'] = requestNo;
    data['RequestType'] = requestType;
    return data;
  }
}

class RequestDetails {
  List<ApproverHistory>? approverHistory;
  ApproverDetail? approverDetail;
  ChecklistValidations? checklistValidations;
  DeliveryDetails? deliveryDetails;
  EmployeeInformation? employeeInformation;
  ExistingAssetDetails? existingAssetDetails;
  InvoicingPaymentFar? invoicingPaymentFar;
  PoInsuranceInstallation? poInsuranceInstallation;
  List<QueryFeedback>? queryFeedback;
  RequestInfo? requestInfo;
  RequestReason? requestReason;
  UnitDetails? unitDetails;

  RequestDetails(
      {this.approverHistory,
      this.approverDetail,
      this.checklistValidations,
      this.deliveryDetails,
      this.employeeInformation,
      this.existingAssetDetails,
      this.invoicingPaymentFar,
      this.poInsuranceInstallation,
      this.queryFeedback,
      this.requestInfo,
      this.requestReason,
      this.unitDetails});

  RequestDetails.fromJson(Map<String, dynamic> json) {
    if (json['ApproverHistory'] != null) {
      approverHistory = <ApproverHistory>[];
      json['ApproverHistory'].forEach((v) {
        approverHistory!.add(ApproverHistory.fromJson(v));
      });
    }
    approverDetail = json['approverDetail'] != null
        ? ApproverDetail.fromJson(json['approverDetail'])
        : null;
    checklistValidations = json['checklistValidations'] != null
        ? ChecklistValidations.fromJson(json['checklistValidations'])
        : null;
    deliveryDetails = json['deliveryDetails'] != null
        ? DeliveryDetails.fromJson(json['deliveryDetails'])
        : null;
    employeeInformation = json['employeeInformation'] != null
        ? EmployeeInformation.fromJson(json['employeeInformation'])
        : null;
    existingAssetDetails = json['existingAssetDetails'] != null
        ? ExistingAssetDetails.fromJson(json['existingAssetDetails'])
        : null;
    invoicingPaymentFar = json['invoicingPaymentFar'] != null
        ? InvoicingPaymentFar.fromJson(json['invoicingPaymentFar'])
        : null;
    poInsuranceInstallation = json['poInsuranceInstallation'] != null
        ? PoInsuranceInstallation.fromJson(json['poInsuranceInstallation'])
        : null;
    requestInfo = json['requestInfo'] != null
        ? RequestInfo.fromJson(json['requestInfo'])
        : null;
    requestReason = json['requestReason'] != null
        ? RequestReason.fromJson(json['requestReason'])
        : null;
    unitDetails = json['unitDetails'] != null
        ? UnitDetails.fromJson(json['unitDetails'])
        : null;
    if (json['queryFeedback'] != null) {
      queryFeedback = <QueryFeedback>[];
      json['queryFeedback'].forEach((v) {
        queryFeedback!.add(QueryFeedback.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (approverHistory != null) {
      data['ApproverHistory'] =
          approverHistory!.map((v) => v.toJson()).toList();
    }
    if (approverDetail != null) {
      data['approverDetail'] = approverDetail!.toJson();
    }
    if (checklistValidations != null) {
      data['checklistValidations'] = checklistValidations!.toJson();
    }
    if (deliveryDetails != null) {
      data['deliveryDetails'] = deliveryDetails!.toJson();
    }
    if (employeeInformation != null) {
      data['employeeInformation'] = employeeInformation!.toJson();
    }
    if (existingAssetDetails != null) {
      data['existingAssetDetails'] = existingAssetDetails!.toJson();
    }
    if (invoicingPaymentFar != null) {
      data['invoicingPaymentFar'] = invoicingPaymentFar!.toJson();
    }
    if (poInsuranceInstallation != null) {
      data['poInsuranceInstallation'] = poInsuranceInstallation!.toJson();
    }
    if (queryFeedback != null) {
      data['queryFeedback'] = queryFeedback!.map((v) => v.toJson()).toList();
    }
    if (requestInfo != null) {
      data['requestInfo'] = requestInfo!.toJson();
    }
    if (requestReason != null) {
      data['requestReason'] = requestReason!.toJson();
    }
    if (unitDetails != null) {
      data['unitDetails'] = unitDetails!.toJson();
    }
    return data;
  }
}

class ApproverHistory {
  String? actionBy;
  String? actionByName;
  String? actionDate;
  String? approverRole;
  String? remarks;
  String? status;

  ApproverHistory(
      {this.actionBy,
      this.actionByName,
      this.actionDate,
      this.approverRole,
      this.remarks,
      this.status});

  ApproverHistory.fromJson(Map<String, dynamic> json) {
    actionBy = json['ActionBy'];
    actionByName = json['ActionByName'];
    actionDate = json['ActionDate'];
    approverRole = json['ApproverRole'];
    remarks = json['Remarks'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ActionBy'] = actionBy;
    data['ActionByName'] = actionByName;
    data['ActionDate'] = actionDate;
    data['ApproverRole'] = approverRole;
    data['Remarks'] = remarks;
    data['Status'] = status;
    return data;
  }
}

class QueryFeedback {
  String? actionBy;
  String? requestNo;
  String? actionDate;
  String? hardwareQueryFeedback;
  String? status;

  QueryFeedback(
      {this.actionBy,
      this.requestNo,
      this.actionDate,
      this.hardwareQueryFeedback,
      this.status});

  QueryFeedback.fromJson(Map<String, dynamic> json) {
    actionBy = json['ActionBy'];
    requestNo = json['RequestNo'];
    actionDate = json['ActionDate'];
    hardwareQueryFeedback = json['HardwareQueryFeedback'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ActionBy'] = actionBy;
    data['RequestNo'] = requestNo;
    data['ActionDate'] = actionDate;
    data['HardwareQueryFeedback'] = hardwareQueryFeedback;
    data['Status'] = status;
    return data;
  }
}

class ApproverDetail {
  String? approveRejectRemarks;
  String? approver;
  String? approverLineManager;
  String? lineManager;
  String? lineManagerBand;
  String? nextApprover;
  String? nextApproverBand;
  String? reason;
  String? selectReason;
  String? gradeOrderno;

  ApproverDetail(
      {this.approveRejectRemarks,
      this.approver,
      this.approverLineManager,
      this.lineManager,
      this.lineManagerBand,
      this.nextApprover,
      this.nextApproverBand,
      this.reason,
      this.selectReason,
      this.gradeOrderno});

  ApproverDetail.fromJson(Map<String, dynamic> json) {
    approveRejectRemarks = json['ApproveRejectRemarks'];
    approver = json['Approver'];
    approverLineManager = json['ApproverLineManager'];
    lineManager = json['LineManager'];
    lineManagerBand = json['LineManagerBand'];
    nextApprover = json['NextApprover'];
    nextApproverBand = json['NextApproverBand'];
    reason = json['Reason'];
    selectReason = json['SelectReason'];
    gradeOrderno = json['gradeOrderno'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ApproveRejectRemarks'] = approveRejectRemarks;
    data['Approver'] = approver;
    data['ApproverLineManager'] = approverLineManager;
    data['LineManager'] = lineManager;
    data['LineManagerBand'] = lineManagerBand;
    data['NextApprover'] = nextApprover;
    data['NextApproverBand'] = nextApproverBand;
    data['Reason'] = reason;
    data['SelectReason'] = selectReason;
    data['gradeOrderno'] = gradeOrderno;
    return data;
  }
}

class ChecklistValidations {
  String? assetReplace;
  String? freePool;
  String? sameCallID;
  String? userMentionedID;

  ChecklistValidations(
      {this.assetReplace,
      this.freePool,
      this.sameCallID,
      this.userMentionedID});

  ChecklistValidations.fromJson(Map<String, dynamic> json) {
    assetReplace = json['AssetReplace'];
    freePool = json['FreePool'];
    sameCallID = json['SameCallID'];
    userMentionedID = json['UserMentionedID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AssetReplace'] = assetReplace;
    data['FreePool'] = freePool;
    data['SameCallID'] = sameCallID;
    data['UserMentionedID'] = userMentionedID;
    return data;
  }
}

class DeliveryDetails {
  String? buildingValue;
  String? contactEmpCode;
  String? contactEmpName;
  String? contactNum;
  String? deliverAddress;
  String? deliverBranchCode;
  String? deliverBranchName;
  String? deliveryDate;
  String? floorNo;
  String? newAssetOwnerEmpCode;
  String? newAssetOwnerEmpName;
  String? updateDeliveryDate;

  DeliveryDetails(
      {this.buildingValue,
      this.contactEmpCode,
      this.contactEmpName,
      this.contactNum,
      this.deliverAddress,
      this.deliverBranchCode,
      this.deliverBranchName,
      this.deliveryDate,
      this.floorNo,
      this.newAssetOwnerEmpCode,
      this.newAssetOwnerEmpName,
      this.updateDeliveryDate});

  DeliveryDetails.fromJson(Map<String, dynamic> json) {
    buildingValue = json['BuildingValue'];
    contactEmpCode = json['ContactEmpCode'];
    contactEmpName = json['ContactEmpName'];
    contactNum = json['ContactNum'];
    deliverAddress = json['DeliverAddress'];
    deliverBranchCode = json['DeliverBranchCode'];
    deliverBranchName = json['DeliverBranchName'];
    deliveryDate = json['DeliveryDate'];
    floorNo = json['FloorNo'];
    newAssetOwnerEmpCode = json['NewAssetOwnerEmpCode'];
    newAssetOwnerEmpName = json['NewAssetOwnerEmpName'];
    updateDeliveryDate = json['UpdateDeliveryDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['BuildingValue'] = buildingValue;
    data['ContactEmpCode'] = contactEmpCode;
    data['ContactEmpName'] = contactEmpName;
    data['ContactNum'] = contactNum;
    data['DeliverAddress'] = deliverAddress;
    data['DeliverBranchCode'] = deliverBranchCode;
    data['DeliverBranchName'] = deliverBranchName;
    data['DeliveryDate'] = deliveryDate;
    data['FloorNo'] = floorNo;
    data['NewAssetOwnerEmpCode'] = newAssetOwnerEmpCode;
    data['NewAssetOwnerEmpName'] = newAssetOwnerEmpName;
    data['UpdateDeliveryDate'] = updateDeliveryDate;
    return data;
  }
}

class EmployeeInformation {
  String? branchCode;
  String? branchName;
  String? costCode;
  String? costCodeName;
  String? empGrade;
  String? empCode;
  String? empName;
  String? headCount;
  String? positionCode;
  String? region;
  String? state;

  EmployeeInformation(
      {this.branchCode,
      this.branchName,
      this.costCode,
      this.costCodeName,
      this.empCode,
      this.empGrade,
      this.empName,
      this.headCount,
      this.positionCode,
      this.region,
      this.state});

  EmployeeInformation.fromJson(Map<String, dynamic> json) {
    branchCode = json['BranchCode'];
    branchName = json['BranchName'];
    costCode = json['CostCode'];
    costCodeName = json['CostCodeName'];
    empGrade = json['EmpGrade'];
    empName = json['EmpName'];
    empCode = json['EmpCode'];
    headCount = json['HeadCount'];
    positionCode = json['PositionCode'];
    region = json['Region'];
    state = json['State'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['BranchCode'] = branchCode;
    data['BranchName'] = branchName;
    data['CostCode'] = costCode;
    data['CostCodeName'] = costCodeName;
    data['EmpGrade'] = empGrade;
    data['EmpName'] = empName;
    data['EmpCode'] = empCode;
    data['HeadCount'] = headCount;
    data['PositionCode'] = positionCode;
    data['Region'] = region;
    data['State'] = state;

    return data;
  }
}

class ExistingAssetDetails {
  String? assetCategory;
  String? assetCode;
  String? assetCurrBranchCode;
  String? assetCurrBranchName;
  String? assetSerialNo;
  String? assetStatus;
  String? assetSubStatus;
  String? assetType;
  String? assetWarrentyEndDate;
  String? assetWarrentyStartDate;
  String? callLogNo;
  String? wDV;

  ExistingAssetDetails(
      {this.assetCategory,
      this.assetCode,
      this.assetCurrBranchCode,
      this.assetCurrBranchName,
      this.assetSerialNo,
      this.assetStatus,
      this.assetSubStatus,
      this.assetType,
      this.assetWarrentyEndDate,
      this.assetWarrentyStartDate,
      this.callLogNo,
      this.wDV});

  ExistingAssetDetails.fromJson(Map<String, dynamic> json) {
    assetCategory = json['AssetCategory'];
    assetCode = json['AssetCode'];
    assetCurrBranchCode = json['AssetCurrBranchCode'];
    assetCurrBranchName = json['AssetCurrBranchName'];
    assetSerialNo = json['AssetSerialNo'];
    assetStatus = json['AssetStatus'];
    assetSubStatus = json['AssetSubStatus'];
    assetType = json['AssetType'];
    assetWarrentyEndDate = json['AssetWarrentyEndDate'];
    assetWarrentyStartDate = json['AssetWarrentyStartDate'];
    callLogNo = json['CallLogNo'];
    wDV = json['WDV'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AssetCategory'] = assetCategory;
    data['AssetCode'] = assetCode;
    data['AssetCurrBranchCode'] = assetCurrBranchCode;
    data['AssetCurrBranchName'] = assetCurrBranchName;
    data['AssetSerialNo'] = assetSerialNo;
    data['AssetStatus'] = assetStatus;
    data['AssetSubStatus'] = assetSubStatus;
    data['AssetType'] = assetType;
    data['AssetWarrentyEndDate'] = assetWarrentyEndDate;
    data['AssetWarrentyStartDate'] = assetWarrentyStartDate;
    data['CallLogNo'] = callLogNo;
    data['WDV'] = wDV;
    return data;
  }
}

class InvoicingPaymentFar {
  String? fARNo;
  String? invoiceAcceptanceDate;
  String? invoiceAmount;
  String? invoiceDate;
  String? invoiceNumber;
  String? invoicePaymentDate;
  String? invoiceReceiptDate;
  String? invoiceSubmissionDate;
  String? invoiceVoucherNo;

  InvoicingPaymentFar(
      {this.fARNo,
      this.invoiceAcceptanceDate,
      this.invoiceAmount,
      this.invoiceDate,
      this.invoiceNumber,
      this.invoicePaymentDate,
      this.invoiceReceiptDate,
      this.invoiceSubmissionDate,
      this.invoiceVoucherNo});

  InvoicingPaymentFar.fromJson(Map<String, dynamic> json) {
    fARNo = json['FARNo'];
    invoiceAcceptanceDate = json['InvoiceAcceptanceDate'];
    invoiceAmount = json['InvoiceAmount'];
    invoiceDate = json['InvoiceDate'];
    invoiceNumber = json['InvoiceNumber'];
    invoicePaymentDate = json['InvoicePaymentDate'];
    invoiceReceiptDate = json['InvoiceReceiptDate'];
    invoiceSubmissionDate = json['InvoiceSubmissionDate'];
    invoiceVoucherNo = json['InvoiceVoucherNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['FARNo'] = fARNo;
    data['InvoiceAcceptanceDate'] = invoiceAcceptanceDate;
    data['InvoiceAmount'] = invoiceAmount;
    data['InvoiceDate'] = invoiceDate;
    data['InvoiceNumber'] = invoiceNumber;
    data['InvoicePaymentDate'] = invoicePaymentDate;
    data['InvoiceReceiptDate'] = invoiceReceiptDate;
    data['InvoiceSubmissionDate'] = invoiceSubmissionDate;
    data['InvoiceVoucherNo'] = invoiceVoucherNo;
    return data;
  }
}

class PoInsuranceInstallation {
  String? installationDate;
  String? insuranceAmount;
  String? insuranceEndDate;
  String? insurancePolicyNo;
  String? insuranceStartDate;
  String? newAssetCode;
  String? newFMCallLogNo;
  String? newSerialNumber;
  String? pODate;
  String? pONumber;

  PoInsuranceInstallation(
      {this.installationDate,
      this.insuranceAmount,
      this.insuranceEndDate,
      this.insurancePolicyNo,
      this.insuranceStartDate,
      this.newAssetCode,
      this.newFMCallLogNo,
      this.newSerialNumber,
      this.pODate,
      this.pONumber});

  PoInsuranceInstallation.fromJson(Map<String, dynamic> json) {
    installationDate = json['InstallationDate'];
    insuranceAmount = json['InsuranceAmount'];
    insuranceEndDate = json['InsuranceEndDate'];
    insurancePolicyNo = json['InsurancePolicyNo'];
    insuranceStartDate = json['InsuranceStartDate'];
    newAssetCode = json['NewAssetCode'];
    newFMCallLogNo = json['NewFMCallLogNo'];
    newSerialNumber = json['NewSerialNumber'];
    pODate = json['PODate'];
    pONumber = json['PONumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['InstallationDate'] = installationDate;
    data['InsuranceAmount'] = insuranceAmount;
    data['InsuranceEndDate'] = insuranceEndDate;
    data['InsurancePolicyNo'] = insurancePolicyNo;
    data['InsuranceStartDate'] = insuranceStartDate;
    data['NewAssetCode'] = newAssetCode;
    data['NewFMCallLogNo'] = newFMCallLogNo;
    data['NewSerialNumber'] = newSerialNumber;
    data['PODate'] = pODate;
    data['PONumber'] = pONumber;
    return data;
  }
}

class RequestInfo {
  String? newExisting;
  String? requestFor;
  String? requestType;
  String? userType;

  RequestInfo(
      {this.newExisting, this.requestFor, this.requestType, this.userType});

  RequestInfo.fromJson(Map<String, dynamic> json) {
    newExisting = json['NewExisting'];
    requestFor = json['RequestFor'];
    requestType = json['RequestType'];
    userType = json['UserType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['NewExisting'] = newExisting;
    data['RequestFor'] = requestFor;
    data['RequestType'] = requestType;
    data['UserType'] = userType;
    return data;
  }
}

class RequestReason {
  String? reqReason;

  RequestReason({this.reqReason});

  RequestReason.fromJson(Map<String, dynamic> json) {
    reqReason = json['ReqReason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ReqReason'] = reqReason;
    return data;
  }
}

class UnitDetails {
  String? costCodeDebited;
  String? deliveryTimelines;
  String? fDReceiptNo;
  String? hardDiskFormating;
  String? lANPort;
  String? newReplace;
  String? printScanVolumesPerDay;
  String? productType;
  String? unit;
  String? unitAmount;
  String? unitConfig;
  String? unitSpec;

  UnitDetails(
      {this.costCodeDebited,
      this.deliveryTimelines,
      this.fDReceiptNo,
      this.hardDiskFormating,
      this.lANPort,
      this.newReplace,
      this.printScanVolumesPerDay,
      this.productType,
      this.unit,
      this.unitAmount,
      this.unitConfig,
      this.unitSpec});

  UnitDetails.fromJson(Map<String, dynamic> json) {
    costCodeDebited = json['CostCodeDebited'];
    deliveryTimelines = json['DeliveryTimelines'];
    fDReceiptNo = json['FDReceiptNo'];
    hardDiskFormating = json['HardDiskFormating'];
    lANPort = json['LANPort'];
    newReplace = json['NewReplace'];
    printScanVolumesPerDay = json['PrintScanVolumesPerDay'];
    productType = json['ProductType'];
    unit = json['Unit'];
    unitAmount = json['UnitAmount'];
    unitConfig = json['UnitConfig'];
    unitSpec = json['UnitSpec'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CostCodeDebited'] = costCodeDebited;
    data['DeliveryTimelines'] = deliveryTimelines;
    data['FDReceiptNo'] = fDReceiptNo;
    data['HardDiskFormating'] = hardDiskFormating;
    data['LANPort'] = lANPort;
    data['NewReplace'] = newReplace;
    data['PrintScanVolumesPerDay'] = printScanVolumesPerDay;
    data['ProductType'] = productType;
    data['Unit'] = unit;
    data['UnitAmount'] = unitAmount;
    data['UnitConfig'] = unitConfig;
    data['UnitSpec'] = unitSpec;
    return data;
  }
}
