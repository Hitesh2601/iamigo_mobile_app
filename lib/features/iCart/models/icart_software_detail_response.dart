class ICartSoftwareRequestDetail {
  String? responseMessage;
  int? returnStatus;
  String? requestNo;
  String? requestType;
  SoftwareRequestDetails? softwareRequestDetails;

  ICartSoftwareRequestDetail(
      {this.responseMessage,
      this.returnStatus,
      this.requestNo,
      this.requestType,
      this.softwareRequestDetails});

  ICartSoftwareRequestDetail.fromJson(Map<String, dynamic> json) {
    responseMessage = json['ResponseMessage'];
    returnStatus = json['ReturnStatus'];
    requestNo = json['RequestNo'];
    requestType = json['RequestType'];
    softwareRequestDetails = json['SoftwareRequestDetails'] != null
        ? SoftwareRequestDetails.fromJson(json['SoftwareRequestDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ResponseMessage'] = responseMessage;
    data['ReturnStatus'] = returnStatus;
    data['RequestNo'] = requestNo;
    data['RequestType'] = requestType;
    if (softwareRequestDetails != null) {
      data['SoftwareRequestDetails'] = softwareRequestDetails!.toJson();
    }
    return data;
  }
}

class SoftwareRequestDetails {
  List<ApproverHistory>? approverHistory;
  String? approverRejectRemark;
  ExtensionRequest? extensionRequest;
  SoftRequestDetails? softRequestDetails;
  SoftwareApproverDetail? softwareApproverDetail;
  SoftwareApproverPeriod? softwareApproverPeriod;
  SoftwareEmployeeInformation? softwareEmployeeInformation;
  SoftwareExistingAssetDetails? softwareExistingAssetDetails;
  List<SoftwareQueryFeedback>? softwareQueryFeedback;
  SoftwareRequestInformation? softwareRequestInformation;
  SoftwareUnitDetails? softwareUnitDetails;
  TemporaryLicense? temporaryLicense;

  SoftwareRequestDetails(
      {this.approverHistory,
      this.approverRejectRemark,
      this.extensionRequest,
      this.softRequestDetails,
      this.softwareApproverDetail,
      this.softwareApproverPeriod,
      this.softwareEmployeeInformation,
      this.softwareExistingAssetDetails,
      this.softwareQueryFeedback,
      this.softwareRequestInformation,
      this.softwareUnitDetails,
      this.temporaryLicense});

  SoftwareRequestDetails.fromJson(Map<String, dynamic> json) {
    if (json['ApproverHistory'] != null) {
      approverHistory = <ApproverHistory>[];
      json['ApproverHistory'].forEach((v) {
        approverHistory!.add(ApproverHistory.fromJson(v));
      });
    }
    if (json['softwareQueryFeedback'] != null) {
      softwareQueryFeedback = <SoftwareQueryFeedback>[];
      json['softwareQueryFeedback'].forEach((v) {
        softwareQueryFeedback!.add(SoftwareQueryFeedback.fromJson(v));
      });
    }
    approverRejectRemark = json['ApproverRejectRemark'];
    extensionRequest = json['ExtensionRequest'] != null
        ? ExtensionRequest.fromJson(json['ExtensionRequest'])
        : null;
    softRequestDetails = json['SoftRequestDetails'] != null
        ? SoftRequestDetails.fromJson(json['SoftRequestDetails'])
        : null;
    softwareApproverDetail = json['SoftwareApproverDetail'] != null
        ? SoftwareApproverDetail.fromJson(json['SoftwareApproverDetail'])
        : null;
    softwareApproverPeriod = json['SoftwareApproverPeriod'] != null
        ? SoftwareApproverPeriod.fromJson(json['SoftwareApproverPeriod'])
        : null;
    softwareEmployeeInformation = json['SoftwareEmployeeInformation'] != null
        ? SoftwareEmployeeInformation.fromJson(
            json['SoftwareEmployeeInformation'])
        : null;
    softwareExistingAssetDetails = json['SoftwareExistingAssetDetails'] != null
        ? SoftwareExistingAssetDetails.fromJson(
            json['SoftwareExistingAssetDetails'])
        : null;
    softwareRequestInformation = json['SoftwareRequestInformation'] != null
        ? SoftwareRequestInformation.fromJson(
            json['SoftwareRequestInformation'])
        : null;
    softwareUnitDetails = json['SoftwareUnitDetails'] != null
        ? SoftwareUnitDetails.fromJson(json['SoftwareUnitDetails'])
        : null;
    temporaryLicense = json['TemporaryLicense'] != null
        ? TemporaryLicense.fromJson(json['TemporaryLicense'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (approverHistory != null) {
      data['ApproverHistory'] =
          approverHistory!.map((v) => v.toJson()).toList();
    }
    data['ApproverRejectRemark'] = approverRejectRemark;
    if (extensionRequest != null) {
      data['ExtensionRequest'] = extensionRequest!.toJson();
    }
    if (softRequestDetails != null) {
      data['SoftRequestDetails'] = softRequestDetails!.toJson();
    }
    if (softwareApproverDetail != null) {
      data['SoftwareApproverDetail'] = softwareApproverDetail!.toJson();
    }
    if (softwareApproverPeriod != null) {
      data['SoftwareApproverPeriod'] = softwareApproverPeriod!.toJson();
    }
    if (softwareEmployeeInformation != null) {
      data['SoftwareEmployeeInformation'] =
          softwareEmployeeInformation!.toJson();
    }
    if (softwareExistingAssetDetails != null) {
      data['SoftwareExistingAssetDetails'] =
          softwareExistingAssetDetails!.toJson();
    }
    if (softwareQueryFeedback != null) {
      data['softwareQueryFeedback'] =
          softwareQueryFeedback!.map((v) => v.toJson()).toList();
    }
    if (softwareRequestInformation != null) {
      data['SoftwareRequestInformation'] = softwareRequestInformation!.toJson();
    }
    if (softwareUnitDetails != null) {
      data['SoftwareUnitDetails'] = softwareUnitDetails!.toJson();
    }
    if (temporaryLicense != null) {
      data['TemporaryLicense'] = temporaryLicense!.toJson();
    }
    return data;
  }
}

class SoftwareQueryFeedback {
  String? actionBy;
  String? requestNo;
  String? actionDate;
  String? hardwareQueryFeedback;
  String? status;

  SoftwareQueryFeedback(
      {this.actionBy,
      this.requestNo,
      this.actionDate,
      this.hardwareQueryFeedback,
      this.status});

  SoftwareQueryFeedback.fromJson(Map<String, dynamic> json) {
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

class ExtensionRequest {
  List<ExtensionDetailsList>? extensionDetailsList;
  String? rootRequestNo;
  String? totalNumberOfDays;

  ExtensionRequest(
      {this.extensionDetailsList, this.rootRequestNo, this.totalNumberOfDays});

  ExtensionRequest.fromJson(Map<String, dynamic> json) {
    if (json['ExtensionDetailsList'] != null) {
      extensionDetailsList = <ExtensionDetailsList>[];
      json['ExtensionDetailsList'].forEach((v) {
        extensionDetailsList!.add(ExtensionDetailsList.fromJson(v));
      });
    }
    rootRequestNo = json['RootRequestNo'];
    totalNumberOfDays = json['TotalNumberOfDays'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (extensionDetailsList != null) {
      data['ExtensionDetailsList'] =
          extensionDetailsList!.map((v) => v.toJson()).toList();
    }
    data['RootRequestNo'] = rootRequestNo;
    data['TotalNumberOfDays'] = totalNumberOfDays;
    return data;
  }
}

class ExtensionDetailsList {
  String? extendedForRequestNumber;
  String? extensionOrder;
  String? licenseEndDate;
  String? licenseStartDate;
  String? noOfDays;
  String? requestNumber;

  ExtensionDetailsList(
      {this.extendedForRequestNumber,
      this.extensionOrder,
      this.licenseEndDate,
      this.licenseStartDate,
      this.noOfDays,
      this.requestNumber});

  ExtensionDetailsList.fromJson(Map<String, dynamic> json) {
    extendedForRequestNumber = json['ExtendedForRequestNumber'];
    extensionOrder = json['ExtensionOrder'];
    licenseEndDate = json['LicenseEndDate'];
    licenseStartDate = json['LicenseStartDate'];
    noOfDays = json['NoOfDays'];
    requestNumber = json['RequestNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ExtendedForRequestNumber'] = extendedForRequestNumber;
    data['ExtensionOrder'] = extensionOrder;
    data['LicenseEndDate'] = licenseEndDate;
    data['LicenseStartDate'] = licenseStartDate;
    data['NoOfDays'] = noOfDays;
    data['RequestNumber'] = requestNumber;
    return data;
  }
}

class SoftRequestDetails {
  String? empCode;
  String? empName;
  String? installationDate;
  String? justification;
  String? mobileNo;

  SoftRequestDetails(
      {this.empCode,
      this.empName,
      this.installationDate,
      this.justification,
      this.mobileNo});

  SoftRequestDetails.fromJson(Map<String, dynamic> json) {
    empCode = json['EmpCode'];
    empName = json['EmpName'];
    installationDate = json['InstallationDate'];
    justification = json['Justification'];
    mobileNo = json['MobileNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EmpCode'] = empCode;
    data['EmpName'] = empName;
    data['InstallationDate'] = installationDate;
    data['Justification'] = justification;
    data['MobileNo'] = mobileNo;
    return data;
  }
}

class SoftwareApproverDetail {
  String? approveRejectRemarks;
  String? approver;
  String? approverLineManager;
  String? lineManager;
  String? lineManagerBand;
  String? nextApprover;
  String? nextApproverBand;
  String? selectReason;
  String? gradeOrderno;

  SoftwareApproverDetail(
      {this.approveRejectRemarks,
      this.approver,
      this.approverLineManager,
      this.lineManager,
      this.lineManagerBand,
      this.nextApprover,
      this.nextApproverBand,
      this.selectReason,
      this.gradeOrderno});

  SoftwareApproverDetail.fromJson(Map<String, dynamic> json) {
    approveRejectRemarks = json['ApproveRejectRemarks'];
    approver = json['Approver'];
    approverLineManager = json['ApproverLineManager'];
    lineManager = json['LineManager'];
    lineManagerBand = json['LineManagerBand'];
    nextApprover = json['NextApprover'];
    nextApproverBand = json['NextApproverBand'];
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
    data['SelectReason'] = selectReason;
    data['gradeOrderno'] = gradeOrderno;
    return data;
  }
}

class SoftwareApproverPeriod {
  String? approvedForDays;
  String? endDate;
  String? startDate;
  String? userInputtedDays;

  SoftwareApproverPeriod(
      {this.approvedForDays,
      this.endDate,
      this.startDate,
      this.userInputtedDays});

  SoftwareApproverPeriod.fromJson(Map<String, dynamic> json) {
    approvedForDays = json['ApprovedForDays'];
    endDate = json['EndDate'];
    startDate = json['StartDate'];
    userInputtedDays = json['UserInputtedDays'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ApprovedForDays'] = approvedForDays;
    data['EndDate'] = endDate;
    data['StartDate'] = startDate;
    data['UserInputtedDays'] = userInputtedDays;
    return data;
  }
}

class SoftwareEmployeeInformation {
  String? branchCode;
  String? branchName;
  String? costCode;
  String? costCodeName;
  String? empCode;
  String? empGrade;
  String? empName;
  String? headCount;
  String? region;
  String? state;

  SoftwareEmployeeInformation(
      {this.branchCode,
      this.branchName,
      this.costCode,
      this.costCodeName,
      this.empCode,
      this.empGrade,
      this.empName,
      this.headCount,
      this.region,
      this.state});

  SoftwareEmployeeInformation.fromJson(Map<String, dynamic> json) {
    branchCode = json['BranchCode'];
    branchName = json['BranchName'];
    costCode = json['CostCode'];
    costCodeName = json['CostCodeName'];
    empCode = json['EmpCode'];
    empGrade = json['EmpGrade'];
    empName = json['EmpName'];
    headCount = json['HeadCount'];
    region = json['Region'];
    state = json['State'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['BranchCode'] = branchCode;
    data['BranchName'] = branchName;
    data['CostCode'] = costCode;
    data['CostCodeName'] = costCodeName;
    data['EmpCode'] = empCode;
    data['EmpGrade'] = empGrade;
    data['EmpName'] = empName;
    data['HeadCount'] = headCount;
    data['Region'] = region;
    data['State'] = state;
    return data;
  }
}

class SoftwareExistingAssetDetails {
  String? assetCategory;
  String? assetCode;
  String? assetDesc;
  String? assetSerialNo;
  String? assetStatus;
  String? assetSubStatus;
  String? assetType;

  SoftwareExistingAssetDetails(
      {this.assetCategory,
      this.assetCode,
      this.assetDesc,
      this.assetSerialNo,
      this.assetStatus,
      this.assetSubStatus,
      this.assetType});

  SoftwareExistingAssetDetails.fromJson(Map<String, dynamic> json) {
    assetCategory = json['AssetCategory'];
    assetCode = json['AssetCode'];
    assetDesc = json['AssetDesc'];
    assetSerialNo = json['AssetSerialNo'];
    assetStatus = json['AssetStatus'];
    assetSubStatus = json['AssetSubStatus'];
    assetType = json['AssetType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AssetCategory'] = assetCategory;
    data['AssetCode'] = assetCode;
    data['AssetDesc'] = assetDesc;
    data['AssetSerialNo'] = assetSerialNo;
    data['AssetStatus'] = assetStatus;
    data['AssetSubStatus'] = assetSubStatus;
    data['AssetType'] = assetType;
    return data;
  }
}

class SoftwareRequestInformation {
  String? newExisting;
  String? requestFor;
  String? requestType;
  String? userType;

  SoftwareRequestInformation(
      {this.newExisting, this.requestFor, this.requestType, this.userType});

  SoftwareRequestInformation.fromJson(Map<String, dynamic> json) {
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

class SoftwareUnitDetails {
  String? acquisitionType;
  String? assetCode;
  String? assetType;
  String? environment;
  String? newReplace;
  String? noOfProcessors;
  String? noOfdays;
  String? oSVersion;
  String? ownerEmpCode;
  String? ownerName;
  String? previousInstalledSoftWare;
  String? previousInstalledSoftWareVersion;
  String? projectName;
  String? publisher;
  String? serverHostName;
  String? serverIPAddress;
  String? serverLocation;
  String? serverType;
  String? software;
  String? softwareCategory;
  String? softwareType;
  String? totalCore;
  String? transferFromAssetCode;
  String? transferFromEmpCode;
  String? unitAmount;
  String? upgradeToSoftware;
  String? upgradeToSoftwareVersion;
  String? version;

  SoftwareUnitDetails(
      {this.acquisitionType,
      this.assetCode,
      this.assetType,
      this.environment,
      this.newReplace,
      this.noOfProcessors,
      this.noOfdays,
      this.oSVersion,
      this.ownerEmpCode,
      this.ownerName,
      this.previousInstalledSoftWare,
      this.previousInstalledSoftWareVersion,
      this.projectName,
      this.publisher,
      this.serverHostName,
      this.serverIPAddress,
      this.serverLocation,
      this.serverType,
      this.software,
      this.softwareCategory,
      this.softwareType,
      this.totalCore,
      this.transferFromAssetCode,
      this.transferFromEmpCode,
      this.unitAmount,
      this.upgradeToSoftware,
      this.upgradeToSoftwareVersion,
      this.version});

  SoftwareUnitDetails.fromJson(Map<String, dynamic> json) {
    acquisitionType = json['AcquisitionType'];
    assetCode = json['AssetCode'];
    assetType = json['AssetType'];
    environment = json['Environment'];
    newReplace = json['NewReplace'];
    noOfProcessors = json['NoOfProcessors'];
    noOfdays = json['NoOfdays'];
    oSVersion = json['OSVersion'];
    ownerEmpCode = json['OwnerEmpCode'];
    ownerName = json['OwnerName'];
    previousInstalledSoftWare = json['PreviousInstalledSoftWare'];
    previousInstalledSoftWareVersion = json['PreviousInstalledSoftWareVersion'];
    projectName = json['ProjectName'];
    publisher = json['Publisher'];
    serverHostName = json['ServerHostName'];
    serverIPAddress = json['ServerIPAddress'];
    serverLocation = json['ServerLocation'];
    serverType = json['ServerType'];
    software = json['Software'];
    softwareCategory = json['SoftwareCategory'];
    softwareType = json['SoftwareType'];
    totalCore = json['TotalCore'];
    transferFromAssetCode = json['TransferFromAssetCode'];
    transferFromEmpCode = json['TransferFromEmpCode'];
    unitAmount = json['UnitAmount'];
    upgradeToSoftware = json['UpgradeToSoftware'];
    upgradeToSoftwareVersion = json['UpgradeToSoftwareVersion'];
    version = json['Version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AcquisitionType'] = acquisitionType;
    data['AssetCode'] = assetCode;
    data['AssetType'] = assetType;
    data['Environment'] = environment;
    data['NewReplace'] = newReplace;
    data['NoOfProcessors'] = noOfProcessors;
    data['NoOfdays'] = noOfdays;
    data['OSVersion'] = oSVersion;
    data['OwnerEmpCode'] = ownerEmpCode;
    data['OwnerName'] = ownerName;
    data['PreviousInstalledSoftWare'] = previousInstalledSoftWare;
    data['PreviousInstalledSoftWareVersion'] = previousInstalledSoftWareVersion;
    data['ProjectName'] = projectName;
    data['Publisher'] = publisher;
    data['ServerHostName'] = serverHostName;
    data['ServerIPAddress'] = serverIPAddress;
    data['ServerLocation'] = serverLocation;
    data['ServerType'] = serverType;
    data['Software'] = software;
    data['SoftwareCategory'] = softwareCategory;
    data['SoftwareType'] = softwareType;
    data['TotalCore'] = totalCore;
    data['TransferFromAssetCode'] = transferFromAssetCode;
    data['TransferFromEmpCode'] = transferFromEmpCode;
    data['UnitAmount'] = unitAmount;
    data['UpgradeToSoftware'] = upgradeToSoftware;
    data['UpgradeToSoftwareVersion'] = upgradeToSoftwareVersion;
    data['Version'] = version;
    return data;
  }
}

class TemporaryLicense {
  String? endDate;
  String? startDate;

  TemporaryLicense({this.endDate, this.startDate});

  TemporaryLicense.fromJson(Map<String, dynamic> json) {
    endDate = json['EndDate'];
    startDate = json['StartDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EndDate'] = endDate;
    data['StartDate'] = startDate;
    return data;
  }
}
