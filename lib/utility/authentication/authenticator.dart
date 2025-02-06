import 'dart:convert';
import 'dart:io';
import 'package:push_notification/utility/authentication/ssouser.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MsalAuthService {
  static String _tenantID = "", _clientId = "";

  static String _redirectUri = "";
  Future<String?> authenticateWithMicrosoft() async {
    if (GlobalVariables.ssoEnvironment == "PROD") {
      _tenantID = "827fd022-05a6-4e57-be9c-cc069b6ae62d";
      _clientId = "9e9fa032-2bb0-4b20-8a54-6175db07393e";
      _redirectUri = Platform.isAndroid
          ? "msauth://com.hdfcbank.iha.amigointunemdm/4%2B5wCp8QcLptlO0aeP5RDTTOWyg%3D"
          : "msauth.com.hdfcbank.iha.amigointunemdm://auth";
    } else if (GlobalVariables.ssoEnvironment == "BETA") {
      _tenantID = "827fd022-05a6-4e57-be9c-cc069b6ae62d";
      _clientId = "090a35b7-8fdd-4799-9e75-fe3f0b26ba7f";
      _redirectUri = Platform.isAndroid
          ? "msauth://com.hdfcbank.iha.amigointunemdmbeta/CC0F41jNoY0hb%2Bx6JYEGxvrvKI8%3D"
          : "msauth.com.hdfcbank.iha.amigointunemdmbeta://auth";
    } else {
      _tenantID = "e6be54ea-7062-4c17-8fe8-93619063be54";
      _clientId = "682316db-37af-4171-96ca-d924fc6ae346";
      _redirectUri = Platform.isAndroid
          ? "msauth://com.hdfcbank.iha.amigointunemdmbeta/CC0F41jNoY0hb%2Bx6JYEGxvrvKI8%3D"
          : "msauth.com.hdfcbank.iha.amigointunemdmbeta://auth";
    }

    // https://login.microsoftonline.com/827fd022-05a6-4e57-be9c-cc069b6ae62d/oauth2/v2.0/authorize?client_id=9e9fa032-2bb0-4b20-8a54-6175db07393e&response_type=code&redirect_uri=msauth://com.hdfcbank.iha.amigointunemdm/4%2B5wCp8QcLptlO0aeP5RDTTOWyg%3D&response_mode=query&scope=User.Read&state=12345&sso_reload=true
    final authUrl =
        "https://login.microsoftonline.com/$_tenantID/oauth2/v2.0/authorize"
        "?client_id=$_clientId"
        "&response_type=code"
        "&redirect_uri=$_redirectUri"
        "&response_mode=query"
        "&scope=User.Read"
        "&state=12345"; // State parameter for CSRF protection
    try {
      final result = await FlutterWebAuth.authenticate(
        url: authUrl,
        callbackUrlScheme: "msauth",
      );

      final code = Uri.parse(result).queryParameters['code'];
      if (code != null) {
        var tkn = await getTokenFromCode(code);
        return tkn;
      } else {
        print("Authorization failed");
        HelperFunctions.showAlert("Message", "Authorization failed");
      }
    } catch (e) {
      print("Error during authentication: $e");
      HelperFunctions.showAlert("Error", "Error during authentication: $e");
    }
    return null;
  }

  Future<String?> getTokenFromCode(String code) async {
    //https://login.microsoftonline.com/e6be54ea-7062-4c17-8fe8-93619063be54/oauth2/v2.0/token
    final tokenUrl =
        "https://login.microsoftonline.com/$_tenantID/oauth2/v2.0/token";

    final response = await http.post(
      Uri.parse(tokenUrl),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'client_id': _clientId,
        'scope': 'User.Read',
        'code': code,
        'redirect_uri': _redirectUri,
        'grant_type': 'authorization_code',
      },
    );

    if (response.statusCode == 200) {
      final tokenData = json.decode(response.body);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("accessToken", tokenData['access_token']);
      // print("Access Token: ${tokenData['access_token']}");
      // HelperFunctions.showCopyAlert(
      //     "Access Token:", "${tokenData['access_token']}");
      return "${tokenData['access_token']}";
    } else {
      // print("Failed to exchange token: ${response.body}");
      HelperFunctions.showAlert(
          "Error", "Failed to exchange token: ${response.body}");
    }
    return null;
  }

  Future<bool> vaidateToken(String accessToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final graphUrl = "https://graph.microsoft.com/v1.0/me";

    final response = await http.get(
      Uri.parse(graphUrl),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    print('${response.statusCode}');
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<String?> fetchUserData(String accessToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username;
    final graphUrl = "https://graph.microsoft.com/v1.0/me";

    final response = await http.get(
      Uri.parse(graphUrl),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      SSOUser userData = SSOUser.fromJson(json.decode(response.body));
      String user = userData.userPrincipalName ?? "";
      if (!HelperFunctions.isNullorEmpty(user)) {
        final splitted = user.split('@');
        String splitteduser = splitted[0];
        username = splitteduser.toLowerCase().replaceAll('uat', "");
        prefs.setString("username", username);

        // HelperFunctions.showCopyAlert("username:", "$username");
      }
    } else {
      print("Failed to fetch user data: ${response.body}");
      prefs.setString("accessToken", "");
    }
    return username;
  }
}
