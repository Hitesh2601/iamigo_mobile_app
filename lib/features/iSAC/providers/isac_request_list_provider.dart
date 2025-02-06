import 'dart:async';
import 'dart:convert';
import 'package:push_notification/features/iSAC/models/isac_request_list_response.dart';
import 'package:push_notification/features/iSAC/models/isac_response.dart';
import 'package:push_notification/features/iSAC/models/vendorcode_req_list_response.dart';
import 'package:push_notification/features/iSAC/models/vendoronboarding_req_list_response.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:push_notification/utility/constants/url_configuration.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:push_notification/utility/mock_data/mock_isac_data.dart';
import 'package:push_notification/utility/network/http_client.dart';
import 'package:flutter/material.dart';

class ISACRequestListProvider with ChangeNotifier {
  //Stores actual display list
  List<ISACData> _displayList = [];
  List<ISACData> get displayList => _displayList;

  //Stores whole list
  List<ISACData> _actualList = [];
  List<ISACData> get actualList => _actualList;

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
      _displayList.clear();
      _actualList.clear();

      for (var element in resp.returnListData!) {
        _displayList.add(element);
        _actualList.add(element);
      }

      notifyListeners();

      return resp;
    }

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
    _displayList.clear();
    _actualList.clear();
    if (res.returnStatus == 2) {
      for (var element in res.returnListData!) {
        _displayList.add(element);
        _actualList.add(element);
      }
    } else {}
    notifyListeners();
    return res;
  }

  ///*******************************
  /// Search request list
  ///*******************************
  Timer? debouncer;

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(VoidCallback callback,
      {Duration duration = const Duration(milliseconds: 1000)}) {
    if (debouncer != null) {
      debouncer!.cancel();
    }
    debouncer = Timer(duration, callback);
  }

  onSearchTextChanged(String text) async => debounce(() async {
        try {
          var list;
          if (text.isEmpty) {
            list = _actualList.where((dt) {
              return true;
            }).toList();
          } else {
            list = _actualList.where((dt) {
              text = text.toLowerCase();
              return dt.ticketNumber.toString().toLowerCase().contains(text) ||
                  dt.empName.toString().toLowerCase().contains(text) ||
                  dt.empCode.toString().toLowerCase().contains(text) ||
                  dt.applicationName.toString().toLowerCase().contains(text) ||
                  dt.templateName.toString().toLowerCase().contains(text) ||
                  dt.typeOfRequest.toString().toLowerCase().contains(text) ||
                  dt.branchCode.toString().toLowerCase().contains(text);
            }).toList();
          }
          _displayList = list;
          notifyListeners();
        } catch (e) {
          HelperFunctions.showAlert("", e.toString());
        }
      });

  ///*****************************
  /// iSAC Vendor Onboarding Request List Api Call
  ///*****************************

  // List<RequestListDataVO> _vodataList = [];
  // List<RequestListDataVO> get myDataVOList => _vodataList;

  // ISACVendorOnboardingRequestListClass resVO =
  //     ISACVendorOnboardingRequestListClass();
  // Future<ISACVendorOnboardingRequestListClass> getvendoronboardRequestListData(
  //     Object body) async {
  //   NetworkClientManager networkClientManager = NetworkClientManager();
  //   var response = await networkClientManager.post(
  //       '${URLConfiguration().isacBaseUrl}getVendorOnboardingRequest', body);

  //   resVO = ISACVendorOnboardingRequestListClass.fromJson(
  //       json.decode(response.body));
  //   _vodataList.clear();
  //   myDataVOList.clear();
  //   if (resVO.returnStatus == 2) {
  //     _vodataList = resVO.returnListData!;
  //   } else {
  //     if (resVO.returnStatus == 1) {
  //       HelperFunctions.showAlert(
  //           "Error", "Error occurred while processing request.");
  //     } else {
  //       if ((resVO.returnStatus == 4)) {
  //         HelperFunctions.showAlert("AMIGO", resVO.responseMessage!);
  //       } else {
  //         HelperFunctions.showAlert("Error", "Oops! Something went wrong");
  //       }
  //     }
  //   }
  //   notifyListeners();
  //   return resVO;
  // }

  ///*****************************
  /// iSAC Vendor Code Request List Api Call
  ///*****************************

  // List<RequestListDataVC> _vcdataList = [];
  // List<RequestListDataVC> get myDataVCList => _vcdataList;
  // iSACVendorCodeRequestListClass resVC = iSACVendorCodeRequestListClass();
  // Future<iSACVendorCodeRequestListClass> getvendorcodeRequestListData(
  //     Object body) async {
  //   NetworkClientManager networkClientManager = NetworkClientManager();
  //   var response = await networkClientManager.post(
  //       '${URLConfiguration().isacBaseUrl}getVendorCodeRequest', body);

  //   resVC = iSACVendorCodeRequestListClass.fromJson(json.decode(response.body));

  //   if (resVC.returnStatus == 2) {
  //     _vcdataList = resVC.data!;
  //   } else {
  //     if (resVC.returnStatus == 1) {
  //       HelperFunctions.showAlert(
  //           "Error", "Error occurred while processing request.");
  //     } else {
  //       if ((resVC.returnStatus == 4)) {
  //         HelperFunctions.showAlert("AMIGO", resVC.responseMessage!);
  //       } else {
  //         HelperFunctions.showAlert("Error", "Oops! Something went wrong");
  //       }
  //     }
  //   }
  //   notifyListeners();
  //   return resVC;
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
    } else {}
    notifyListeners();
    return vendotAuthres;
  }

  ///*******************************
  /// iSAC Vendor code And Vendor Onboard Reject Request API Call
  ///*******************************
  // Future<ISACResponse> vendorRejectRequest(Object body) async {
  //   NetworkClientManager networkClientManager = NetworkClientManager();
  //   var response = await networkClientManager.post(
  //       '${URLConfiguration().isacBaseUrl}RejectRequest', body);
  //   ISACResponse vendotRejectres =
  //       ISACResponse.fromJson(json.decode(response.body));
  //   if (vendotRejectres.returnStatus == 2) {
  //     vendotRejectres;
  //   } else {
  //     if (vendotRejectres.returnStatus == 1) {
  //       HelperFunctions.showAlert(
  //           "Error", "Error occurred while processing request.");
  //     } else {
  //       if ((vendotRejectres.returnStatus == 4)) {
  //         HelperFunctions.showAlert("AMIGO", vendotRejectres.responseMessage!);
  //       } else {
  //         HelperFunctions.showAlert("Error", "Oops! Something went wrong");
  //       }
  //     }
  //   }
  //   notifyListeners();
  //   return vendotRejectres;
  // }
}
