import 'dart:convert';

import 'package:push_notification/features/iCart/models/icart_request_response.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:push_notification/utility/constants/session.dart';
import 'package:push_notification/utility/constants/url_configuration.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:push_notification/utility/mock_data/mock_icart_data.dart';
import 'package:push_notification/utility/network/http_client.dart';
import 'package:flutter/material.dart';

class ICartFilterProvider with ChangeNotifier {
  HardwareFilter hwFilter = HardwareFilter();
  SoftwareFilter swFilter = SoftwareFilter();

  ///*****************************
  /// iCART Request List Api Call
  ///*****************************
  Future<ICartRequestsResponse> getRequestListData(Object body) async {
    ICartRequestsResponse icartRequest = ICartRequestsResponse();
    try {
      if (!GlobalVariables.isAppservice) {
        icartRequest = ICartRequestsResponse.fromJson(
            json.decode(MockICartData().mockRequestList()));
        return icartRequest;
      }
      NetworkClientManager networkClientManager = NetworkClientManager();
      var response = await networkClientManager.post(
          '${URLConfiguration().icartBaseUrl}RequestList', body);
      icartRequest = ICartRequestsResponse.fromJson(json.decode(response.body));

      if (icartRequest.returnStatus == 2) {
        if (icartRequest.hardware != null) {
          hwFilter = icartRequest.hardware!.filter!;
        }
        if (icartRequest.software != null) {
          swFilter = icartRequest.software!.filter!;
        }
      }
      if (icartRequest.returnStatus == 4) {
        if (HelperFunctions.isNullorEmpty(icartRequest.responseMessage) &&
            icartRequest.responseMessage
                .toString()
                .toLowerCase()
                .contains("session")) {
          SessionManagement.expireUserSession();
        }
      }
      notifyListeners();
    } catch (e) {
      // HelperFunctions.showAlert("System Error", e.toString());
    }
    return icartRequest;
  }

  ///**************************************
  /// iCART Request List filter selection logic
  ///**************************************

  String _selectedUnit = "";
  String get selectedUnit => _selectedUnit;
  String _selectedUnitBU = "";

  void setSelectedUnit(String unit, {bool flag = false}) {
    if (_selectedUnit == unit && flag) {
      _selectedUnit = "";
    } else {
      _selectedUnit = unit;
    }
    notifyListeners();
  }

  String _selectedType = "";
  String get selectedType => _selectedType;
  String _selectedTypeBU = "";

  void setSelectedType(String type, {bool flag = false}) {
    if (_selectedType == type && flag) {
      _selectedType = "";
    } else {
      _selectedType = type;
    }
    notifyListeners();
  }

  String _selectedDesc = "";
  String get selectedDesc => _selectedDesc;
  String _selectedDescBU = "";

  void setSelectedDesc(String desc, {bool flag = false}) {
    if (_selectedDesc == desc && flag) {
      _selectedDesc = "";
    } else {
      _selectedDesc = desc;
    }

    notifyListeners();
  }

  String _selectedSWUnit = "";
  String get selectedSWUnit => _selectedSWUnit;
  String _selectedSWUnitBU = "";

  void setSelectedSWUnit(String unit, {bool flag = false}) {
    if (_selectedSWUnit == unit && flag) {
      _selectedSWUnit = "";
    } else {
      _selectedSWUnit = unit;
    }

    notifyListeners();
  }

  String _selectedSWType = "";
  String get selectedSWType => _selectedSWType;
  String _selectedSWTypeBU = "";

  void setSelectedSWType(String type, {bool flag = false}) {
    if (_selectedSWType == type && flag) {
      _selectedSWType = "";
    } else {
      _selectedSWType = type;
    }

    notifyListeners();
  }

  void setBackUpHW() {
    _selectedUnitBU = _selectedUnit;
    _selectedTypeBU = _selectedType;
    _selectedDescBU = _selectedDesc;
  }

  void resetToPreviousHW() {
    _selectedUnit = _selectedUnitBU;
    _selectedType = _selectedTypeBU;
    _selectedDesc = _selectedDescBU;
    notifyListeners();
  }

  void setBackUpSW() {
    _selectedSWUnitBU = _selectedSWUnit;
    _selectedSWTypeBU = _selectedSWType;
  }

  void resetToPreviousSW() {
    _selectedSWUnit = _selectedSWUnitBU;
    _selectedSWType = _selectedSWTypeBU;
    notifyListeners();
  }

  void setAllSelectedHSW(String unit, String type) {
    _selectedSWUnit = unit;
    _selectedSWType = type;
    notifyListeners();
  }

  // Clear Filter
  void clearSelection() {
    _selectedUnit = "";
    _selectedType = "";
    _selectedDesc = "";
    _selectedSWType = "";
    _selectedSWUnit = "";
  }

  // Clear Filter
  void clearWithNotifySelection() {
    clearSelection();
    notifyListeners();
  }
}
