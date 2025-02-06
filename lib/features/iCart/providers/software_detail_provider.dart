import 'dart:convert';

import 'package:push_notification/features/iCart/models/icart_approve_reject_response.dart';
import 'package:push_notification/features/iCart/models/icart_software_detail_response.dart';
import 'package:push_notification/utility/constants/icart_menu_list.dart';
import 'package:push_notification/utility/constants/session.dart';
import 'package:push_notification/utility/constants/url_configuration.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:push_notification/utility/network/http_client.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SoftwareDetailProvider with ChangeNotifier {
  ///********************************
  /// iCart Request Details API Call
  ///*********************************
  ICartSoftwareRequestDetail softwareDetailResponse =
      ICartSoftwareRequestDetail();
  SoftwareRequestDetails softwareRequestDetails = SoftwareRequestDetails();
  Future<ICartSoftwareRequestDetail> getSoftwareDetailsData(Object body) async {
    NetworkClientManager networkClientManager = NetworkClientManager();
    var response = await networkClientManager.post(
        '${URLConfiguration().icartBaseUrl}SoftwareRequestDetail', body);
    ICartSoftwareRequestDetail res =
        ICartSoftwareRequestDetail.fromJson(json.decode(response.body));
    setSelectedNumber(res.requestNo!);
    if (res.returnStatus == 2) {
      softwareDetailResponse = res;
      softwareRequestDetails = res.softwareRequestDetails!;
      showHideContent(softwareRequestDetails);
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
    // ICartApproveReject res = ICartApproveReject(returnStatus: 2);
    // await Future.delayed(Duration(seconds: 3));
    NetworkClientManager networkClientManager = NetworkClientManager();
    var response = await networkClientManager.post(
        '${URLConfiguration().icartBaseUrl}ApproveRequest', body);
    ICartApproveReject res =
        ICartApproveReject.fromJson(json.decode(response.body));
    return res;
  }

  ///*******************************
  /// iCart Reject Request API Call
  ///*******************************
  Future<ICartApproveReject> iCartRejectRequest(Object body) async {
    NetworkClientManager networkClientManager = NetworkClientManager();
    var response = await networkClientManager.post(
        '${URLConfiguration().icartBaseUrl}RejectRequest', body);
    ICartApproveReject res =
        ICartApproveReject.fromJson(json.decode(response.body));
    //  ICartApproveReject res = ICartApproveReject(returnStatus: 2);
    // await Future.delayed(Duration(seconds: 3));
    return res;
  }

  late bool _isPositionEnd = false;
  bool get isPositionEnd => _isPositionEnd;
  void setPositionEnd(bool val) {
    _isPositionEnd = val;
    notifyListeners();
  }

  late String _selectedValue = "Request";
  String get selectedValue => _selectedValue;
  void setSelectedValue(String val) {
    _selectedValue = val;
    notifyListeners();
  }

  void resetOnPageLoad() {
    _isPositionEnd = false;
    _selectedValue = "Request";
    notifyListeners();
  }

  List<DetailMenuItem> swMenuList = [];
  getMenuList() {
    List<DetailMenuItem> menuList = [];

    for (var element in ICartDetailMenus.icartSoftwareMenuList) {
      switch (element.name) {
        case "Request Information":
          if (softwareRequestDetails.softwareRequestInformation != null) {
            menuList.add(element);
          }
          break;
        case "Employee Information":
          if (softwareRequestDetails.softwareEmployeeInformation != null) {
            menuList.add(element);
          }
          break;
        case "Software Details":
          if (softwareRequestDetails.softwareUnitDetails != null) {
            menuList.add(element);
          }

          break;
        case "Asset Details":
          if (softwareRequestDetails.softwareExistingAssetDetails != null) {
            menuList.add(element);
          }

          break;
        case "Extension Request":
          if (softwareRequestDetails.extensionRequest != null) {
            print('softwareRequestDetails.extensionRequest');
            print(softwareRequestDetails.extensionRequest);
            menuList.add(element);
          }

          break;
        case "Request Details":
          if (softwareRequestDetails.softRequestDetails != null) {
            menuList.add(element);
          }

          break;
        case "Approval Period":
          if (softwareRequestDetails.softwareApproverPeriod != null) {
            menuList.add(element);
          }

          break;

        case "Temporary License":
          if (softwareRequestDetails.temporaryLicense != null) {
            menuList.add(element);
          }

          break;
        case "Approver Details":
          if (softwareRequestDetails.softwareApproverDetail != null) {
            menuList.add(element);
          }

          break;
        case "Approver History":
          if (softwareRequestDetails.approverHistory != null) {
            menuList.add(element);
          }

          break;
        case "Query Feedback":
          if (softwareRequestDetails.softwareQueryFeedback != null) {
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
    swMenuList = menuList;
    return menuList;
  }

  late String _selectedNumber = "";
  String get selectedNumber => _selectedNumber;
  void setSelectedNumber(String val) {
    _selectedNumber = val;
    notifyListeners();
  }

  bool isServerDataVisible = false;
  bool isSoftwareApprovalPeriodAccordianVisible = false;
  bool isTransferDataVisible = false;
  bool isUpgradeDataVisible = false;
  bool isUpgradeDataNotVisible = false;
  bool isExtensionRequestVisible = false;
  bool isInstallationDateVisible = false;
  bool isQueryFeedbackVisible = false;
  bool isTemporaryLicenseVisible = false;
  void showHideContent(SoftwareRequestDetails res) {
    try {
      if (res.softwareExistingAssetDetails!.assetType!.toUpperCase().trim() ==
          ("SERVER".toUpperCase().trim())) {
        isServerDataVisible = true;
      }
      if (res.softwareUnitDetails!.softwareCategory!.toUpperCase().trim() ==
          ("Authorized on Approval".toUpperCase().trim())) {
        isSoftwareApprovalPeriodAccordianVisible = true;
      }
      if (res.softwareUnitDetails!.newReplace!.toUpperCase().trim() ==
              ("Transfer".toUpperCase().trim()) &&
          res.softwareExistingAssetDetails!.assetType!.toUpperCase().trim() ==
              ("Laptop/PC".toUpperCase().trim())) {
        isTransferDataVisible = true;
      }
      if (res.softwareUnitDetails!.newReplace!.toUpperCase().trim() ==
              ("Upgrade".toUpperCase().trim()) &&
          res.softwareExistingAssetDetails!.assetType!.toUpperCase().trim() ==
              ("Laptop/PC".toUpperCase().trim())) {
        isUpgradeDataVisible = true;
        isUpgradeDataNotVisible = false;
      }
      if (res.softwareUnitDetails!.acquisitionType!.toUpperCase().trim() ==
              ("Temporary".toUpperCase().trim()) &&
          res.softwareExistingAssetDetails!.assetType!.toUpperCase().trim() ==
              ("Server".toUpperCase().trim())) {
        isExtensionRequestVisible = true;
      }
      if (!HelperFunctions.isNullorEmpty(
          res.softRequestDetails!.installationDate)) {
        isInstallationDateVisible = true;
      }
      if (res.softwareQueryFeedback != null) {
        isQueryFeedbackVisible = true;
      }
      if (res.softwareExistingAssetDetails!.assetType!.toUpperCase().trim() ==
                  ("Server".toUpperCase().trim()) &&
              res.softwareUnitDetails!.acquisitionType!.toUpperCase().trim() ==
                  ("Temporary".toUpperCase().trim()) &&
              res.softwareUnitDetails!.newReplace!.toUpperCase().trim() ==
                  ("New".toUpperCase().trim()) ||
          res.softwareExistingAssetDetails!.assetType!.toUpperCase().trim() ==
                  ("Server".toUpperCase().trim()) &&
              res.softwareUnitDetails!.acquisitionType!.toUpperCase().trim() ==
                  ("Temporary".toUpperCase().trim()) &&
              res.softwareUnitDetails!.newReplace!.toUpperCase().trim() ==
                  ("Uninstall".toUpperCase().trim()) ||
          res.softwareExistingAssetDetails!.assetType!.toUpperCase().trim() ==
                  ("Server".toUpperCase().trim()) &&
              res.softwareUnitDetails!.acquisitionType!.toUpperCase().trim() ==
                  ("Temporary".toUpperCase().trim()) &&
              res.softwareUnitDetails!.newReplace!.toUpperCase().trim() ==
                  ("Extension".toUpperCase().trim())) {
        isTemporaryLicenseVisible = true;
      }
    } catch (e) {}
  }
}
