import 'dart:async';
import 'dart:convert';

import 'package:push_notification/features/iCart/models/icart_approve_reject_response.dart';
import 'package:push_notification/features/iCart/models/icart_request_response.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:push_notification/utility/constants/session.dart';
import 'package:push_notification/utility/constants/url_configuration.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:push_notification/utility/mock_data/mock_icart_data.dart';
import 'package:push_notification/utility/network/http_client.dart';
import 'package:flutter/material.dart';

class ICartRequestListProvider with ChangeNotifier {
  Hardware hardware = Hardware();
  Software software = Software();
  List<String>? filteredSWRequestNo;
  List<String>? filteredHWRequestNo;
  bool pageLoad = true;

  ///*****************************
  /// iCART Request List Api Call
  ///*****************************
  Future<ICartRequestsResponse> getRequestListData(Object body) async {
    ICartRequestsResponse icartRequest = ICartRequestsResponse();
    try {
      if (!GlobalVariables.isAppservice) {
        icartRequest = ICartRequestsResponse.fromJson(
            json.decode(MockICartData().mockRequestList()));

        hardware = icartRequest.hardware!;
        software = icartRequest.software!;
        setHardwarePageCountText();
        setSoftwarePageCountText();
        setSoftwareFilter(software.filter!);
        setHardwareFilter(hardware.filter!);
        filteredSWRequestNo = software.filteredRequestNo;
        filteredHWRequestNo = hardware.filteredRequestNo;
        return icartRequest;
      }
      NetworkClientManager networkClientManager = NetworkClientManager();
      var response = await networkClientManager.post(
          '${URLConfiguration().icartBaseUrl}RequestList', body);
      icartRequest = ICartRequestsResponse.fromJson(json.decode(response.body));
      _displayHWList = [];
      _actualHWList = [];
      _displaySWList = [];
      _actualSWList = [];
      if (icartRequest.returnStatus == 2) {
        hardware = icartRequest.hardware!;
        software = icartRequest.software!;
        for (var element in hardware.requestListHardware!) {
          _displayHWList.add(element);
          _actualHWList.add(element);
        }
        for (var element in software.requestListSoftware!) {
          _displaySWList.add(element);
          _actualSWList.add(element);
        }
        setHardwarePageCountText();
        setSoftwarePageCountText();
        if (pageLoad) {
          setSoftwareFilter(software.filter!);
          setHardwareFilter(hardware.filter!);
          pageLoad = false;
        }
      } else if (icartRequest.returnStatus == 4) {
        if (HelperFunctions.isNullorEmpty(icartRequest.responseMessage) &&
            icartRequest.responseMessage
                .toString()
                .toLowerCase()
                .contains("session")) {
          SessionManagement.expireUserSession();
        }
      } else {}
      notifyListeners();
    } catch (e) {
      // HelperFunctions.showAlert("System Error", e.toString());
    }
    return icartRequest;
  }

  ///*****************************
  /// iCART Hardware search
  ///*****************************
  //Stores actual display list
  List<RequestListHardware> _displayHWList = [];
  List<RequestListHardware> get displayHWList => _displayHWList;

  //Stores whole list
  List<RequestListHardware> _actualHWList = [];
  List<RequestListHardware> get actualHWList => _actualHWList;
  Timer? debouncer;

  @override
  void dispose() {
    debouncer?.cancel();
    swDebouncer?.cancel();
    super.dispose();
  }

  void debounce(VoidCallback callback,
      {Duration duration = const Duration(milliseconds: 1000)}) {
    if (debouncer != null) {
      debouncer!.cancel();
    }
    debouncer = Timer(duration, callback);
  }

  onHWSearchTextChanged(String text) async => debounce(() async {
        try {
          var list;
          if (text.isEmpty) {
            list = _actualHWList.where((dt) {
              return true;
            }).toList();
          } else {
            list = _actualHWList.where((dt) {
              text = text.toLowerCase();
              return dt.requestNo!.toLowerCase().contains(text) ||
                  dt.requestBy!.toLowerCase().contains(text) ||
                  dt.requestFor!.toLowerCase().contains(text) ||
                  dt.requestType!.toLowerCase().contains(text) ||
                  dt.product!.toLowerCase().contains(text) ||
                  dt.productSpecification!.toLowerCase().contains(text) ||
                  dt.previousApprover!.toLowerCase().contains(text);
            }).toList();
          }
          _displayHWList = list;
          notifyListeners();
        } catch (e) {
          // HelperFunctions.showAlert("System Error", e.toString());
        }
      });

  ///*****************************
  /// iCART Hardware search
  ///*****************************
  //Stores actual display list
  List<RequestListSoftware> _displaySWList = [];
  List<RequestListSoftware> get displaySWList => _displaySWList;

  //Stores whole list
  List<RequestListSoftware> _actualSWList = [];
  List<RequestListSoftware> get actualSWList => _actualSWList;
  Timer? swDebouncer;

  onSWSearchTextChanged(String text) async => debounce(() async {
        try {
          var list;
          if (text.isEmpty) {
            list = _actualSWList.where((dt) {
              return true;
            }).toList();
          } else {
            list = _actualSWList.where((dt) {
              text = text.toLowerCase();
              return dt.requestNo!.toLowerCase().contains(text) ||
                  dt.requestBy!.toLowerCase().contains(text) ||
                  dt.requestFor!.toLowerCase().contains(text) ||
                  dt.requestType!.toLowerCase().contains(text) ||
                  dt.softwareName!.toLowerCase().contains(text) ||
                  dt.softwareType!.toLowerCase().contains(text) ||
                  dt.acquisitionType!.toLowerCase().contains(text) ||
                  dt.previousApprover!.toLowerCase().contains(text);
            }).toList();
          }
          _displaySWList = list;
          notifyListeners();
        } catch (e) {
          // HelperFunctions.showAlert("System Error", e.toString());
        }
      });

  ///**************************************
  /// iCART Request List pagination logic
  ///**************************************

  // Hardware count label visiblity
  bool isHardPageLableCount = false;

  // Hardware next icon visiblity
  bool isHardNextVisible = false;

  // Hardware prev icon visiblity
  bool isHardPrevVisible = false;

  // Hardware count label
  String hardwarePageCounttext = "";

  // Setting Software Page Count
  void setHardwarePageCountText() {
    try {
      if (HelperFunctions.getNumber(hardware.endCount!) >=
          HelperFunctions.getNumber(hardware.totalCount!)) {
        hardware.endCount = hardware.totalCount;
      }
      hardwarePageCounttext =
          '${hardware.startCount} to ${hardware.endCount} of ${hardware.totalCount}';
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
    } catch (e) {
      // HelperFunctions.showAlert("System Error", e.toString());
    }
  }

  // Software count label visiblity
  bool isSoftPageLableCount = false;

  // Software next icon visiblity
  bool isSoftNextVisible = false;

  // Software prev icon visiblity
  bool isSoftPrevVisible = false;

  // Software count label
  String softwarePageCounttext = "";

  // Setting Software Page Count
  void setSoftwarePageCountText() {
    try {
      if (HelperFunctions.getNumber(software.endCount!) >=
          HelperFunctions.getNumber(software.totalCount!)) {
        software.endCount = software.totalCount;
      }
      softwarePageCounttext =
          '${software.startCount} to ${software.endCount} of ${software.totalCount}';

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
    } catch (e) {
      // HelperFunctions.showAlert("System Error", e.toString());
    }
  }

  ///**************************************
  /// iCART Request List filter selection logic
  ///**************************************

  SoftwareFilter? softwareFilter;
  setSoftwareFilter(SoftwareFilter value) {
    softwareFilter ??= value;
  }

  late HardwareFilter _hardwareFilter = HardwareFilter();
  HardwareFilter get hardwareFilter => _hardwareFilter;
  void setHardwareFilter(HardwareFilter val) {
    _hardwareFilter = val;
    notifyListeners();
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
    } catch (e) {}
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
      //HelperFunctions.showAlert("System Error", e.toString());
    }
    return res;
    // await Future.delayed(Duration(seconds: 3));
    // return ICartApproveReject(returnStatus: 2);
  }

  late int _hwFilterCount = 0;
  int get hwFilterCount => _hwFilterCount;
  void setHwFilterCount(int val) {
    _hwFilterCount = val;
    notifyListeners();
  }

  late int _swFilterCount = 0;
  int get swFilterCount => _swFilterCount;
  void setSwFilterCount(int val) {
    _swFilterCount = val;
    notifyListeners();
  }
}
