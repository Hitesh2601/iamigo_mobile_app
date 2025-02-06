import 'dart:async';
import 'dart:convert';
import 'package:push_notification/features/iSAC/models/isac_response.dart';
import 'package:push_notification/features/iSAC/models/vendorcode_req_list_response.dart';
import 'package:push_notification/utility/constants/url_configuration.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:push_notification/utility/network/http_client.dart';
import 'package:flutter/material.dart';

class VendorCodeListProvider with ChangeNotifier {
  //Stores actual display list
  List<RequestListDataVC> _displayList = [];
  List<RequestListDataVC> get displayList => _displayList;

  //Stores whole list
  List<RequestListDataVC> _actualList = [];
  List<RequestListDataVC> get actualList => _actualList;

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
              return dt.ticketNumber.toString().toLowerCase().contains(text) ||
                  dt.companyName.toString().toLowerCase().contains(text) ||
                  dt.eNCCid.toString().toLowerCase().contains(text) ||
                  dt.requestFor.toString().toLowerCase().contains(text) ||
                  dt.requestType.toString().toLowerCase().contains(text) ||
                  dt.requestor.toString().toLowerCase().contains(text);
            }).toList();
          }
          _displayList = list;
          notifyListeners();
        } catch (e) {
          HelperFunctions.showAlert("", e.toString());
        }
      });

  ///*****************************
  /// iSAC Vendor Code Request List Api Call
  ///*****************************

  List<RequestListDataVC> _vcdataList = [];
  List<RequestListDataVC> get myDataVCList => _vcdataList;
  iSACVendorCodeRequestListClass resVC = iSACVendorCodeRequestListClass();
  Future<iSACVendorCodeRequestListClass> getvendorcodeRequestListData(
      Object body) async {
    NetworkClientManager networkClientManager = NetworkClientManager();
    var response = await networkClientManager.post(
        '${URLConfiguration().isacBaseUrl}getVendorCodeRequest', body);

    resVC = iSACVendorCodeRequestListClass.fromJson(json.decode(response.body));
    _displayList.clear();
    _actualList.clear();
    if (resVC.returnStatus == 2) {
      for (var element in resVC.data!) {
        _displayList.add(element);
        _actualList.add(element);
      }
    } else {}
    notifyListeners();
    return resVC;
  }

  ///*******************************
  /// iSAC Approve Request API Call
  ///*******************************
  Future<ISACResponse> isacApproveRejectRequest(Object body) async {
    // await Future.delayed(Duration(seconds: 2));
    // return ISACResponse(returnStatus: 2, responseMessage: "");
    NetworkClientManager networkClientManager = NetworkClientManager();
    var response = await networkClientManager.post(
        '${URLConfiguration().isacBaseUrl}RequestAuthReject', body);
    ISACResponse AuthRejectres =
        ISACResponse.fromJson(json.decode(response.body));
    if (AuthRejectres.returnStatus == 2) {
      AuthRejectres;
    } else {}
    notifyListeners();
    return AuthRejectres;
  }

  ///*******************************
  /// iSAC Vendor code And Vendor Onboard Auth Request API Call
  ///*******************************
  Future<ISACResponse> vendorAuthRequest(Object body) async {
    // await Future.delayed(Duration(seconds: 2));
    // return ISACResponse(returnStatus: 2, responseMessage: "");
    NetworkClientManager networkClientManager = NetworkClientManager();
    var response = await networkClientManager.post(
        '${URLConfiguration().isacBaseUrl}AuthorizeRequest', body);
    ISACResponse vendotAuthres =
        ISACResponse.fromJson(json.decode(response.body));
    if (vendotAuthres.returnStatus == 2) {
      vendotAuthres;
    } else {}
    notifyListeners();
    return vendotAuthres;
  }

  ///*******************************
  /// iSAC Vendor code And Vendor Onboard Reject Request API Call
  ///*******************************
  Future<ISACResponse> vendorRejectRequest(Object body) async {
    NetworkClientManager networkClientManager = NetworkClientManager();
    var response = await networkClientManager.post(
        '${URLConfiguration().isacBaseUrl}RejectRequest', body);
    ISACResponse vendotRejectres =
        ISACResponse.fromJson(json.decode(response.body));
    if (vendotRejectres.returnStatus == 2) {
      vendotRejectres;
    } else {}
    notifyListeners();
    return vendotRejectres;
  }
}
