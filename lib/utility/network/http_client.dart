import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/global_variables.dart';

class NetworkClientManager {
  var client = http.Client();

  ///*************************
  /// Function Name - GET
  ///*************************
  /// Parameter - urlString
  ///*************************
  /// Returns - http.Response in Future
  ///*************************
  Future<http.Response> get(String urlString) async {
    dynamic jsonResponse;
    Uri url = Uri.parse(urlString);
    try {
      final response = await client.get(url);

      jsonResponse = response;
      printRequestResponse(
          urlString,
          {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          "",
          json.decode(jsonResponse.body.toString()));
    } on SocketException {
      HelperFunctions.showExitAlert("Network",
          "Please check your network connection and authenticate on zscaler to use iAmigo application");
    } on FormatException {
      HelperFunctions.showAlert("Error", 'Oops something went wrong!');
    } on HttpException {
      HelperFunctions.showAlert("Error", "Can't reach the server.");
    } on HandshakeException {
      HelperFunctions.showExitAlert(
          "Error", "Please authenticate on zscaler to use iAmigo application");
    } on Exception catch (e) {
      HelperFunctions.showAlert("Error", e.toString());
    }
    return jsonResponse;
  }

  ///*************************
  /// Function Name - POST
  ///*************************
  /// Parameter - urlString , bodyObject
  ///*************************
  /// Returns - http.Response in Future
  ///*************************
  Future<http.Response> post(String urlString, Object body) async {
    dynamic jsonResponse;
    try {
      Map<String, String> headers = {};
      Uri url = Uri.parse(urlString);
      headers.clear();
      if (GlobalVariables.environment == "PROD_V2" &&
          urlString.contains("Login")) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        headers = <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': prefs.getString("accessToken") ?? "",
        };
      } else {
        if (GlobalVariables.isRequestType == 'FPN') {
          headers = <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'FPNCookie': GlobalVariables.fpnAuthToken
          };
        } else if (GlobalVariables.isRequestType == 'iSAC') {
          headers = <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Cookie': GlobalVariables.iSACAuthToken
          };
        } else if (GlobalVariables.isRequestType == 'iCart') {
          headers = <String, String>{
            "Accept": "application/json",
            "Content-Type": "application/json; charset=UTF-8",
            'iCARTToken': GlobalVariables.iCartToken,
            'EmpCode': GlobalVariables.userName
          };
        } else {
          headers = <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          };
        }
      }
      final response =
          await client.post(url, headers: headers, body: jsonEncode(body));
      jsonResponse = response;
      printRequestResponse(
          urlString, headers, body, json.decode(jsonResponse.body.toString()));
    } on SocketException {
      HelperFunctions.showAlert(
          "Network", "Please check your network connection.");
    } on FormatException {
      HelperFunctions.showAlert("Error", 'Oops something went wrong!');
    } on HttpException {
      HelperFunctions.showAlert("Error", "Can't reach the server.");
    } on HandshakeException {
      HelperFunctions.showAlert(
          "Error", "Please authenticate on zscaler to use iAmigo application");
    } on Exception catch (e) {
      HelperFunctions.showAlert("Error", e.toString());
    }
    return jsonResponse;
  }

  ///*************************
  /// To Handle Response
  ///*************************
  dynamic _handleResponse(http.Response response) {
    dynamic responseJson;
    switch (response.statusCode) {
      case 200:
        responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        responseJson = 'Invalid Request';
        return responseJson;
      case 403:
        responseJson = 'UnAuthorised Request';
        return responseJson;
      case 404:
        responseJson = 'Request Not Found';
        return responseJson;
      case 500:
      default:
        throw ('Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  ///*************************
  /// To Print Request Response
  ///*************************
  void printRequestResponse(
      String urlString, Map headers, Object body, dynamic response) {
    // ignore_for_file: avoid_print
    print('------------------------------------------------------------');
    print('RequestUrl : $urlString');
    print('------------------------------------------------------------');
    print('RequestHeader : $headers');
    print('------------------------------------------------------------');
    print('RequestJson : $body');
    print('------------------------------------------------------------');
    print('ResponseJson : $response');
    print('------------------------------------------------------------');
  }
}
