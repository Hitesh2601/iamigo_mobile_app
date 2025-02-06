import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:push_notification/utility/constants/url_configuration.dart';
import 'package:push_notification/utility/network/http_client.dart';

class GlobalMethods {
  ///**********************************
  /// Display Response Message Dialog
  ///**********************************
  // static Widget popupResponseAlert(context, String responseMessage) {
  //   return AlertDialog(
  //     title: const Text(
  //       'AMIGO',
  //       style: TextStyle(fontSize: 17),
  //     ),
  //     content: Text(responseMessage),
  //     actions: [
  //       SizedBox(
  //         height: 40,
  //         child: TextButton(
  //           child: const Text('Ok'),
  //           onPressed: () => {Navigator.pop(context)},
  //         ),
  //       ),
  //     ],
  //   );
  // }

  static Future<void> doLogout(String appType) async {
    NetworkClientManager networkClientManager = NetworkClientManager();
    if (appType == "iSAC") {
      //iSAC LogOut
      var isaclogoutJson = <String, String>{
        "EmpActiveDirectoryId": GlobalVariables.userName,
        "IMEICode": GlobalVariables.iMEICODE,
        "ApproverID": "",
        "RequestID": "",
        "FormID": "",
        "iSacPword": GlobalVariables.password
      };
      await networkClientManager.post(
          '${URLConfiguration().isacBaseUrl}Logout', isaclogoutJson);
    } else if (appType == "iCart") {
      ///iCART LogOUT
      var icartlogoutJson = {
        "RegObj": {
          "UserId": GlobalVariables.userName,
        }
      };
      await networkClientManager.post(
          '${URLConfiguration().icartBaseUrl}Logout', icartlogoutJson);

      ///END
    } else if (appType == "FPN") {
      //FPN LogOut
      var fpnlogoutJson = <String, String>{
        "EmpActiveDirectoryId": GlobalVariables.userName,
        "IMEICode": GlobalVariables.iMEICODE,
        "FPNPsd": GlobalVariables.password
      };
      await networkClientManager.post(
          '${URLConfiguration().fpnBaseUrl}Logout', fpnlogoutJson);
    }
  }
}
