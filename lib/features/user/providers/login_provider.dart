// ignore_for_file: unused_element, unused_local_variable, unused_import, unnecessary_brace_in_string_interps, unnecessary_string_interpolations, duplicate_import

import 'dart:convert';
import 'package:push_notification/features/iSAC/models/isac_dashboard_response.dart';
import 'package:push_notification/features/iSAC/models/isac_pending_count_model.dart';
import 'package:push_notification/features/user/models/login/fpn_login_response.dart';
import 'package:push_notification/features/user/models/login/icart_login_response.dart';
import 'package:push_notification/features/user/models/login/isac_login_response.dart';
import 'package:push_notification/features/user/models/login/login_response.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:push_notification/utility/constants/url_configuration.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:push_notification/utility/mock_data/mock_login_data.dart';
import 'package:push_notification/utility/network/http_client.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../iApproval/models/fpn_dashboard_response.dart';
import '../../iCart/models/icart_dashboard_response.dart';
import 'package:push_notification/features/iCart/models/icart_dashboard_response.dart';

class LoginProvider with ChangeNotifier {
  int iSacPendingCount = 0;
  int iCartPendingCount = 0;
  int iApprovalPendingCount = 0;
  Future<LoginResponse> adidLogin(Object body) async {
    if (!GlobalVariables.isAppservice) {
      return LoginResponse.fromJson(
          json.decode(MockLoginData().mockADIDLoginResponse()));
    }
    NetworkClientManager networkClientManager = NetworkClientManager();
    var response = await networkClientManager.post(
        '${URLConfiguration().loginBaseUrl}Login', body);
    LoginResponse res = LoginResponse.fromJson(json.decode(response.body));
    return res;
  }

  ///*****************************
  /// FPN Login Api Call
  ///*****************************
  FpnLoginResponse fpnLoginData = FpnLoginResponse();
  Future<FpnLoginResponse> fPNLogin(Object body) async {
    if (!GlobalVariables.isAppservice) {
      return FpnLoginResponse.fromJson(
          json.decode(MockLoginData().mockfpnLoginData()));
    }
    NetworkClientManager networkClientManager = NetworkClientManager();

    var response = await networkClientManager.post(
        '${URLConfiguration().fpnBaseUrl}Login', body);

    FpnLoginResponse res =
        FpnLoginResponse.fromJson(json.decode(response.body));
    if (res.returnStatus == 2) {
      GlobalVariables.fpnAuthToken =
          response.headers['fpnauthtoken'].toString();
      fpnLoginData = res;
    }
    notifyListeners();
    return res;
  }

  ///*****************************
  /// FPN Logout Api Call
  ///*****************************
  Future<LogoutResponse> fpnLogout(Object body) async {
    NetworkClientManager networkClientManager = NetworkClientManager();
    var response = await networkClientManager.post(
        '${URLConfiguration().fpnBaseUrl}Logout', body);
    LogoutResponse res = LogoutResponse.fromJson(json.decode(response.body));
    return res;
  }

  ///*****************************
  /// iCart Login Api Call
  ///*****************************
  ICartLoginResponse icartLoginResponse = ICartLoginResponse();
  Future<ICartLoginResponse> icartLogin(Object body) async {
    if (!GlobalVariables.isAppservice) {
      icartLoginResponse = ICartLoginResponse.fromJson(
          json.decode(MockLoginData().mockIcartLoginData()));
      return icartLoginResponse;
    }
    NetworkClientManager networkClientManager = NetworkClientManager();

    var response = await networkClientManager.post(
        '${URLConfiguration().icartBaseUrl}Login', body);

    ICartLoginResponse res =
        ICartLoginResponse.fromJson(json.decode(response.body));
    if (res.returnStatus == 2) {
      GlobalVariables.iCartToken = res.data!.iCartToken ?? "";
      GlobalVariables.iCartUserProfile = res.data!.userProfile;
      icartLoginResponse = res;
    } else {}
    notifyListeners();
    return res;
  }

  ///*****************************
  /// ICART Logout Api Call
  ///*****************************
  Future<LogoutResponse> icartLogout(Object body) async {
    NetworkClientManager networkClientManager = NetworkClientManager();
    var response = await networkClientManager.post(
        '${URLConfiguration().icartBaseUrl}Logout', body);
    LogoutResponse res = LogoutResponse.fromJson(json.decode(response.body));
    return res;
  }

  ///*****************************
  /// iSAC Login Api Call
  ///*****************************
  ISACLogindata homeData = ISACLogindata();
  ISACLogindata isacLoginData = ISACLogindata();
  Future<ISACLoginResponse> iSACLogin(Object body) async {
    if (!GlobalVariables.isAppservice) {
      var res = ISACLoginResponse.fromJson(
          json.decode(MockLoginData().mockISACLogin()));
      isacLoginData = res.isacLoginData!;
      homeData = res.isacLoginData!;
      setUserData(res.isacLoginData!);
      return res;
    }
    NetworkClientManager networkClientManager = NetworkClientManager();
    var response = await networkClientManager.post(
        '${URLConfiguration().isacBaseUrl}Login', body);

    ISACLoginResponse res =
        ISACLoginResponse.fromJson(json.decode(response.body));
    if (res.returnStatus == 2) {
      GlobalVariables.iSACAuthToken =
          '${GlobalVariables.tokenVarName}${response.headers['authtoken'].toString()}';
      isacLoginData = res.isacLoginData!;
      homeData = res.isacLoginData!;
      setUserData(isacLoginData);
    } else {}
    notifyListeners();
    return res;
  }

  ///*****************************
  /// iSAC Logout Api Call
  ///*****************************
  Future<LogoutResponse> isacLogout(Object body) async {
    NetworkClientManager networkClientManager = NetworkClientManager();
    var response = await networkClientManager.post(
        '${URLConfiguration().isacBaseUrl}Logout', body);
    LogoutResponse res = LogoutResponse.fromJson(json.decode(response.body));
    return res;
  }

  setUserData(ISACLogindata userData) {
    GlobalVariables.branchName = userData.branchName!;
    GlobalVariables.emailId = userData.emailId!;
    GlobalVariables.empName = userData.empName!;
  }
}
