import 'package:push_notification/utility/constants/global_variables.dart';

class URLConfiguration {
  String? icartBaseUrl, fpnBaseUrl, isacBaseUrl, loginBaseUrl;
  URLConfiguration() {
    String baseURL,
        isacServicePath,
        fpnServicePath,
        iCartServicePath,
        loginServicePath;
    if (GlobalVariables.environment == "PROD") {
      baseURL = "https://btgm.hbctxdom.com:9999/";
      isacServicePath = "iSACiAMIGOMobileService/V2/MobileService.svc/";
      fpnServicePath = "iApprovaliAMIGOMobileService/V2/MobileService.svc/";
      iCartServicePath = "iCARTiAMIGOMobileService/V2/Service1.svc/";
      loginServicePath = "AmigoLoginService/LoginService.svc/";
    } else if (GlobalVariables.environment == "PROD_V2") {
      baseURL = "https://btgm.hbctxdom.com:9999/";
      isacServicePath = "iSACiAMIGOMobileService/V3/MobileService.svc/";
      fpnServicePath = "iApprovaliAMIGOMobileService/V3/MobileService.svc/";
      iCartServicePath = "iCARTiAMIGOMobileService/V3/Service1.svc/";
      loginServicePath = "AmigoLoginService/LoginService.svc/";
    } else if (GlobalVariables.environment == "UAT") {
      baseURL = "http://isacuat.hdfcbankuat.com:9999/";
      isacServicePath = "iSACMobileService/MobileService.svc/";
      fpnServicePath = "FPN_Mobile_Service/MobileService.svc/";
      iCartServicePath = "iCARTMobileService/Service1.svc/";
      loginServicePath = "AmigoLoginService/LoginService.svc/";
    } else if (GlobalVariables.environment == "UAT_V1") {
      baseURL = "http://isacuat.hdfcbankuat.com:9999/";
      isacServicePath = "iSACiAMIGOMobileService/V3/MobileService.svc/";
      fpnServicePath = "FPN_Mobile_Service/V1/MobileService.svc/";
      iCartServicePath = "iCARTiAMIGOMobileService/V3/Service1.svc/";
      loginServicePath = "AmigoLoginService/LoginService.svc/";
    } else if (GlobalVariables.environment == "UAT_V2") {
      baseURL = "http://isacuat.hdfcbankuat.com:9999/";
      isacServicePath = "iSACiAMIGOMobileService/V2/MobileService.svc/";
      fpnServicePath = "FPN_Mobile_Service/MobileService.svc/";
      iCartServicePath = "iCARTiAMIGOMobileService/V2/Service1.svc/";
      loginServicePath = "AmigoLoginService/LoginService.svc/";
    } else if (GlobalVariables.environment == "UAT_V3") {
      baseURL = "http://isacuat.hdfcbankuat.com:9999/";
      isacServicePath = "iSACiAMIGOMobileService/V3/MobileService.svc/";
      fpnServicePath = "FPN_Mobile_Service/MobileService.svc/";
      iCartServicePath = "iCARTiAMIGOMobileService/V2/Service1.svc/";
      loginServicePath = "AmigoLoginService/LoginService.svc/";
    } else if (GlobalVariables.environment == "UAT-HTTPS") {
      baseURL = "https://btguat2.hdfcbankuat.com:9999/";
      isacServicePath = "iSACMobileService/MobileService.svc/";
      fpnServicePath = "FPN_Mobile_Service/MobileService.svc/";
      iCartServicePath = "iCARTMobileService/Service1.svc/";
      loginServicePath = "AmigoLoginService/LoginService.svc/";
    } else {
      baseURL = "http://10.226.215.57:9999/";
      isacServicePath = "iSACMobileService/MobileService.svc/";
      fpnServicePath = "FPN_Mobile_Service/MobileService.svc/";
      iCartServicePath = "iCARTMobileService/Service1.svc/";
      loginServicePath = "AmigoLoginService/LoginService.svc/";
    }
    icartBaseUrl = '$baseURL$iCartServicePath';
    fpnBaseUrl = '$baseURL$fpnServicePath';
    isacBaseUrl = '$baseURL$isacServicePath';
    loginBaseUrl = '$baseURL$loginServicePath';
  }
}
