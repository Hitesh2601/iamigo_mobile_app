class ICartLoginResponse {
  String? responseMessage;
  int? returnStatus;
  Data? data;

  ICartLoginResponse({this.responseMessage, this.returnStatus, this.data});

  ICartLoginResponse.fromJson(Map<String, dynamic> json) {
    responseMessage = json['ResponseMessage'];
    returnStatus = json['ReturnStatus'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ResponseMessage'] = responseMessage;
    data['ReturnStatus'] = returnStatus;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<String>? changeApproverReason;
  String? empName;
  List<ProfileDetail>? profileDetail;
  List<String>? userProfile;
  String? iCartToken;

  Data(
      {this.changeApproverReason,
      this.empName,
      this.profileDetail,
      this.userProfile,
      this.iCartToken});

  Data.fromJson(Map<String, dynamic> json) {
    changeApproverReason = json['ChangeApproverReason'].cast<String>();
    empName = json['EmpName'];
    if (json['ProfileDetail'] != null) {
      profileDetail = <ProfileDetail>[];
      json['ProfileDetail'].forEach((v) {
        profileDetail!.add(ProfileDetail.fromJson(v));
      });
    }
    userProfile = json['UserProfile'].cast<String>();
    iCartToken = json['iCartToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ChangeApproverReason'] = changeApproverReason;
    data['EmpName'] = empName;
    if (profileDetail != null) {
      data['ProfileDetail'] = profileDetail!.map((v) => v.toJson()).toList();
    }
    data['UserProfile'] = userProfile;
    data['iCartToken'] = iCartToken;
    return data;
  }
}

class ProfileDetail {
  Hardware? hardware;
  String? profile;
  Hardware? software;

  ProfileDetail({this.hardware, this.profile, this.software});

  ProfileDetail.fromJson(Map<String, dynamic> json) {
    hardware =
        json['Hardware'] != null ? Hardware.fromJson(json['Hardware']) : null;
    profile = json['Profile'];
    software =
        json['Software'] != null ? Hardware.fromJson(json['Software']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (hardware != null) {
      data['Hardware'] = hardware!.toJson();
    }
    data['Profile'] = profile;
    if (software != null) {
      data['Software'] = software!.toJson();
    }
    return data;
  }
}

class Hardware {
  bool? bulkApproval;
  bool? filter;
  bool? queryFeedback;
  bool? sendEmailNotification;

  Hardware(
      {this.bulkApproval,
      this.filter,
      this.queryFeedback,
      this.sendEmailNotification});

  Hardware.fromJson(Map<String, dynamic> json) {
    bulkApproval = json['BulkApproval'];
    filter = json['Filter'];
    queryFeedback = json['QueryFeedback'];
    sendEmailNotification = json['SendEmailNotification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['BulkApproval'] = bulkApproval;
    data['Filter'] = filter;
    data['QueryFeedback'] = queryFeedback;
    data['SendEmailNotification'] = sendEmailNotification;
    return data;
  }
}
