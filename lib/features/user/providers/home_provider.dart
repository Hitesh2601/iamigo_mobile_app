import 'dart:convert';

import 'package:push_notification/features/iSAC/models/isac_pending_count_model.dart';
import 'package:push_notification/features/user/models/login/fpn_login_response.dart';
import 'package:push_notification/features/user/models/login/iapprooval_count_model.dart';
import 'package:push_notification/features/user/models/login/icart_count_model.dart';
import 'package:push_notification/features/user/models/login/icart_login_response.dart';
import 'package:push_notification/features/user/models/login/isac_login_response.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:push_notification/utility/constants/url_configuration.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:push_notification/utility/mock_data/mock_pending_data.dart';
import 'package:push_notification/utility/network/http_client.dart';
import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  // Stores iSac Pending Count
  int iSacPendingCount = 0;

  bool isISacCountVisible = false;

  // Stores iCart Pending Count
  int iCartPendingCount = 0;
  bool isICartCountVisible = false;

  // Stores iApproval Pending Count
  int iApprovalPendingCount = 0;
  bool isApprovalCountVisible = false;

  // Stores user details
  UserDetails userDetails =
      UserDetails(branchCode: "", branchName: "", emailId: "", empName: "");

  ///***************************************
  /// To get pending count on home screen
  ///***************************************
  Future<bool> getPendingCount() async {
    try {
      if (!GlobalVariables.isAppservice) {
        IApprovalCountModel iApprovalCount = IApprovalCountModel.fromJson(
            json.decode(MockPendingData().mockIApprovalCount()));
        iApprovalPendingCount = int.parse(iApprovalCount.pendingCount);
        isApprovalCountVisible = iApprovalPendingCount > 0;

        IsacPendingCountModel iSacCount = IsacPendingCountModel.fromJson(
            json.decode(MockPendingData().mockISACCount()));
        iSacPendingCount = iSacCount.pendingCount;
        userDetails = iSacCount.userDetails!;
        setUserData(userDetails);
        isISacCountVisible = iSacPendingCount > 0;

        ICartCountModel iCartCount = ICartCountModel.fromJson(
            json.decode(MockPendingData().mockICartCount()));
        iCartPendingCount = iCartCount.pendingCount;

        isICartCountVisible = iCartPendingCount > 0;

        notifyListeners();
        return true;
      }
      NetworkClientManager networkClientManager = NetworkClientManager();
      // ///Getting Pending count from isac dashboard method///
      var iSACResponse = await networkClientManager.get(
          '${URLConfiguration().isacBaseUrl}iSacPendingCount/${GlobalVariables.userName}');
      IsacPendingCountModel iSacCount =
          IsacPendingCountModel.fromJson(json.decode(iSACResponse.body));
      iSacPendingCount = iSacCount.pendingCount;
      userDetails = iSacCount.userDetails!;
      setUserData(userDetails);

      isISacCountVisible = iSacPendingCount > 0;

      // ///Getting Pending count from iApprva dashboard method///
      var iApprovalResponse = await networkClientManager.get(
          '${URLConfiguration().fpnBaseUrl}iApprovalPendingCount/${GlobalVariables.userName}');
      IApprovalCountModel iApprovalCount =
          IApprovalCountModel.fromJson(json.decode(iApprovalResponse.body));
      iApprovalPendingCount = int.parse(iApprovalCount.pendingCount);
      isApprovalCountVisible = iApprovalPendingCount > 0;

      // ///Getting Pending count from iCart dashboard method///
      var iCartResponse = await networkClientManager.get(
          '${URLConfiguration().icartBaseUrl}iCartPendingCount/${GlobalVariables.userName}');
      ICartCountModel iCartCount =
          ICartCountModel.fromJson(json.decode(iCartResponse.body));
      iCartPendingCount = iCartCount.pendingCount;

      isICartCountVisible = iCartPendingCount > 0;
    } catch (e) {
      // await HelperFunctions.showAsyncAlert("Error", '$e');
    } finally {
      notifyListeners();
    }
    return true;
  }

  Future<bool> onIconPressed(String requestType) async {
    GlobalVariables.isRequestType = requestType;
    NetworkClientManager networkClientManager = NetworkClientManager();
    if (requestType == "iSAC") {
      var response = await networkClientManager
          .post('${URLConfiguration().isacBaseUrl}Login', {
        "EmpActiveDirectoryId": GlobalVariables.userName,
        "IMEICode": GlobalVariables.iMEICODE,
        "ApproverID": "",
        "RequestID": "",
        "FormID": "",
        "Password": GlobalVariables.password
      });

      ISACLoginResponse res =
          ISACLoginResponse.fromJson(json.decode(response.body));
      if (res.returnStatus == 2) {
        GlobalVariables.iSACAuthToken =
            response.headers['authtoken'].toString();
      } else if ((res.returnStatus == 3) || (res.returnStatus == 4)) {
        HelperFunctions.showAlert("AMIGO", res.responseMessage!);
      } else if (res.returnStatus == 1) {
        HelperFunctions.showAlert(
            "Error", "Error occurred while processing request.");
      } else {
        HelperFunctions.showAlert("Error", "Oops! Something went wrong");
      }
    } else if (requestType == "iCart") {
      var response = await networkClientManager
          .post('${URLConfiguration().icartBaseUrl}Login', {
        "Loginobj": {
          "UserId": GlobalVariables.userName,
          "IMEICode": GlobalVariables.iMEICODE,
          "Password": GlobalVariables.password,
          "IsOwner": "NA"
        }
      });

      ICartLoginResponse res =
          ICartLoginResponse.fromJson(json.decode(response.body));
      if (res.returnStatus == 2) {
        GlobalVariables.iCartToken = res.data!.iCartToken ?? "";
      } else {}
    } else if (requestType == "FPN") {
      var response = await networkClientManager
          .post('${URLConfiguration().fpnBaseUrl}Login', {
        "EmpActiveDirectoryId": GlobalVariables.userName,
        "IMEICode": GlobalVariables.iMEICODE,
        "FPNPsd": GlobalVariables.password
      });

      FpnLoginResponse res =
          FpnLoginResponse.fromJson(json.decode(response.body));
      if (res.returnStatus == 2) {
        GlobalVariables.fpnAuthToken =
            response.headers['fpnauthtoken'].toString();
      } else if ((res.returnStatus == 3) || (res.returnStatus == 4)) {
        HelperFunctions.showAlert("AMIGO", res.responseMessage!);
      } else if (res.returnStatus == 1) {
        HelperFunctions.showAlert(
            "Error", "Error occurred while processing request.");
      } else {
        HelperFunctions.showAlert("Error", "Oops! Something went wrong");
      }
    }
    return true;
  }

  setUserData(UserDetails userData) {
    GlobalVariables.branchName = userData.branchName;
    GlobalVariables.emailId = userData.emailId;
    GlobalVariables.empName = userData.empName;
  }
}
