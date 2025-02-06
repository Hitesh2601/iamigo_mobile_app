import 'dart:convert';

import 'package:push_notification/features/iCart/models/icart_approve_reject_response.dart';
import 'package:push_notification/features/iCart/models/icart_hardware_detail_response.dart';
import 'package:push_notification/utility/constants/icart_menu_list.dart';
import 'package:push_notification/utility/constants/session.dart';
import 'package:push_notification/utility/constants/url_configuration.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:push_notification/utility/network/http_client.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HardwareDetailProvider with ChangeNotifier {
  String? additionaInfo;

  ///********************************
  /// iCart Request Details API Call
  ///*********************************
  ICartHardwareDetailModel detailResponse = ICartHardwareDetailModel();
  RequestDetails requestDetails = RequestDetails();
  Future<ICartHardwareDetailModel> getRequestDetailsData(Object body) async {
    NetworkClientManager networkClientManager = NetworkClientManager();
    var response = await networkClientManager.post(
        '${URLConfiguration().icartBaseUrl}RequestDetail', body);
    ICartHardwareDetailModel res =
        ICartHardwareDetailModel.fromJson(json.decode(response.body));
    if (res.returnStatus == 2) {
      additionaInfo = res.addtionalInfo;
      setSelectedNumber(res.requestNo!);
      detailResponse = res;
      requestDetails = res.requestDetails!;
      setSelectedValue("Request Information");
    } else if (res.returnStatus == 4) {
      if (HelperFunctions.isNullorEmpty(res.responseMessage) &&
          res.responseMessage.toString().toLowerCase().contains("session")) {
        SessionManagement.expireUserSession();
      }
    } else {}
    notifyListeners();
    return res;
  }

  ///*******************************
  /// iCart Approve Request API Call
  ///*******************************
  Future<ICartApproveReject> iCartApproveRequest(Object body) async {
    ICartApproveReject res = ICartApproveReject();
    try {
      NetworkClientManager networkClientManager = NetworkClientManager();
      var response = await networkClientManager.post(
          '${URLConfiguration().icartBaseUrl}ApproveRequest', body);
      res = ICartApproveReject.fromJson(json.decode(response.body));
    } catch (e) {
      //HelperFunctions.showAlert("System Error", e.toString());
    }
    return res;

    // await Future.delayed(Duration(seconds: 3));
    // return ICartApproveReject(returnStatus: 2);
  }

  ///*******************************
  /// iCart Reject Request API Call
  ///*******************************
  Future<ICartApproveReject> iCartRejectRequest(Object body) async {
    ICartApproveReject res = ICartApproveReject();
    try {
      NetworkClientManager networkClientManager = NetworkClientManager();
      var response = await networkClientManager.post(
          '${URLConfiguration().icartBaseUrl}RejectRequest', body);
      res = ICartApproveReject.fromJson(json.decode(response.body));
    } catch (e) {
      // HelperFunctions.showAlert("System Error", e.toString());
    }
    return res;
    // await Future.delayed(Duration(seconds: 3));
    // return ICartApproveReject(returnStatus: 2);
  }

  late bool _isPositionEnd = false;
  bool get isPositionEnd => _isPositionEnd;
  void setPositionEnd(bool val) {
    _isPositionEnd = val;
    notifyListeners();
  }

  late String _selectedValue = "Request Information";
  String get selectedValue => _selectedValue;
  void setSelectedValue(String val) {
    _selectedValue = val;
    notifyListeners();
  }

  void resetOnPageLoad() {
    _isPositionEnd = false;
    _selectedValue = "Request Information";
    notifyListeners();
  }

  late String _selectedNumber = "";
  String get selectedNumber => _selectedNumber;
  void setSelectedNumber(String val) {
    _selectedNumber = val;
    notifyListeners();
  }

  List<DetailMenuItem> hwMenuList = [];
  getMenuList(String requestType, String newReplce) {
    List<DetailMenuItem> menuList = [];

    for (var element in ICartDetailMenus.icartMenuList) {
      switch (element.name) {
        case "Request Information":
          if (requestDetails.requestInfo != null) {
            menuList.add(element);
          }
          break;
        case "Employee Information":
          if (requestDetails.employeeInformation != null) {
            menuList.add(element);
          }
          break;
        case "Unit Details":
          if (requestDetails.unitDetails != null) {
            menuList.add(element);
          }

          break;
        case "Existing Asset Details":
          if (requestDetails.existingAssetDetails != null &&
              newReplce != "New") {
            menuList.add(element);
          }

          break;
        case "Checklist & Validation":
          if (requestDetails.checklistValidations != null) {
            menuList.add(element);
          }
          break;
        case "Delivery Details":
          if (requestDetails.deliveryDetails != null) {
            menuList.add(element);
          }
          break;
        case "PO, Insurance & Installation":
          if (requestDetails.poInsuranceInstallation != null &&
              requestType == "Approved") {
            menuList.add(element);
          }
          break;
        case "Invoicing Payment & FAR":
          if (requestDetails.invoicingPaymentFar != null &&
              requestType == "Approved") {
            menuList.add(element);
          }
          break;
        case "Request Reason":
          if (requestDetails.requestReason != null) {
            menuList.add(element);
          }
          break;
        case "Approver Details":
          if (requestDetails.approverDetail != null) {
            menuList.add(element);
          }
          break;
        case "Approver History":
          if (requestDetails.approverHistory != null) {
            menuList.add(element);
          }
          break;
        case "Query Feedback":
          if (requestDetails.queryFeedback != null) {
            menuList.add(element);
          }
          break;
      }
    }
    if (menuList.length > 7) {
      menuList.insert(
          7,
          DetailMenuItem(
              name: 'More',
              icon: FontAwesomeIcons.circleChevronDown,
              isSelected: false));
    }
    hwMenuList = menuList;
    return menuList;
  }
}
