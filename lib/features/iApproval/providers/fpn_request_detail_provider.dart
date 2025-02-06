import 'dart:convert';
import 'package:push_notification/features/iApproval/models/fpn_request_details_response.dart';
import 'package:push_notification/features/iApproval/models/fpn_response.dart';
import 'package:push_notification/utility/constants/fpn_menu_list.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:push_notification/utility/constants/icart_menu_list.dart';
import 'package:push_notification/utility/constants/session.dart';
import 'package:push_notification/utility/constants/url_configuration.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:push_notification/utility/mock_data/mock_fpn_data.dart';
import 'package:push_notification/utility/network/http_client.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FPNDetailProvider with ChangeNotifier {
  ///********************************
  /// FPN Request Details API Call
  ///*********************************

  bool isLoaded = false;
  bool isPPMProjectIDVisible = false;
  bool isAMCVisible = false;
  bool isAMCRemarkVisible = false;
  bool isValidJustificationVisible = false;
  bool isJustificationVisible = false;

  bool isRFPVisible = false;
  bool isCabChangesVisible = false;
  bool isRefNoVisible = false;
  bool isTentativeDateVisible = false;
  bool isSupplementaryFPNVisible = false;
  bool isAdditionalFPNVisible = false;
  FPNDetailResponse fpnDetailResponse = FPNDetailResponse(
      fpnNo: "", requestDetails: null, responseMessage: "", returnStatus: 0);
  Future<FPNDetailResponse> getRequestDetailsData(Object body) async {
    try {
      if (!GlobalVariables.isAppservice) {
        fpnDetailResponse = FPNDetailResponse.fromJson(
            json.decode(MockFPNData().mockRequestDetail()));
        setSelectedNumber(fpnDetailResponse.fpnNo!);
        setSelectedValue("Project");
        showHideContent(fpnDetailResponse);
        isLoaded = true;
      }
      NetworkClientManager networkClientManager = NetworkClientManager();
      var response = await networkClientManager.post(
          '${URLConfiguration().fpnBaseUrl}RequestDetail', body);
      FPNDetailResponse res =
          FPNDetailResponse.fromJson(json.decode(response.body));
      if (res.returnStatus == 2) {
        setSelectedNumber(res.fpnNo!);
        setSelectedValue("Project");
        fpnDetailResponse = res;
        isLoaded = true;
        showHideContent(res);
      } else if (res.returnStatus == 4) {
        SessionManagement.expireUserSession();
      }
      notifyListeners();
    } catch (e) {
      //HelperFunctions.showAlert("System Error", e.toString());
    }
    return fpnDetailResponse;
  }

  void showHideContent(FPNDetailResponse res) {
    try {
      if (res.requestDetails!.caseDetails!.ariba == 'Yes') {
        isRFPVisible = true;
        isValidJustificationVisible = false;
        isJustificationVisible = false;
      } else if (res.requestDetails!.caseDetails!.ariba == 'No') {
        isRFPVisible = false;
        isValidJustificationVisible = true;
        isJustificationVisible = false;
      } else if (res.requestDetails!.caseDetails!.ariba == 'Not Applicable') {
        isRFPVisible = false;
        isValidJustificationVisible = false;
        isJustificationVisible = true;
      } else {
        isRFPVisible = false;
        isValidJustificationVisible = false;
        isJustificationVisible = false;
      }

      if (res.requestDetails!.caseDetails!.supplementaryFpn ==
          'Supplementary') {
        isSupplementaryFPNVisible = true;
        isAdditionalFPNVisible = false;
      } else if (res.requestDetails!.caseDetails!.supplementaryFpn ==
          'Additional') {
        isSupplementaryFPNVisible = true;
        isAdditionalFPNVisible = true;
      } else {
        isSupplementaryFPNVisible = true;
        isAdditionalFPNVisible = false;
      }

      if (res.requestDetails!.caseDetails!.pnsiChange == 'Yes') {
        isCabChangesVisible = true;
        if (res.requestDetails!.caseDetails!.cabChangesApproved == 'Yes') {
          isRefNoVisible = true;
        } else {
          isTentativeDateVisible = true;
        }
      }

      if (res.requestDetails!.projectDetails.fpnSubCategory == 'AMC') {
        isAMCVisible = true;
        if (res.requestDetails!.projectDetails.isHardwareAmcvAlidated == "No") {
          isAMCRemarkVisible = true;
        }
      }

      if (res.requestDetails!.projectDetails.nsiProject == "Yes") {
        isPPMProjectIDVisible = true;
      }
    } catch (e) {
      // HelperFunctions.showAlert("System Error", e.toString());
    }
  }

  late bool _isPositionEnd = false;
  bool get isPositionEnd => _isPositionEnd;
  void setPositionEnd(bool val) {
    _isPositionEnd = val;
    notifyListeners();
  }

  late String _selectedValue = "Project";
  String get selectedValue => _selectedValue;
  void setSelectedValue(String val) {
    _selectedValue = val;
    notifyListeners();
  }

  late String _selectedNumber = "";
  String get selectedNumber => _selectedNumber;
  void setSelectedNumber(String val) {
    _selectedNumber = val;
    notifyListeners();
  }

  ///*******************************
  /// FPN Approve Request API Call
  ///*******************************
  Future<FpnResponse> fpnApproveRequest(Object body) async {
    FpnResponse res = FpnResponse(responseMessage: "", returnStatus: 0);
    try {
      NetworkClientManager networkClientManager = NetworkClientManager();
      var response = await networkClientManager.post(
          '${URLConfiguration().fpnBaseUrl}FPNApproveRequest', body);
      res = FpnResponse.fromJson(json.decode(response.body));
      if (res.returnStatus == 2) {
        res;
      } else if (res.returnStatus == 4) {
        SessionManagement.expireUserSession();
      } else {}
    } catch (e) {
      // HelperFunctions.showAlert("System Error", e.toString());
    }
    //await Future.delayed(Duration(seconds: 2));
    return res;
  }

  ///*******************************
  /// FPN Reject Request API Call
  ///*******************************
  Future<FpnResponse> fpnRejectRequest(Object body) async {
    FpnResponse res = FpnResponse(responseMessage: "", returnStatus: 0);
    try {
      NetworkClientManager networkClientManager = NetworkClientManager();
      var response = await networkClientManager.post(
          '${URLConfiguration().fpnBaseUrl}FPNRejectRequest', body);
      res = FpnResponse.fromJson(json.decode(response.body));
      if (res.returnStatus == 2) {
        res;
      } else if (res.returnStatus == 4) {
        SessionManagement.expireUserSession();
      } else {}
    } catch (e) {
      //HelperFunctions.showAlert("System Error", e.toString());
    }
    //await Future.delayed(Duration(seconds: 2));
    return res;
  }

  ///*******************************
  /// FPN Sendback Request API Call
  ///*******************************
  Future<FpnResponse> fpnSendbackRequest(Object body) async {
    NetworkClientManager networkClientManager = NetworkClientManager();
    var response = await networkClientManager.post(
        '${URLConfiguration().fpnBaseUrl}SendbackRequest', body);
    FpnResponse res = FpnResponse.fromJson(json.decode(response.body));
    return res;
    // await Future.delayed(Duration(seconds: 5));
    // print(body.toString());
    // return FpnResponse(responseMessage: "", returnStatus: 2);
  }

  List<FPNMenuItem> fpnMenuList = [];
  getMenuList() {
    List<FPNMenuItem> menuList = [];
    RequestDetails requestDetails = fpnDetailResponse.requestDetails!;
    for (var element in FPNDetailMenus.fpnMenuList) {
      switch (element.name) {
        case "Project":
          if (requestDetails.projectDetails != null) {
            menuList.add(element);
          }
          break;
        case "Application":
          if (requestDetails.applicationDetails != null) {
            menuList.add(element);
          }
          break;
        case "Benefit":
          if (requestDetails.benefitDetailsNew != null &&
              (requestDetails.benefitDetailsNew!.incrementalVolEffortList !=
                      null ||
                  requestDetails.benefitDetailsNew!.reducedEffortList !=
                      null)) {
            menuList.add(element);
          } else if (requestDetails.benefitDetails != null) {
            menuList.add(element);
          }
          break;
        case "Budget":
          if (requestDetails.budgetDetailsData != null) {
            menuList.add(element);
          }

          break;
        case "TCO":
          menuList.add(element);
          break;
        case "Case Approval":
          if (requestDetails.caseApprovalMatrix != null) {
            menuList.add(element);
          }
          break;
        case "Cost Center":
          if (requestDetails.costCenterDetails != null) {
            menuList.add(element);
          }
          break;
        case "Additional":
          if (requestDetails.caseDetails != null) {
            menuList.add(element);
          }
          break;
        case "Process Attachment":
          if (requestDetails.processAttachmentDetails != null) {
            menuList.add(element);
          }
          break;
        case "Feedback":
          if (requestDetails.feedback != null) {
            menuList.add(element);
          }
          break;
        case "Audit Trail":
          if (requestDetails.auditTrail != null) {
            menuList.add(element);
          }
          break;
        case "FPN Intimation":
          if (requestDetails.fYIFPNDetails != null) {
            menuList.add(element);
          }
          break;
        case "Fincon Sendback":
          if (requestDetails.sendbackDetails != null) {
            menuList.add(element);
          }
          break;
      }
    }
    if (menuList.length > 7) {
      menuList.insert(
          7,
          FPNMenuItem(
              name: 'More',
              icon: FontAwesomeIcons.circleChevronDown,
              isSelected: false));
    }
    fpnMenuList = menuList;
    return menuList;
  }
}
