import 'dart:convert';
import 'package:push_notification/features/iCart/models/icart_dashboard_response.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:push_notification/utility/constants/session.dart';
import 'package:push_notification/utility/constants/url_configuration.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:push_notification/utility/mock_data/mock_icart_data.dart';
import 'package:push_notification/utility/network/http_client.dart';
import 'package:flutter/material.dart';

class ICartDashboardProvider with ChangeNotifier {
  //stores dashboard response
  List<DashboardData> _dashboardData = [];
  List<DashboardData> get dashboardData => _dashboardData;

  ///*****************************
  /// iCART Dashboard Api Call
  ///*****************************
  Future<ICartDashboardResponse> getDashboardData(Object body) async {
    ICartDashboardResponse res = ICartDashboardResponse();
    try {
      if (!GlobalVariables.isAppservice) {
        ICartDashboardResponse dashboardResponse =
            ICartDashboardResponse.fromJson(
                json.decode(MockICartData().mockDashboard()));
        _dashboardData = dashboardResponse.dashboardData!;
        return dashboardResponse;
      }
      NetworkClientManager networkClientManager = NetworkClientManager();
      var response = await networkClientManager.post(
          '${URLConfiguration().icartBaseUrl}GetDashboard', body);
      res = ICartDashboardResponse.fromJson(json.decode(response.body));
      if (res.returnStatus == 2) {
        _dashboardData = res.dashboardData!;
      } else if (res.returnStatus == 4) {
        if (HelperFunctions.isNullorEmpty(res.responseMessage) &&
            res.responseMessage.toString().toLowerCase().contains("session")) {
          SessionManagement.expireUserSession();
        }
      } else {}
      notifyListeners();
    } catch (e) {
      // HelperFunctions.showAlert("System Error", e.toString());
    }
    return res;
  }
}
