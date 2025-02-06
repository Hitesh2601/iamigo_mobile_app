import 'package:push_notification/common/widgets/loader_screen.dart';
import 'package:push_notification/features/iApproval/providers/fpn_dashboard_provider.dart';
import 'package:push_notification/features/iApproval/screens/dashboard/fpn_dashboard_screen.dart';
import 'package:push_notification/features/iCart/providers/icart_dashboard_provider.dart';
import 'package:push_notification/features/iCart/screens/dashboard/icart_dashboard_screen.dart';
import 'package:push_notification/features/iSAC/screens/dashboard/isac_dashboard_screen.dart';
import 'package:push_notification/features/user/providers/home_provider.dart';
import 'package:push_notification/features/user/providers/login_provider.dart';
import 'package:push_notification/utility/constants/colors.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:push_notification/utility/constants/sizes.dart';
import 'package:push_notification/utility/helpers/aes_encryption.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class UserApplications extends StatelessWidget {
  const UserApplications({super.key});

  @override
  Widget build(BuildContext context) {
    var countvariable = Provider.of<HomeProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 150, bottom: 50, left: 10),
          alignment: Alignment.topLeft,
          child: const Text(
            'Our Applications',
            style: TextStyle(
                color: FColors.textPrimary,
                fontSize: FSizes.fontSizeXL - 2,
                fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () async {
                  BuildContext isacdialogContext = context;
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        isacdialogContext = context;
                        return loaderScreen(
                            context, "authenticating user. please wait...");
                      });
                  var isacloginJson = <String, String>{
                    "EmpActiveDirectoryId": GlobalVariables.userName,
                    "IMEICode": GlobalVariables.iMEICODE,
                    "ApproverID": "",
                    "RequestID": "",
                    "FormID": "",
                    "iSacPword": GlobalVariables.password //FOR PVT AND LIVE
                    //ONLY FOR UAT
                    // "Password": GlobalVariables.password
                  };
                  GlobalVariables.isRequestType = 'iSAC';
                  try {
                    Provider.of<LoginProvider>(context, listen: false)
                        .iSACLogin(isacloginJson)
                        .then((value) async {
                      if (value.returnStatus == 2) {
                        if (value.isacLoginData != null) {
                          await Get.offAll(const ISACDashboardScreen());
                          await Provider.of<HomeProvider>(context,
                                  listen: false)
                              .getPendingCount();
                        }
                      } else {
                        if (value.returnStatus == 1) {
                          HelperFunctions.showAlert("Error",
                              "Error occurred while processing request.");
                        } else {
                          if ((value.returnStatus == 4)) {
                            HelperFunctions.showAlert(
                                "AMIGO", value.responseMessage!);
                          } else {
                            HelperFunctions.showAlert(
                                "Error", "Oops! Something went wrong");
                          }
                        }
                      }
                    });
                  } catch (e) {
                    HelperFunctions.showAlert("Error", e.toString());
                  } finally {
                    Navigator.of(isacdialogContext, rootNavigator: true)
                        .pop(false);
                  }
                },
                child: SizedBox(
                  height: 200,
                  width: 100,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Image.asset(
                            'assets/images/isac.png',
                            height: 80,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            'iSAC',
                            style: TextStyle(
                                color: FColors.textPrimary,
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      Visibility(
                        visible: countvariable.isISacCountVisible,
                        child: Positioned(
                            top: MediaQuery.of(context).size.height * 0.00,
                            right: MediaQuery.of(context).size.width * 0.03,
                            child: Container(
                              alignment: Alignment.center,
                              width: 35,
                              height: 35,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.red),
                              child: Text(
                                countvariable.iSacPendingCount.toString(),
                                style: const TextStyle(
                                    color: FColors.textWhite,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  BuildContext dialogContext = context;
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        dialogContext = context;
                        return loaderScreen(
                            context, "authenticating user. please wait...");
                      });
                  // GlobalVariables.iv = AESEncryption.generateRandomNumber();
                  // var encrtpsd = AESEncryption.encryptPassword(
                  //     GlobalVariables.password, GlobalVariables.iv);
                  var loginJson = {
                    "Loginobj": {
                      "UserId": GlobalVariables.userName,
                      "IMEICode": GlobalVariables.iMEICODE,
                      //"CipherText": encrtpsd,
                      "IV": GlobalVariables.iv,
                      "Password": GlobalVariables.password,

                      "IsOwner": "NA"
                    }
                  };
                  GlobalVariables.isRequestType = 'iCart';
                  try {
                    Provider.of<LoginProvider>(context, listen: false)
                        .icartLogin(loginJson)
                        .then((value) async {
                      if (value.returnStatus == 2) {
                        if (value.data != null) {
                          var userProfile = value.data?.userProfile ?? [];
                          await Get.offAll(
                              ChangeNotifierProvider<ICartDashboardProvider>(
                            create: (_) => ICartDashboardProvider(),
                            child: ICartDashboardScreen(
                              userProfile: userProfile,
                            ),
                          ));
                          await Provider.of<HomeProvider>(context,
                                  listen: false)
                              .getPendingCount();
                        }
                      } else {
                        HelperFunctions.showAlert(
                            "AMIGO", value.responseMessage!);
                      }
                    });
                  } catch (e) {
                    HelperFunctions.showAlert("Error", e.toString());
                  } finally {
                    Navigator.of(dialogContext, rootNavigator: true).pop(false);
                  }
                },
                child: SizedBox(
                  height: 200,
                  width: 100,
                  child: Stack(children: [
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        Image.asset(
                          'assets/images/icart_icon.png',
                          width: 90,
                          height: 80,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          'iCART 2.0',
                          style: TextStyle(
                              color: FColors.textPrimary,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    Visibility(
                      visible: countvariable.isICartCountVisible,
                      child: Positioned(
                          top: MediaQuery.of(context).size.height * 0.00,
                          right: MediaQuery.of(context).size.width * 0.03,
                          child: Container(
                            alignment: Alignment.center,
                            width: 35,
                            height: 35,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.red),
                            child: Text(
                              countvariable.iCartPendingCount.toString(),
                              style: const TextStyle(
                                  color: FColors.textWhite,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ),
                  ]),
                ),
              ),
              InkWell(
                onTap: () async {
                  BuildContext dialogContext = context;
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        dialogContext = context;
                        return loaderScreen(
                            context, "authenticating user. please wait...");
                      });
                  var fpnloginJson = {
                    "EmpActiveDirectoryId": GlobalVariables.userName,
                    "IMEICode": GlobalVariables.iMEICODE,
                    "ApproverID": "",
                    "RequestID": "",
                    "FormID": "",
                    "FPNPsd": GlobalVariables.password
                  };
                  GlobalVariables.isRequestType = 'FPN';
                  try {
                    Provider.of<LoginProvider>(context, listen: false)
                        .fPNLogin(fpnloginJson)
                        .then((value) async {
                      if (value.returnStatus == 2) {
                        if (value.fpnLoginData != null) {
                          await Get.offAll(
                              ChangeNotifierProvider<FPNDashboardProvider>(
                            create: (_) => FPNDashboardProvider(),
                            child: const FPNDashboardScreen(),
                          ));
                          await Provider.of<HomeProvider>(context,
                                  listen: false)
                              .getPendingCount();
                        }
                      } else {
                        HelperFunctions.showAlert(
                            "Error", value.responseMessage!);
                      }
                    });
                  } catch (e) {
                    HelperFunctions.showAlert("Error", e.toString());
                  } finally {
                    Navigator.of(dialogContext, rootNavigator: true).pop(false);
                  }
                },
                child: SizedBox(
                  height: 200,
                  width: 100,
                  child: Stack(children: [
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        Image.asset(
                          'assets/images/FPN.png',
                          width: 90,
                          height: 80,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          'iApproval',
                          style: TextStyle(
                              color: FColors.textPrimary,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    Visibility(
                      visible: countvariable.isApprovalCountVisible,
                      child: Positioned(
                          top: MediaQuery.of(context).size.height * 0.00,
                          right: MediaQuery.of(context).size.width * 0.03,
                          child: Container(
                            alignment: Alignment.center,
                            width: 35,
                            height: 35,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.red),
                            child: Text(
                              countvariable.iApprovalPendingCount.toString(),
                              style: const TextStyle(
                                  color: FColors.textWhite,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ),
                  ]),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
