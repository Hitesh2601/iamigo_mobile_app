import 'package:push_notification/features/iSAC/models/reject_reason.dart';

class GlobalVariables {
  static String environment = 'PROD_V2';
  static String ssoEnvironment = 'PROD';
  static String version = '';
  static String userName = '';
  static String password = '';
  static String iCartToken = '';
  static String fpnAuthToken = '';
  static bool isHomepageReturnFromFPN = false;
  static bool isHomepageReturnFromiSAC = false;
  static String isRequestType = '';
  static String iSACAuthToken = '';
  static String iMEICODE = '';
  static List<String>? iCartUserProfile;
  // Mock service flag - set true for service call
  static bool isAppservice = true;

  static String branchCode = '';
  static String empName = '';
  static String branchName = '';
  static String costName = '';
  static String emailId = '';
  static String supervisorEmpCode = '';
  static String tokenVarName = 'Aut' + 'hToken' + '=';
  static String iv = '';

  //ISAC GlobalVariables

  static String selectedRole = '';
  static String selectedStatus = '';
  static List<ReturnReasonData> dataReasonItem = [];

  //Session Global Variables
  static int secondsLeft = 900;

  // Fix session time
  static int sessionTime = 900;

  //static Duration sessionTimeOutDuration = Duration(minutes: 1);

  static String encInput = '8080808080808080';
}
