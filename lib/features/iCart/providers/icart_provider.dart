import 'dart:convert';

import 'package:push_notification/features/iCart/models/icart_approve_reject_response.dart';
import 'package:push_notification/features/iCart/models/icart_request_response.dart';
import 'package:push_notification/utility/constants/url_configuration.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:push_notification/utility/network/http_client.dart';
import 'package:flutter/material.dart';

class ICartProvider with ChangeNotifier {
  ///*****************************
  /// iCART Request List Api Call
  ///*****************************
  ICartRequestsResponse icartRequest = ICartRequestsResponse();
  bool isHardPageLableCount = false;
  bool isHardNextVisible = false;
  bool isHardPrevVisible = false;
  bool isSoftPageLableCount = false;
  bool isSoftNextVisible = false;
  bool isSoftPrevVisible = false;
  String hardwarePageCounttext = "";
  String softwarePageCounttext = "";

  void setHardwarePageCountText(Hardware? hardware) {
    if (HelperFunctions.getNumber(hardware?.endCount!) >=
        HelperFunctions.getNumber(hardware!.totalCount!)) {
      hardware.endCount = hardware.totalCount;
    }
    hardwarePageCounttext =
        '${hardware.startCount} to ${hardware.endCount} of ${hardware.totalCount}';

    // else {
    //   if (App.HardwareNameFilter != null ||
    //       App.HarwareTypeFilter != null ||
    //       App.HarwareSpecificationFilter.Count > 0)
    //     objWrapper.Hardware.HarwarePageCounttext =
    //         (Convert.ToString(objWrapper.Hardware.StartCount) +
    //             " to " +
    //             Convert.ToString(objWrapper.Hardware.EndCount) +
    //             " of " +
    //             Convert.ToString(objWrapper.Hardware.TotalCount) +
    //             " (Filtered)");
    // }
    if (hardware.totalCount! <= 30) {
      isHardPageLableCount = true;
      isHardNextVisible = false;
      isHardPrevVisible = false;
    } else if (hardware.endCount! == hardware.totalCount!) {
      isHardPageLableCount = true;
      isHardNextVisible = false;
      isHardPrevVisible = true;
    } else if (hardware.startCount! == 1) {
      isHardPageLableCount = true;
      isHardNextVisible = true;
      isHardPrevVisible = false;
    } else {
      isHardPageLableCount = true;
      isHardNextVisible = true;
      isHardPrevVisible = true;
    }
  }

  void setSoftwarePageCountText(Software? software) {
    if (HelperFunctions.getNumber(software?.endCount!) >=
        HelperFunctions.getNumber(software!.totalCount!)) {
      software.endCount = software.totalCount;
    }
    softwarePageCounttext =
        '${software.startCount} to ${software.endCount} of ${software.totalCount}';

    // else {
    //   if (App.softwareNameFilter != null ||
    //       App.HarwareTypeFilter != null ||
    //       App.HarwareSpecificationFilter.Count > 0)
    //     objWrapper.software.HarwarePageCounttext =
    //         (Convert.ToString(objWrapper.software.StartCount) +
    //             " to " +
    //             Convert.ToString(objWrapper.software.EndCount) +
    //             " of " +
    //             Convert.ToString(objWrapper.software.TotalCount) +
    //             " (Filtered)");
    // }
    if (software.totalCount! <= 30) {
      isSoftPageLableCount = true;
      isSoftNextVisible = false;
      isSoftPrevVisible = false;
    } else if (software.endCount! == software.totalCount!) {
      isSoftPageLableCount = true;
      isSoftNextVisible = false;
      isSoftPrevVisible = true;
    } else if (software.startCount! == 1) {
      isSoftPageLableCount = true;
      isSoftNextVisible = true;
      isSoftPrevVisible = false;
    } else {
      isSoftPageLableCount = true;
      isSoftNextVisible = true;
      isSoftPrevVisible = true;
    }
  }

  ///*******************************
  /// iCart Approve Request API Call
  ///*******************************
  Future<ICartApproveReject> iCartApproveRequest(Object body) async {
    ICartApproveReject res = ICartApproveReject(returnStatus: 2);
    // NetworkClientManager networkClientManager = NetworkClientManager();
    // var response = await networkClientManager.post(
    //     '${URLConfiguration().icartBaseUrl}ApproveRequest', body);
    // res = ICartApproveReject.fromJson(json.decode(response.body));
    // if (res.returnStatus == 2) {
    //   res;
    // } else {}
    return res;
  }

  ///*******************************
  /// iCart Reject Request API Call
  ///*******************************
  Future<ICartApproveReject> iCartRejectRequest(Object body) async {
    ICartApproveReject res = ICartApproveReject(returnStatus: 2);
    // NetworkClientManager networkClientManager = NetworkClientManager();
    // var response = await networkClientManager.post(
    //     '${URLConfiguration().icartBaseUrl}RejectRequest', body);
    // ICartApproveReject res =
    //     ICartApproveReject.fromJson(json.decode(response.body));
    // if (res.returnStatus == 2) {
    //   res;
    // } else {}
    return res;
  }
}
