// ignore_for_file: prefer_collection_literals, non_constant_identifier_names

class ISACVendorRequestDetailModel {
  List<AuditTrail>? auditTrail;
  List<DetailData>? detailData;
  String? responseMessage;
  int? returnStatus;
  String? ticketNumber;
  List<ProprietorPANDetail>? proprietorPANDetail;
  List<VendorHDFCContactList>? vendorHDFCContactList;

  ISACVendorRequestDetailModel(
      {this.auditTrail,
      this.detailData,
      this.responseMessage,
      this.returnStatus,
      this.ticketNumber,
      this.proprietorPANDetail,
      this.vendorHDFCContactList});

  ISACVendorRequestDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['AuditTrail'] != null) {
      auditTrail = <AuditTrail>[];
      json['AuditTrail'].forEach((v) {
        auditTrail!.add(AuditTrail.fromJson(v));
      });
    }
    if (json['DetailData'] != null) {
      detailData = <DetailData>[];
      json['DetailData'].forEach((v) {
        detailData!.add(DetailData.fromJson(v));
      });
    }
    if (json['ProprietorPartnerDirectorPANDetail'] != null) {
      proprietorPANDetail = <ProprietorPANDetail>[];
      json['ProprietorPartnerDirectorPANDetail'].forEach((v) {
        proprietorPANDetail!.add(ProprietorPANDetail.fromJson(v));
      });
    }
    if (json['VendorHDFCContactList'] != null) {
      vendorHDFCContactList = <VendorHDFCContactList>[];
      json['VendorHDFCContactList'].forEach((v) {
        vendorHDFCContactList!.add(VendorHDFCContactList.fromJson(v));
      });
    }

    responseMessage = json['ResponseMessage'];
    returnStatus = json['ReturnStatus'];
    ticketNumber = json['TicketNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (auditTrail != null) {
      data['AuditTrail'] = auditTrail!.map((v) => v.toJson()).toList();
    }
    if (detailData != null) {
      data['DetailData'] = detailData!.map((v) => v.toJson()).toList();
    }

    data['ResponseMessage'] = responseMessage;
    data['ReturnStatus'] = returnStatus;
    data['TicketNumber'] = ticketNumber;

    if (this.proprietorPANDetail != null) {
      data['ProprietorPartnerDirectorPANDetail'] =
          this.proprietorPANDetail!.map((v) => v.toJson()).toList();
    }
    data['ProprietorPartnerDirectorPANDetail'] = this.proprietorPANDetail;

    if (this.vendorHDFCContactList != null) {
      data['VendorHDFCContactList'] =
          this.vendorHDFCContactList!.map((v) => v.toJson()).toList();
    }
    data['VendorHDFCContactList'] = this.vendorHDFCContactList;

    return data;
  }
}

class AuditTrail {
  String? stage;
  String? actionBy;
  String? actionDate;

  AuditTrail({this.stage, this.actionBy, this.actionDate});

  AuditTrail.fromJson(Map<String, dynamic> json) {
    stage = json['Stage'];
    actionBy = json['ActionBy'];
    actionDate = json['ActionDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Stage'] = stage;
    data['ActionBy'] = actionBy;
    data['ActionDate'] = actionDate;
    return data;
  }
}

class DetailData {
  String? key;
  String? value;

  DetailData({this.key, this.value});

  DetailData.fromJson(Map<String, dynamic> json) {
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

class ProprietorPANDetail {
  String? Address;
  String? CIN;
  String? ContactNo;
  String? DIN;
  String? DOB;
  String? EmailId;
  String? Name;
  String? PANNumber;
  String? PANStatus;
  String? PANseedingStatus;
  String? PassportNumber;
  String? ResidentialStatus;
  String? PropNameStatus;
  String? PropPanDOBStatus;

  ProprietorPANDetail(
      {this.Address,
      this.CIN,
      this.ContactNo,
      this.DIN,
      this.DOB,
      this.EmailId,
      this.Name,
      this.PANNumber,
      this.PANStatus,
      this.PANseedingStatus,
      this.PassportNumber,
      this.ResidentialStatus,
      this.PropNameStatus,
      this.PropPanDOBStatus});

  ProprietorPANDetail.fromJson(Map<String, dynamic> json) {
    Address = json['Address'];
    CIN = json['CIN'];
    ContactNo = json['ContactNo'];
    DIN = json['DIN'];
    DOB = json['DOB'];
    EmailId = json['EmailId'];
    Name = json['Name'];
    PANNumber = json['PANNumber'];
    PANStatus = json['PANStatus'];
    PANseedingStatus = json['PANseedingStatus'];
    PassportNumber = json['PassportNumber'];
    ResidentialStatus = json['ResidentialStatus'];
    PropNameStatus = json['PropNameStatus'];
    PropPanDOBStatus = json['PropPanDOBStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Address'] = Address;
    data['CIN'] = CIN;
    data['ContactNo'] = ContactNo;
    data['DIN'] = DIN;
    data['DOB'] = DOB;
    data['EmailId'] = EmailId;
    data['Name'] = Name;
    data['PANNumber'] = PANNumber;
    data['PANStatus'] = PANStatus;
    data['PANseedingStatus'] = PANseedingStatus;
    data['PassportNumber'] = PassportNumber;
    data['ResidentialStatus'] = ResidentialStatus;
    data['PropNameStatus'] = PropNameStatus;
    data['PropPanDOBStatus'] = PropPanDOBStatus;

    return data;
  }
}

class VendorHDFCContactList {
  String? EmailID;
  String? StaffADid;
  String? StaffName;
  String? StaffPhone;

  VendorHDFCContactList({
    this.EmailID,
    this.StaffADid,
    this.StaffName,
    this.StaffPhone,
  });

  VendorHDFCContactList.fromJson(Map<String, dynamic> json) {
    EmailID = json['EmailID'];
    StaffADid = json['StaffADid'];
    StaffName = json['StaffName'];
    StaffPhone = json['StaffPhone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['EmailID'] = EmailID;
    data['StaffADid'] = StaffADid;
    data['StaffName'] = StaffName;
    data['StaffPhone'] = StaffPhone;

    return data;
  }
}
