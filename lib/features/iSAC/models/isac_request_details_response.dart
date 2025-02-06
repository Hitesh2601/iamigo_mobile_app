import 'package:push_notification/features/iSAC/models/isac_request_details_response.dart';

class ISACRequestDetailsClass {
  String? responseMessage;
  int? returnStatus;
  TicketData? ticketData;

  ISACRequestDetailsClass(
      {this.responseMessage, this.returnStatus, this.ticketData});

  ISACRequestDetailsClass.fromJson(Map<String, dynamic> json) {
    responseMessage = json['ResponseMessage'];
    returnStatus = json['ReturnStatus'];
    ticketData = json['TicketData'] != null
        ? TicketData.fromJson(json['TicketData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ResponseMessage'] = responseMessage;
    data['ReturnStatus'] = returnStatus;
    if (ticketData != null) {
      data['TicketData'] = ticketData!.toJson();
    }
    return data;
  }
}

class TicketData {
  int? accessType;
  String? actionBy;
  String? agency;
  String? alternateText;
  String? application;
  int? applicationID;
  String? bandName;
  String? branchCode;
  int? branchCodeID;
  int? businessApprEmpCode;
  List<BusinessApprList>? businessApprList;
  String? businessApproverName;
  int? cPAAgencyId;
  String? changeApprover;
  int? companyId;
  String? costCode;
  int? costCodeID;
  String? currentApprover;
  String? currentBranchCode;
  String? currentSystemTemplate;
  int? defaultPasswordid;
  int? duration;
  String? emailID;
  String? empName;
  String? fileUploadTempGuid;
  int? formID;
  int? functionApprEmpCode;
  bool? generatePassword;
  String? genericIDOwnerEmpCode;
  String? genericIDOwnerEmpName;
  int? hubId;
  String? hubName;
  String? hubNameRemove;
  int? hubRemoveId;
  int? identityStoreId;
  IdentityStoreMaster? identityStoreMaster;
  List<MstApplicationAttributesValuesList>? mstApplicationAttributesValuesList;
  List<ApplicationSpecificInfo>? applicationSpecificInfo;
  String? newGenericIDOwner;
  int? passwordLength;
  int? productCategoryId;
  String? productCategoryName;
  String? productCategoryNameRemove;
  int? productCategoryRemoveId;
  int? productId;
  String? productName;
  String? productNameRemove;
  int? productRemoveId;
  String? reasonDesc;
  String? reasonForChange;
  int? receipientID;
  String? regionBranchId;
  String? regionBranchIdRemove;
  String? regionBranchRemoveId;
  int? regionId;
  String? regionName;
  String? regionNameRemove;
  int? regionRemoveId;
  List<RejectReasonList>? rejectReasonList;
  String? remarks;
  String? requestEntryDate;
  int? requestID;
  int? requestStatusID;
  List<RequestTicketMISDetailsList>? requestTicketMISDetailsList;
  int? requestType;
  String? requestTypeValue;
  int? requestorID;
  String? showAuth;
  String? showiSacPword;
  String? staffCode;
  int? stateId;
  String? stateName;
  String? stateNameRemove;
  int? stateRemoveId;
  String? statusDesc;
  bool? supervisorOverRide;
  int? supervisorOverRideReasonID;
  List<RejectReasonList>? supervisorOverRideReasonList;
  String? supervisorOverRideReasonOther;
  int? systemTemplateID;
  String? systemUserID;
  String? systemUserIDDesc;
  String? ticketNumber;
  String? vBMSCode;
  String? vendorCode;
  String? vendorCompany;
  String? iSacPwordGenerated;
  bool? isCritical;
  bool? isGenericID;
  String? systemTemplate;

  TicketData(
      {this.accessType,
      this.actionBy,
      this.agency,
      this.alternateText,
      this.application,
      this.applicationID,
      this.bandName,
      this.branchCode,
      this.branchCodeID,
      this.businessApprEmpCode,
      this.businessApprList,
      this.businessApproverName,
      this.cPAAgencyId,
      this.changeApprover,
      this.companyId,
      this.costCode,
      this.costCodeID,
      this.currentApprover,
      this.currentBranchCode,
      this.currentSystemTemplate,
      this.defaultPasswordid,
      this.duration,
      this.emailID,
      this.empName,
      this.fileUploadTempGuid,
      this.formID,
      this.functionApprEmpCode,
      this.generatePassword,
      this.genericIDOwnerEmpCode,
      this.genericIDOwnerEmpName,
      this.hubId,
      this.hubName,
      this.hubNameRemove,
      this.hubRemoveId,
      this.identityStoreId,
      this.identityStoreMaster,
      this.mstApplicationAttributesValuesList,
      this.applicationSpecificInfo,
      this.newGenericIDOwner,
      this.passwordLength,
      this.productCategoryId,
      this.productCategoryName,
      this.productCategoryNameRemove,
      this.productCategoryRemoveId,
      this.productId,
      this.productName,
      this.productNameRemove,
      this.productRemoveId,
      this.reasonDesc,
      this.reasonForChange,
      this.receipientID,
      this.regionBranchId,
      this.regionBranchIdRemove,
      this.regionBranchRemoveId,
      this.regionId,
      this.regionName,
      this.regionNameRemove,
      this.regionRemoveId,
      this.rejectReasonList,
      this.remarks,
      this.requestEntryDate,
      this.requestID,
      this.requestStatusID,
      this.requestTicketMISDetailsList,
      this.requestType,
      this.requestTypeValue,
      this.requestorID,
      this.showAuth,
      this.showiSacPword,
      this.staffCode,
      this.stateId,
      this.stateName,
      this.stateNameRemove,
      this.stateRemoveId,
      this.statusDesc,
      this.supervisorOverRide,
      this.supervisorOverRideReasonID,
      this.supervisorOverRideReasonList,
      this.supervisorOverRideReasonOther,
      this.systemTemplateID,
      this.systemUserID,
      this.systemUserIDDesc,
      this.ticketNumber,
      this.vBMSCode,
      this.vendorCode,
      this.vendorCompany,
      this.iSacPwordGenerated,
      this.isCritical,
      this.isGenericID,
      this.systemTemplate});

  TicketData.fromJson(Map<String, dynamic> json) {
    accessType = json['AccessType'];
    actionBy = json['ActionBy'];
    agency = json['Agency'];
    alternateText = json['AlternateText'];
    application = json['Application'];
    applicationID = json['ApplicationID'];
    bandName = json['BandName'];
    branchCode = json['BranchCode'];
    branchCodeID = json['BranchCodeID'];
    businessApprEmpCode = json['BusinessApprEmpCode'];
    if (json['BusinessApprList'] != null) {
      businessApprList = <BusinessApprList>[];
      json['BusinessApprList'].forEach((v) {
        businessApprList!.add(BusinessApprList.fromJson(v));
      });
    }
    businessApproverName = json['BusinessApproverName'];
    cPAAgencyId = json['CPAAgencyId'];
    changeApprover = json['ChangeApprover'];
    companyId = json['CompanyId'];
    costCode = json['CostCode'];
    costCodeID = json['CostCodeID'];
    currentApprover = json['CurrentApprover'];
    currentBranchCode = json['CurrentBranchCode'];
    currentSystemTemplate = json['CurrentSystemTemplate'];
    defaultPasswordid = json['DefaultPasswordid'];
    duration = json['Duration'];
    emailID = json['EmailID'];
    empName = json['Emp_Name'];
    fileUploadTempGuid = json['FileUploadTempGuid'];
    formID = json['FormID'];
    functionApprEmpCode = json['FunctionApprEmpCode'];
    generatePassword = json['GeneratePassword'];
    genericIDOwnerEmpCode = json['GenericIDOwnerEmpCode'];
    genericIDOwnerEmpName = json['GenericIDOwnerEmpName'];
    hubId = json['HubId'];
    hubName = json['HubName'];
    hubNameRemove = json['HubNameRemove'];
    hubRemoveId = json['HubRemoveId'];
    identityStoreId = json['IdentityStoreId'];
    identityStoreMaster = json['IdentityStoreMaster'] != null
        ? IdentityStoreMaster.fromJson(json['IdentityStoreMaster'])
        : null;
    if (json['MstApplicationAttributesValuesList'] != null) {
      mstApplicationAttributesValuesList =
          <MstApplicationAttributesValuesList>[];
      json['MstApplicationAttributesValuesList'].forEach((v) {
        mstApplicationAttributesValuesList!
            .add(MstApplicationAttributesValuesList.fromJson(v));
      });
    }

    if (json['ApplicationSpecificInfo'] != null) {
      applicationSpecificInfo = <ApplicationSpecificInfo>[];
      json['ApplicationSpecificInfo'].forEach((v) {
        applicationSpecificInfo!.add(ApplicationSpecificInfo.fromJson(v));
      });
    }

    newGenericIDOwner = json['NewGenericIDOwner'];
    passwordLength = json['PasswordLength'];
    productCategoryId = json['ProductCategoryId'];
    productCategoryName = json['ProductCategoryName'];
    productCategoryNameRemove = json['ProductCategoryNameRemove'];
    productCategoryRemoveId = json['ProductCategoryRemoveId'];
    productId = json['ProductId'];
    productName = json['ProductName'];
    productNameRemove = json['ProductNameRemove'];
    productRemoveId = json['ProductRemoveId'];
    reasonDesc = json['ReasonDesc'];
    reasonForChange = json['ReasonForChange'];
    receipientID = json['ReceipientID'];
    regionBranchId = json['RegionBranchId'];
    regionBranchIdRemove = json['RegionBranchIdRemove'];
    regionBranchRemoveId = json['RegionBranchRemoveId'];
    regionId = json['RegionId'];
    regionName = json['RegionName'];
    regionNameRemove = json['RegionNameRemove'];
    regionRemoveId = json['RegionRemoveId'];
    if (json['RejectReasonList'] != null) {
      rejectReasonList = <RejectReasonList>[];
      json['RejectReasonList'].forEach((v) {
        rejectReasonList!.add(RejectReasonList.fromJson(v));
      });
    }
    remarks = json['Remarks'];
    requestEntryDate = json['RequestEntryDate'];
    requestID = json['RequestID'];
    requestStatusID = json['RequestStatusID'];
    if (json['RequestTicketMISDetailsList'] != null) {
      requestTicketMISDetailsList = <RequestTicketMISDetailsList>[];
      json['RequestTicketMISDetailsList'].forEach((v) {
        requestTicketMISDetailsList!
            .add(RequestTicketMISDetailsList.fromJson(v));
      });
    }
    requestType = json['RequestType'];
    requestTypeValue = json['RequestTypeValue'];
    requestorID = json['RequestorID'];
    showAuth = json['ShowAuth'];
    showiSacPword = json['ShowiSacPword'];
    staffCode = json['StaffCode'];
    stateId = json['StateId'];
    stateName = json['StateName'];
    stateNameRemove = json['StateNameRemove'];
    stateRemoveId = json['StateRemoveId'];
    statusDesc = json['Status_Desc'];
    supervisorOverRide = json['SupervisorOverRide'];
    supervisorOverRideReasonID = json['SupervisorOverRideReasonID'];
    if (json['SupervisorOverRideReasonList'] != null) {
      supervisorOverRideReasonList = <RejectReasonList>[];
      json['SupervisorOverRideReasonList'].forEach((v) {
        supervisorOverRideReasonList!.add(RejectReasonList.fromJson(v));
      });
    }
    supervisorOverRideReasonOther = json['SupervisorOverRideReasonOther'];
    systemTemplateID = json['SystemTemplateID'];
    systemUserID = json['SystemUserID'];
    systemUserIDDesc = json['SystemUserIDDesc'];
    ticketNumber = json['TicketNumber'];
    vBMSCode = json['VBMSCode'];
    vendorCode = json['VendorCode'];
    vendorCompany = json['VendorCompany'];
    iSacPwordGenerated = json['iSacPwordGenerated'];
    isCritical = json['isCritical'];
    isGenericID = json['isGenericID'];
    systemTemplate = json['systemTemplate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AccessType'] = accessType;
    data['ActionBy'] = actionBy;
    data['Agency'] = agency;
    data['AlternateText'] = alternateText;
    data['Application'] = application;
    data['ApplicationID'] = applicationID;
    data['BandName'] = bandName;
    data['BranchCode'] = branchCode;
    data['BranchCodeID'] = branchCodeID;
    data['BusinessApprEmpCode'] = businessApprEmpCode;
    if (businessApprList != null) {
      data['BusinessApprList'] =
          businessApprList!.map((v) => v.toJson()).toList();
    }
    data['BusinessApproverName'] = businessApproverName;
    data['CPAAgencyId'] = cPAAgencyId;
    data['ChangeApprover'] = changeApprover;
    data['CompanyId'] = companyId;
    data['CostCode'] = costCode;
    data['CostCodeID'] = costCodeID;
    data['CurrentApprover'] = currentApprover;
    data['CurrentBranchCode'] = currentBranchCode;
    data['CurrentSystemTemplate'] = currentSystemTemplate;
    data['DefaultPasswordid'] = defaultPasswordid;
    data['Duration'] = duration;
    data['EmailID'] = emailID;
    data['Emp_Name'] = empName;
    data['FileUploadTempGuid'] = fileUploadTempGuid;
    data['FormID'] = formID;
    data['FunctionApprEmpCode'] = functionApprEmpCode;
    data['GeneratePassword'] = generatePassword;
    data['GenericIDOwnerEmpCode'] = genericIDOwnerEmpCode;
    data['GenericIDOwnerEmpName'] = genericIDOwnerEmpName;
    data['HubId'] = hubId;
    data['HubName'] = hubName;
    data['HubNameRemove'] = hubNameRemove;
    data['HubRemoveId'] = hubRemoveId;
    data['IdentityStoreId'] = identityStoreId;
    if (identityStoreMaster != null) {
      data['IdentityStoreMaster'] = identityStoreMaster!.toJson();
    }
    if (mstApplicationAttributesValuesList != null) {
      data['MstApplicationAttributesValuesList'] =
          mstApplicationAttributesValuesList!.map((v) => v.toJson()).toList();
    }

    if (applicationSpecificInfo != null) {
      data['ApplicationSpecificInfo'] =
          applicationSpecificInfo!.map((v) => v.toJson()).toList();
    }
    data['NewGenericIDOwner'] = newGenericIDOwner;
    data['PasswordLength'] = passwordLength;
    data['ProductCategoryId'] = productCategoryId;
    data['ProductCategoryName'] = productCategoryName;
    data['ProductCategoryNameRemove'] = productCategoryNameRemove;
    data['ProductCategoryRemoveId'] = productCategoryRemoveId;
    data['ProductId'] = productId;
    data['ProductName'] = productName;
    data['ProductNameRemove'] = productNameRemove;
    data['ProductRemoveId'] = productRemoveId;
    data['ReasonDesc'] = reasonDesc;
    data['ReasonForChange'] = reasonForChange;
    data['ReceipientID'] = receipientID;
    data['RegionBranchId'] = regionBranchId;
    data['RegionBranchIdRemove'] = regionBranchIdRemove;
    data['RegionBranchRemoveId'] = regionBranchRemoveId;
    data['RegionId'] = regionId;
    data['RegionName'] = regionName;
    data['RegionNameRemove'] = regionNameRemove;
    data['RegionRemoveId'] = regionRemoveId;
    if (rejectReasonList != null) {
      data['RejectReasonList'] =
          rejectReasonList!.map((v) => v.toJson()).toList();
    }
    data['Remarks'] = remarks;
    data['RequestEntryDate'] = requestEntryDate;
    data['RequestID'] = requestID;
    data['RequestStatusID'] = requestStatusID;
    if (requestTicketMISDetailsList != null) {
      data['RequestTicketMISDetailsList'] =
          requestTicketMISDetailsList!.map((v) => v.toJson()).toList();
    }
    data['RequestType'] = requestType;
    data['RequestTypeValue'] = requestTypeValue;
    data['RequestorID'] = requestorID;
    data['ShowAuth'] = showAuth;
    data['ShowiSacPword'] = showiSacPword;
    data['StaffCode'] = staffCode;
    data['StateId'] = stateId;
    data['StateName'] = stateName;
    data['StateNameRemove'] = stateNameRemove;
    data['StateRemoveId'] = stateRemoveId;
    data['Status_Desc'] = statusDesc;
    data['SupervisorOverRide'] = supervisorOverRide;
    data['SupervisorOverRideReasonID'] = supervisorOverRideReasonID;
    if (supervisorOverRideReasonList != null) {
      data['SupervisorOverRideReasonList'] =
          supervisorOverRideReasonList!.map((v) => v.toJson()).toList();
    }
    data['SupervisorOverRideReasonOther'] = supervisorOverRideReasonOther;
    data['SystemTemplateID'] = systemTemplateID;
    data['SystemUserID'] = systemUserID;
    data['SystemUserIDDesc'] = systemUserIDDesc;
    data['TicketNumber'] = ticketNumber;
    data['VBMSCode'] = vBMSCode;
    data['VendorCode'] = vendorCode;
    data['VendorCompany'] = vendorCompany;
    data['iSacPwordGenerated'] = iSacPwordGenerated;
    data['isCritical'] = isCritical;
    data['isGenericID'] = isGenericID;
    data['systemTemplate'] = systemTemplate;
    return data;
  }
}

class BusinessApprList {
  int? empCode;
  String? empName;

  BusinessApprList({this.empCode, this.empName});

  BusinessApprList.fromJson(Map<String, dynamic> json) {
    empCode = json['EmpCode'];
    empName = json['EmpName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EmpCode'] = empCode;
    data['EmpName'] = empName;
    return data;
  }
}

class IdentityStoreMaster {
  int? band;
  String? bandName;
  String? branchCode;
  int? branchCodeID;
  String? branchName;
  int? companyID;
  String? companyName;
  int? companyTypeId;
  String? contactNumber;
  String? costCenterName;
  String? costCode;
  int? costCodeID;
  String? dOJ;
  String? emailId;
  String? empActiveDirectoryID;
  String? empCode;
  String? empName;
  int? identityFeedReferenceID;
  int? identityStoreID;
  String? lastWorkingDate;
  bool? statusID;
  String? supervisorEmpCode;
  String? systemUserIDDesc;
  String? vBMSCode;
  String? cCheckerId;
  String? cMakerId;
  String? dCheckerDate;
  String? dMakerDate;

  IdentityStoreMaster(
      {this.band,
      this.bandName,
      this.branchCode,
      this.branchCodeID,
      this.branchName,
      this.companyID,
      this.companyName,
      this.companyTypeId,
      this.contactNumber,
      this.costCenterName,
      this.costCode,
      this.costCodeID,
      this.dOJ,
      this.emailId,
      this.empActiveDirectoryID,
      this.empCode,
      this.empName,
      this.identityFeedReferenceID,
      this.identityStoreID,
      this.lastWorkingDate,
      this.statusID,
      this.supervisorEmpCode,
      this.systemUserIDDesc,
      this.vBMSCode,
      this.cCheckerId,
      this.cMakerId,
      this.dCheckerDate,
      this.dMakerDate});

  IdentityStoreMaster.fromJson(Map<String, dynamic> json) {
    band = json['Band'];
    bandName = json['BandName'];
    branchCode = json['BranchCode'];
    branchCodeID = json['BranchCodeID'];
    branchName = json['BranchName'];
    companyID = json['CompanyID'];
    companyName = json['CompanyName'];
    companyTypeId = json['CompanyTypeId'];
    contactNumber = json['ContactNumber'];
    costCenterName = json['CostCenterName'];
    costCode = json['CostCode'];
    costCodeID = json['CostCodeID'];
    dOJ = json['DOJ'];
    emailId = json['EmailId'];
    empActiveDirectoryID = json['EmpActiveDirectoryID'];
    empCode = json['EmpCode'];
    empName = json['Emp_Name'];
    identityFeedReferenceID = json['IdentityFeedReferenceID'];
    identityStoreID = json['IdentityStoreID'];
    lastWorkingDate = json['LastWorkingDate'];
    statusID = json['StatusID'];
    supervisorEmpCode = json['SupervisorEmpCode'];
    systemUserIDDesc = json['SystemUserIDDesc'];
    vBMSCode = json['VBMSCode'];
    cCheckerId = json['cCheckerId'];
    cMakerId = json['cMakerId'];
    dCheckerDate = json['dCheckerDate'];
    dMakerDate = json['dMakerDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Band'] = band;
    data['BandName'] = bandName;
    data['BranchCode'] = branchCode;
    data['BranchCodeID'] = branchCodeID;
    data['BranchName'] = branchName;
    data['CompanyID'] = companyID;
    data['CompanyName'] = companyName;
    data['CompanyTypeId'] = companyTypeId;
    data['ContactNumber'] = contactNumber;
    data['CostCenterName'] = costCenterName;
    data['CostCode'] = costCode;
    data['CostCodeID'] = costCodeID;
    data['DOJ'] = dOJ;
    data['EmailId'] = emailId;
    data['EmpActiveDirectoryID'] = empActiveDirectoryID;
    data['EmpCode'] = empCode;
    data['Emp_Name'] = empName;
    data['IdentityFeedReferenceID'] = identityFeedReferenceID;
    data['IdentityStoreID'] = identityStoreID;
    data['LastWorkingDate'] = lastWorkingDate;
    data['StatusID'] = statusID;
    data['SupervisorEmpCode'] = supervisorEmpCode;
    data['SystemUserIDDesc'] = systemUserIDDesc;
    data['VBMSCode'] = vBMSCode;
    data['cCheckerId'] = cCheckerId;
    data['cMakerId'] = cMakerId;
    data['dCheckerDate'] = dCheckerDate;
    data['dMakerDate'] = dMakerDate;
    return data;
  }
}

class MstApplicationAttributesValuesList {
  String? dataDisplayValue;
  String? dataMemberValue;
  int? fieldId;
  String? fieldName;
  int? fieldType;
  int? fieldValueId;

  MstApplicationAttributesValuesList(
      {this.dataDisplayValue,
      this.dataMemberValue,
      this.fieldId,
      this.fieldName,
      this.fieldType,
      this.fieldValueId});

  MstApplicationAttributesValuesList.fromJson(Map<String, dynamic> json) {
    dataDisplayValue = json['DataDisplayValue'];
    dataMemberValue = json['DataMemberValue'];
    fieldId = json['FieldId'];
    fieldName = json['FieldName'];
    fieldType = json['FieldType'];
    fieldValueId = json['FieldValueId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DataDisplayValue'] = dataDisplayValue;
    data['DataMemberValue'] = dataMemberValue;
    data['FieldId'] = fieldId;
    data['FieldName'] = fieldName;
    data['FieldType'] = fieldType;
    data['FieldValueId'] = fieldValueId;
    return data;
  }
}

class RejectReasonList {
  String? androidSource;
  String? categoryDesc;
  int? categoryId;
  String? iOSSource;
  bool? isEnable;
  String? reasonDesc;
  String? wINSource;
  bool? bAuthorised;
  String? cAuthStatus;
  String? cMakerId;
  String? cRejectRemarks;
  int? cid;
  String? dMakerDate;

  RejectReasonList(
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

  RejectReasonList.fromJson(Map<String, dynamic> json) {
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

class RequestTicketMISDetailsList {
  String? actionBy;
  String? requestEntryDate;
  String? statusDesc;
  String? actionAt;

  RequestTicketMISDetailsList(
      {this.actionBy,
      this.requestEntryDate,
      this.statusDesc,
      required this.actionAt});

  RequestTicketMISDetailsList.fromJson(Map<String, dynamic> json) {
    actionBy = json['ActionBy'];
    requestEntryDate = json['RequestEntryDate'];
    statusDesc = json['Status_Desc'];
    actionAt = json['ActionAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ActionBy'] = actionBy;
    data['RequestEntryDate'] = requestEntryDate;
    data['Status_Desc'] = statusDesc;
    data['ActionAt'] = actionAt;
    return data;
  }
}

class ApplicationSpecificInfo {
  String? key;
  String? value;

  ApplicationSpecificInfo({this.key, this.value});

  ApplicationSpecificInfo.fromJson(Map<String, dynamic> json) {
    key = json['Key'];
    value = json['Value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Key'] = key;
    data['Value'] = value;
    return data;
  }
}
