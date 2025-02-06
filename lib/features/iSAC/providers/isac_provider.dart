// ignore_for_file: non_constant_identifier_names, prefer_final_fields

import 'dart:convert';
import 'package:push_notification/features/iSAC/models/isac_dashboard_response.dart';
import 'package:push_notification/features/iSAC/models/isac_pending_count_model.dart';
import 'package:push_notification/features/iSAC/models/isac_request_details_response.dart';
import 'package:push_notification/features/iSAC/models/isac_request_list_response.dart';
import 'package:push_notification/features/iSAC/models/isac_response.dart';
import 'package:push_notification/features/iSAC/models/reject_reason.dart';
import 'package:push_notification/features/iSAC/models/vendor_req_details_response.dart';
import 'package:push_notification/features/iSAC/models/vendorcode_req_list_response.dart';
import 'package:push_notification/features/iSAC/models/vendoronboarding_req_list_response.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:push_notification/utility/constants/session.dart';
import 'package:push_notification/utility/constants/url_configuration.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:push_notification/utility/mock_data/mock_isac_data.dart';
import 'package:push_notification/utility/network/http_client.dart';
import 'package:flutter/material.dart';

class ISACProvider with ChangeNotifier {
  ///*****************************
  /// iSAC Dashboard Api Call
  ///*****************************
  IsacDashboardResponse dashboardData = IsacDashboardResponse();

  Future<IsacDashboardResponse> getDashboardData(Object body) async {
    if (!GlobalVariables.isAppservice) {
      dashboardData = IsacDashboardResponse.fromJson(
          json.decode(MockISACData().mockDashboard()));
      return dashboardData;
    }
    NetworkClientManager networkClientManager = NetworkClientManager();
    var response = await networkClientManager.post(
        '${URLConfiguration().isacBaseUrl}Dashboard', body);
    IsacDashboardResponse res =
        IsacDashboardResponse.fromJson(json.decode(response.body));
    if (res.returnStatus == 2) {
      dashboardData = res;
    } else if (res.returnStatus == 5) {
      SessionManagement.expireUserSession();
    } else {
      HelperFunctions.showAlert("AMIGO", res.responseMessage!);
    }
    notifyListeners();
    return dashboardData;
  }

  Future<IsacPendingCountModel> getPendingCount() async {
    NetworkClientManager networkClientManager = NetworkClientManager();
    var response = await networkClientManager.get(
        '${URLConfiguration().isacBaseUrl}iSacPendingCount/${GlobalVariables.userName}');
    IsacPendingCountModel res =
        IsacPendingCountModel.fromJson(json.decode(response.body));
    if (res.returnStatus != 2) {
      HelperFunctions.showAlert("AMIGO", res.responseMessage!);
    }
    notifyListeners();
    return res;
  }

  ///*****************************
  /// iSAC Supervisor Pending Request List Api Call
  ///*****************************
  ISACRequestListResponse res = ISACRequestListResponse();
  List<ISACData> _dataList = [];
  List<ISACData> get myDataList => _dataList;
  Future<ISACRequestListResponse> getSPRequestListData(Object body) async {
    if (!GlobalVariables.isAppservice) {
      ISACRequestListResponse resp = ISACRequestListResponse.fromJson(
          json.decode(MockISACData().mockRequestList()));
      _dataList = res.returnListData!;
      return resp;
    } else {
      NetworkClientManager networkClientManager = NetworkClientManager();
      if (GlobalVariables.selectedRole == "Supervisor" &&
          GlobalVariables.selectedStatus == "Pending") {
        var response = await networkClientManager.post(
            '${URLConfiguration().isacBaseUrl}getSupervisorPendingRequests',
            body);
        res = ISACRequestListResponse.fromJson(json.decode(response.body));
      }
      if (GlobalVariables.selectedRole == "Supervisor" &&
          GlobalVariables.selectedStatus == "Approved") {
        var response = await networkClientManager.post(
            '${URLConfiguration().isacBaseUrl}getSupervisorApprovedRequests',
            body);
        res = ISACRequestListResponse.fromJson(json.decode(response.body));
      }
      if (GlobalVariables.selectedRole == "Supervisor" &&
          GlobalVariables.selectedStatus == "Rejected") {
        var response = await networkClientManager.post(
            '${URLConfiguration().isacBaseUrl}getSupervisorRejectedRequests',
            body);
        res = ISACRequestListResponse.fromJson(json.decode(response.body));
      }

      if (GlobalVariables.selectedRole == "Business Approver" &&
          GlobalVariables.selectedStatus == "Pending") {
        var response = await networkClientManager.post(
            '${URLConfiguration().isacBaseUrl}getBusinessOwnerPendingRequests',
            body);
        res = ISACRequestListResponse.fromJson(json.decode(response.body));
      }
      if (GlobalVariables.selectedRole == "Business Approver" &&
          GlobalVariables.selectedStatus == "Approved") {
        var response = await networkClientManager.post(
            '${URLConfiguration().isacBaseUrl}getBusinessOwnerApprovedRequests',
            body);
        res = ISACRequestListResponse.fromJson(json.decode(response.body));
      }
      if (GlobalVariables.selectedRole == "Business Approver" &&
          GlobalVariables.selectedStatus == "Rejected") {
        var response = await networkClientManager.post(
            '${URLConfiguration().isacBaseUrl}getBusinessOwnerRejecteddRequests',
            body);
        res = ISACRequestListResponse.fromJson(json.decode(response.body));
      }

      if (GlobalVariables.selectedRole == "Generic ID Owner" &&
          GlobalVariables.selectedStatus == "Pending") {
        var response = await networkClientManager.post(
            '${URLConfiguration().isacBaseUrl}getGenericOwnerPendingRequests',
            body);
        res = ISACRequestListResponse.fromJson(json.decode(response.body));
      }
      if (GlobalVariables.selectedRole == "Generic ID Owner" &&
          GlobalVariables.selectedStatus == "Approved") {
        var response = await networkClientManager.post(
            '${URLConfiguration().isacBaseUrl}getGenericOwnerApprovedRequests',
            body);
        res = ISACRequestListResponse.fromJson(json.decode(response.body));
      }
      if (GlobalVariables.selectedRole == "Generic ID Owner" &&
          GlobalVariables.selectedStatus == "Rejected") {
        var response = await networkClientManager.post(
            '${URLConfiguration().isacBaseUrl}getGenericOwnerRejecteddRequests',
            body);
        res = ISACRequestListResponse.fromJson(json.decode(response.body));
      }
      _dataList.clear();
      myDataList.clear();
      if (res.returnStatus == 2) {
        _dataList = res.returnListData!;
      } else if (res.returnStatus == 5) {
        SessionManagement.expireUserSession();
      } else {}
      notifyListeners();
      return res;
    }
  }

  ///*****************************
  /// iSAC Request Details Api Call
  ///*****************************
  ISACRequestDetailsClass detailres = ISACRequestDetailsClass();
  TicketData _detaildataList = TicketData();
  TicketData get myDetailsDataList => _detaildataList;
  Future<ISACRequestDetailsClass> getRequestListDetailsData(Object body) async {
    if (!GlobalVariables.isAppservice) {
      detailres = ISACRequestDetailsClass.fromJson(
          json.decode(MockISACData().mockRequestDetail()));
      _detaildataList = detailres.ticketData as TicketData;
      return detailres;
    }
    NetworkClientManager networkClientManager = NetworkClientManager();
    var response = await networkClientManager.post(
        '${URLConfiguration().isacBaseUrl}GetRequestDetails', body);
    detailres = ISACRequestDetailsClass.fromJson(json.decode(response.body));
    if (detailres.returnStatus == 2) {
      _detaildataList = detailres.ticketData as TicketData;
      setSelectedNumber(_detaildataList.ticketNumber.toString());
    } else if (detailres.returnStatus == 5) {
      SessionManagement.expireUserSession();
    } else {}
    notifyListeners();
    return detailres;
  }

  ///*****************************
  /// iSAC New Request Details Api Call
  ///*****************************
  ISACRequestDetailsClass _isacdetailres = ISACRequestDetailsClass();
  ISACRequestDetailsClass get isacdetailres => _isacdetailres;
  TicketData _isacdetaildataList = TicketData();
  TicketData get isacDetailsDataList => _detaildataList;
  Future<ISACRequestDetailsClass> getiSACRequestListDetailsData(
      Object body) async {
    if (!GlobalVariables.isAppservice) {
      _isacdetailres = ISACRequestDetailsClass.fromJson(
          json.decode(MockISACData().mockRequestDetail()));
      _detaildataList = isacdetailres.ticketData as TicketData;
      return isacdetailres;
    }
    NetworkClientManager networkClientManager = NetworkClientManager();
    var response = await networkClientManager.post(
        '${URLConfiguration().isacBaseUrl}iSacRequestDetails', body);
    _isacdetailres =
        ISACRequestDetailsClass.fromJson(json.decode(response.body));
    if (_isacdetailres.returnStatus == 2) {
      _detaildataList = _isacdetailres.ticketData as TicketData;
      setSelectedNumber(_detaildataList.ticketNumber.toString());
    } else if (_isacdetailres.returnStatus == 5) {
      SessionManagement.expireUserSession();
    } else {}
    notifyListeners();
    return _isacdetailres;
  }

  late String _selectedNumber = "";
  String get selectedNumber => _selectedNumber;
  void setSelectedNumber(String val) {
    _selectedNumber = val;
    notifyListeners();
  }

  ///*****************************
  /// iSAC Vendor Onboarding Request List Api Call
  ///*****************************

  List<RequestListDataVO> _vodataList = [];
  List<RequestListDataVO> get myDataVOList => _vodataList;

  ISACVendorOnboardingRequestListClass resVO =
      ISACVendorOnboardingRequestListClass();
  Future<ISACVendorOnboardingRequestListClass> getvendoronboardRequestListData(
      Object body) async {
    NetworkClientManager networkClientManager = NetworkClientManager();
    var response = await networkClientManager.post(
        '${URLConfiguration().isacBaseUrl}getVendorOnboardingRequest', body);

    resVO = ISACVendorOnboardingRequestListClass.fromJson(
        json.decode(response.body));
    _vodataList.clear();
    myDataVOList.clear();
    if (resVO.returnStatus == 2) {
      _vodataList = resVO.returnListData!;
    } else if (resVO.returnStatus == 5) {
      SessionManagement.expireUserSession();
    } else {}
    notifyListeners();
    return resVO;
  }

  ///*****************************
  /// iSAC Vendor Onboarding Request Details List Api Call
  ///*****************************
  List<DetailData> _vendordataList = [];
  List<DetailData> get myDataVendorList => _vendordataList;

  ISACVendorRequestDetailModel _vendorRequestModel =
      ISACVendorRequestDetailModel();
  ISACVendorRequestDetailModel get vendorRequestModel => _vendorRequestModel;
  Future<ISACVendorRequestDetailModel> GetVendorThirdPartyRequestDetails(
      Object body) async {
    NetworkClientManager networkClientManager = NetworkClientManager();
    var response = await networkClientManager.post(
        '${URLConfiguration().isacBaseUrl}GetVendorThirdPartyRequestDetails_NewMobile',
        body);

    _vendorRequestModel =
        ISACVendorRequestDetailModel.fromJson(json.decode(response.body));

    if (_vendorRequestModel.returnStatus == 2) {
      _vendordataList = _vendorRequestModel.detailData!;
      setSelectedNumber(_vendorRequestModel.ticketNumber.toString());
    } else {
      if (_vendorRequestModel.returnStatus == 5) {
        SessionManagement.expireUserSession();
      } else {}
    }
    notifyListeners();
    return _vendorRequestModel;
  }

  ///*****************************
  /// iSAC Vendor Code Request List Api Call
  ///*****************************

  List<RequestListDataVC> _vcdataList = [];
  List<RequestListDataVC> get myDataVCList => _vcdataList;
  iSACVendorCodeRequestListClass resVC = iSACVendorCodeRequestListClass();
  Future<iSACVendorCodeRequestListClass> getvendorcodeRequestListData(
      Object body) async {
    NetworkClientManager networkClientManager = NetworkClientManager();
    var response = await networkClientManager.post(
        '${URLConfiguration().isacBaseUrl}getVendorCodeRequest', body);

    resVC = iSACVendorCodeRequestListClass.fromJson(json.decode(response.body));

    if (resVC.returnStatus == 2) {
      _vcdataList = resVC.data!;
    } else if (resVC.returnStatus == 5) {
      SessionManagement.expireUserSession();
    } else {}
    notifyListeners();
    return resVC;
  }

  ///*******************************
  /// iSAC  Reject Request API Call
  ///*******************************
  // Future<ISACResponse> requestAuthReject(Object body) async {
  //   NetworkClientManager networkClientManager = NetworkClientManager();
  //   var response = await networkClientManager.post(
  //       '${URLConfiguration().isacBaseUrl}RequestAuthReject', body);
  //   ISACResponse res = ISACResponse.fromJson(json.decode(response.body));
  //   if (res.returnStatus == 2) {
  //     res;
  //   } else {}
  //   notifyListeners();
  //   return res;
  // }
  ///*******************************
  /// iSAC Approve Request API Call
  ///*******************************
  Future<ISACResponse> isacApproveRejectRequest(Object body) async {
    // await Future.delayed(Duration(seconds: 2));
    // return ISACResponse(returnStatus: 2, responseMessage: "");
    NetworkClientManager networkClientManager = NetworkClientManager();
    var response = await networkClientManager.post(
        '${URLConfiguration().isacBaseUrl}RequestAuthReject', body);
    ISACResponse AuthRejectres =
        ISACResponse.fromJson(json.decode(response.body));
    if (AuthRejectres.returnStatus == 2) {
      AuthRejectres;
    } else if (AuthRejectres.returnStatus == 5) {
      SessionManagement.expireUserSession();
    } else {}
    notifyListeners();
    return AuthRejectres;
  }

  ///*******************************
  /// iSAC Vendor code And Vendor Onboard Auth Request API Call
  ///*******************************
  Future<ISACResponse> vendorAuthRequest(Object body) async {
    // await Future.delayed(Duration(seconds: 2));
    // return ISACResponse(returnStatus: 2, responseMessage: "");
    NetworkClientManager networkClientManager = NetworkClientManager();
    var response = await networkClientManager.post(
        '${URLConfiguration().isacBaseUrl}AuthorizeRequest', body);
    ISACResponse vendotAuthres =
        ISACResponse.fromJson(json.decode(response.body));
    if (vendotAuthres.returnStatus == 2) {
      vendotAuthres;
    } else {
      if (vendotAuthres.returnStatus == 5) {
        SessionManagement.expireUserSession();
      } else {}
    }
    notifyListeners();
    return vendotAuthres;
  }

  ///*******************************
  /// iSAC Vendor code And Vendor Onboard Reject Request API Call
  ///*******************************
  Future<ISACResponse> vendorRejectRequest(Object body) async {
    NetworkClientManager networkClientManager = NetworkClientManager();
    var response = await networkClientManager.post(
        '${URLConfiguration().isacBaseUrl}RejectRequest', body);
    ISACResponse vendotRejectres =
        ISACResponse.fromJson(json.decode(response.body));
    if (vendotRejectres.returnStatus == 2) {
      vendotRejectres;
    } else if (vendotRejectres.returnStatus == 5) {
      SessionManagement.expireUserSession();
    } else {}
    notifyListeners();
    return vendotRejectres;
  }
}

class ISACRejectListProvider with ChangeNotifier {
  ///*******************************
  /// iSAC Reject Reason Request API Call
  ///*******************************
  List<ReturnReasonData> _rejectdata = [];
  List<ReturnReasonData> get rejectdata => _rejectdata;
  Future<RejectReason> isacRejectReasonRequest(Object body) async {
    if (!GlobalVariables.isAppservice) {
      RejectReason Rejectres =
          RejectReason.fromJson(json.decode(MockISACData().mockRejectReason()));
      _rejectdata = Rejectres.returnReasonData!;
      selectOption(null);
      notifyListeners();
      return Rejectres;
    }
    NetworkClientManager networkClientManager = NetworkClientManager();
    var response = await networkClientManager.post(
        '${URLConfiguration().isacBaseUrl}GetRejectReason', body);
    RejectReason Rejectres = RejectReason.fromJson(json.decode(response.body));
    if (Rejectres.returnStatus == 2) {
      _rejectdata = Rejectres.returnReasonData!;
      GlobalVariables.dataReasonItem = _rejectdata;
    } else if (Rejectres.returnStatus == 5) {
      SessionManagement.expireUserSession();
    } else {}
    selectOption(null);
    notifyListeners();
    return Rejectres;
  }

  int? _selectedOption;
  int? get selectedOption => _selectedOption;
  void selectOption(int? index) {
    if (_selectedOption == index) {
      _selectedOption = null;
    } else {
      _selectedOption = index;
    }
    notifyListeners();
  }

  void clearSelection() {
    selectOption(null);
  }

  List<ReturnReasonData> _reasonList = [];
  List<ReturnReasonData> get reasonList => _reasonList;
  void setReasonList(List<ReturnReasonData>? list) {
    if (list == null) {
      _reasonList = [];
    } else {
      _reasonList = list;
    }
    notifyListeners();
  }

  List<ReturnReasonData> dataReasonItem = [];
}

class SelectedValueNotifier extends ChangeNotifier {
  String _selectedValue = 'Info';
  bool _infoVisible = true;
  bool _auditVisible = false;

  String get selectedValue => _selectedValue;
  bool get infoVisible => _infoVisible;
  bool get auditVisible => _auditVisible;

  void setSelectedValue(String value) {
    _selectedValue = value;
    _infoVisible = _selectedValue == 'Info';
    _auditVisible = _selectedValue == 'Audit';
    notifyListeners();
  }

  double _scrollHeight = 324;
  double get scrollHeight => _scrollHeight;

  void setHeight(double newHeight) {
    _scrollHeight = newHeight;
    notifyListeners();
  }
}
