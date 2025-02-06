import 'dart:async';
import 'dart:convert';

import 'package:push_notification/features/iApproval/models/fpn_request_list_response.dart';
import 'package:push_notification/features/iApproval/models/fpn_response.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:push_notification/utility/constants/session.dart';
import 'package:push_notification/utility/constants/url_configuration.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:push_notification/utility/mock_data/mock_fpn_data.dart';
import 'package:push_notification/utility/network/http_client.dart';
import 'package:flutter/material.dart';

class FPNRequestListProvider with ChangeNotifier {
  //Stores actual display list
  List<FPNData> _displayList = [];
  List<FPNData> get displayList => _displayList;

  //Stores whole list
  List<FPNData> _actualList = [];
  List<FPNData> get actualList => _actualList;

  ///*****************************
  /// FPN Request List Api Call
  ///*****************************
  Future<FpnRequestListResponse> getRequestListData(Object body) async {
    FpnRequestListResponse res = FpnRequestListResponse();
    try {
      if (!GlobalVariables.isAppservice) {
        res = FpnRequestListResponse.fromJson(
            json.decode(MockFPNData().mockRequestList()));
        _displayList.clear();
        _actualList.clear();
        for (var element in res.data!) {
          _displayList.add(element);
          _actualList.add(element);
        }
        return res;
      }
      NetworkClientManager networkClientManager = NetworkClientManager();
      var response = await networkClientManager.post(
          '${URLConfiguration().fpnBaseUrl}RequestList', body);
      res = FpnRequestListResponse.fromJson(json.decode(response.body));
      _displayList.clear();
      _actualList.clear();
      if (res.returnStatus == 2) {
        for (var element in res.data!) {
          _displayList.add(element);
          _actualList.add(element);
        }
      } else if (res.returnStatus == 4) {
        SessionManagement.expireUserSession();
      } else {
        //HelperFunctions.showAlert("", res.responseMessage!);
      }
      notifyListeners();
    } catch (e) {
      //HelperFunctions.showAlert("System Error", e.toString());
    }
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
              return dt.fPNNumber!.toLowerCase().contains(text) ||
                  dt.fPNCategory!.toLowerCase().contains(text) ||
                  dt.fPNSubCategory!.toLowerCase().contains(text) ||
                  dt.fPNAmount!.toLowerCase().contains(text) ||
                  dt.cashFlowAmount!.toLowerCase().contains(text) ||
                  dt.nonCashFlowAmount!.toLowerCase().contains(text);
            }).toList();
          }
          _displayList = list;
          notifyListeners();
        } catch (e) {
          // HelperFunctions.showAlert("System Error", e.toString());
        }
      });

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
      return res;
    } catch (e) {
      //HelperFunctions.showAlert("System Error", e.toString());
    }
    return res;
  }
}
