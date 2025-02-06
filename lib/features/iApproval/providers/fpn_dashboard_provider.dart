import 'dart:convert';

import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:push_notification/utility/constants/session.dart';
import 'package:push_notification/utility/constants/url_configuration.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:push_notification/utility/mock_data/mock_fpn_data.dart';
import 'package:push_notification/utility/network/http_client.dart';
import 'package:flutter/material.dart';
import 'package:push_notification/features/iApproval/models/fpn_dashboard_response.dart';

class FPNDashboardProvider with ChangeNotifier {
  // Stores dashboard API data
  DashboardData dashboardData = DashboardData();

  // Stores pending percentage
  double pendingPercent = 0.0;

  // Stores feedback percentage
  double feedbackPercent = 0.0;

  ///*****************************
  /// FPN Dashboard Api Call
  ///*****************************
  Future<FpnDashboardResponse> getDashboardData(Object body) async {
    FpnDashboardResponse fpnDashboardResponse = FpnDashboardResponse();
    try {
      if (!GlobalVariables.isAppservice) {
        FpnDashboardResponse res = FpnDashboardResponse.fromJson(
            json.decode(MockFPNData().mockDashboard()));
        dashboardData = res.dashboardData!;
        calculatePercent();
      }
      NetworkClientManager networkClientManager = NetworkClientManager();
      var response = await networkClientManager.post(
          '${URLConfiguration().fpnBaseUrl}Dashboard', body);
      FpnDashboardResponse res =
          FpnDashboardResponse.fromJson(json.decode(response.body));
      if (res.returnStatus == 2) {
        dashboardData = res.dashboardData!;
        calculatePercent();
      } else if (res.returnStatus == 4) {
        SessionManagement.expireUserSession();
      } else {
        HelperFunctions.showAlert("", res.responseMessage!);
      }
      notifyListeners();
    } catch (e) {
      // HelperFunctions.showAlert("System Error", e.toString());
    }
    return fpnDashboardResponse;
  }

  // Calculate pending and feedback percentage
  calculatePercent() {
    try {
      var totleCount = dashboardData.fpnPendingCount! +
          dashboardData.fpnFeedbackCount! +
          dashboardData.fpnRejectedCount! +
          dashboardData.fpnAuthorizedCount!;
      if (dashboardData.fpnPendingCount! > 0) {
        pendingPercent = (dashboardData.fpnPendingCount! / totleCount);
      }
      if (dashboardData.fpnFeedbackCount! > 0) {
        feedbackPercent = (dashboardData.fpnFeedbackCount! / totleCount);
      }
    } catch (e) {
      // HelperFunctions.showAlert("System Error", e.toString());
    }
  }
}
