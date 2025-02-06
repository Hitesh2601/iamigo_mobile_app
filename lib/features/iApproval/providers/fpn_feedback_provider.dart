import 'dart:convert';
import 'package:push_notification/features/iApproval/models/employee_detail_response.dart';
import 'package:push_notification/features/iApproval/models/fpn_response.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:push_notification/utility/constants/session.dart';
import 'package:push_notification/utility/constants/url_configuration.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:push_notification/utility/network/http_client.dart';
import 'package:flutter/material.dart';

class FPNFeedbackProvider with ChangeNotifier {
  bool isEmployeeListAvailable = false;
  List<EmployeeNameDetail> employeeList = [];

  ///*******************************
  /// FPN Get Employee List API Call
  ///*******************************
  Future<List<String>> getEmployeeListData(Object body) async {
    List<String> employees = [];
    try {
      NetworkClientManager networkClientManager = NetworkClientManager();
      var response = await networkClientManager.post(
          '${URLConfiguration().fpnBaseUrl}EmployeeDetailRequest', body);
      FpnEmployeeDetailsResponse res =
          FpnEmployeeDetailsResponse.fromJson(json.decode(response.body));
      if (res.returnStatus == 2) {
        employeeList = res.employeeNameDetails!;
        for (var element in employeeList) {
          employees.add('${element.employeeCode}-${element.employeeName}');
        }
        isEmployeeListAvailable = true;
      } else if (res.returnStatus == 4) {
        SessionManagement.expireUserSession();
      } else {}
      notifyListeners();
    } catch (e) {
      // HelperFunctions.showAlert("System Error", e.toString());
    }
    return employees;
  }

  ///*******************************
  /// FPN Get Employee List API Call
  ///*******************************
  Future<bool> validateEmployeeData(String empCode) async {
    var body = <String, String>{
      'UserId': GlobalVariables.userName,
      'EmpCode': empCode
    };
    try {
      NetworkClientManager networkClientManager = NetworkClientManager();
      var response = await networkClientManager.post(
          '${URLConfiguration().fpnBaseUrl}EmployeeDetailRequest', body);
      FpnEmployeeDetailsResponse res =
          FpnEmployeeDetailsResponse.fromJson(json.decode(response.body));
      if (res.returnStatus == 2) {
        var list = res.employeeNameDetails;
        if (list == null) {
          return false;
        }

        return employeeList
            .any((x) => x.employeeCode.toLowerCase() == empCode.toLowerCase());
      } else if (res.returnStatus == 4) {
        SessionManagement.expireUserSession();
      } else {
        return false;
      }
    } catch (e) {
      //HelperFunctions.showAlert("System Error", e.toString());
    }
    return false;
  }

  ///*******************************
  /// FPN Feedback Request API Call
  ///*******************************
  Future<FpnResponse> fpnFeedbackSendRequest(Object body) async {
    NetworkClientManager networkClientManager = NetworkClientManager();
    var response = await networkClientManager.post(
        '${URLConfiguration().fpnBaseUrl}FpnFeedbackRequest', body);
    FpnResponse res = FpnResponse.fromJson(json.decode(response.body));
    return res;
    // await Future.delayed(Duration(seconds: 2));
    // return FpnResponse(responseMessage: "", returnStatus: 2);
  }

  ///*******************************
  /// FPN Feedback Request API Call
  ///*******************************
  Future<FpnResponse> fpnFeedbackReply(Object body) async {
    NetworkClientManager networkClientManager = NetworkClientManager();
    var response = await networkClientManager.post(
        '${URLConfiguration().fpnBaseUrl}FpnFeedbackReply', body);
    FpnResponse res = FpnResponse.fromJson(json.decode(response.body));
    return res;
    // await Future.delayed(Duration(seconds: 2));
    // return FpnResponse(responseMessage: "", returnStatus: 2);
  }
}
