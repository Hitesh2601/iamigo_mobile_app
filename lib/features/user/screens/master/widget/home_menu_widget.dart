import 'package:push_notification/common/widgets/loader_screen.dart';
import 'package:push_notification/features/iApproval/providers/fpn_dashboard_provider.dart';
import 'package:push_notification/features/iApproval/screens/dashboard/fpn_dashboard_screen.dart';
import 'package:push_notification/features/iCart/providers/icart_dashboard_provider.dart';
import 'package:push_notification/features/iCart/screens/dashboard/icart_dashboard_screen.dart';
import 'package:push_notification/features/iSAC/screens/dashboard/isac_dashboard_screen.dart';
import 'package:push_notification/features/user/providers/login_provider.dart';
import 'package:push_notification/utility/constants/colors.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:push_notification/utility/constants/sizes.dart';
import 'package:push_notification/utility/helpers/aes_encryption.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomeMenuWidget extends StatelessWidget {
  const HomeMenuWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(FSizes.borderRadiousLg),
        ),
        color: FColors.textWhite,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(
                    15,
                  ),
                  child: Text('Jump To',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: FColors.textPrimary,
                          fontSize: 18)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () async {
                        var isacloginJson = <String, String>{
                          "EmpActiveDirectoryId": GlobalVariables.userName,
                          "IMEICode": GlobalVariables.iMEICODE,
                          "ApproverID": "",
                          "RequestID": "",
                          "FormID": "",
                          "iSacPword": GlobalVariables.password
                        };
                        GlobalVariables.isRequestType = 'iSAC';
                        Provider.of<LoginProvider>(context, listen: false)
                            .iSACLogin(isacloginJson)
                            .then((value) {
                          if (value.returnStatus == 2) {
                            if (value.isacLoginData != null) {
                              Get.offAll(const ISACDashboardScreen());
                            }
                          }
                        });
                      },
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/isac.png',
                              height: 60,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              'iSAC',
                              style: TextStyle(
                                  color: FColors.textPrimary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        // GlobalVariables.iv =
                        //     AESEncryption.generateRandomNumber();
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
                              .then((value) {
                            if (value.returnStatus == 2) {
                              if (value.data != null) {
                                var userProfile = value.data?.userProfile ?? [];

                                Get.offAll(ChangeNotifierProvider<
                                    ICartDashboardProvider>(
                                  create: (_) => ICartDashboardProvider(),
                                  child: ICartDashboardScreen(
                                    userProfile: userProfile,
                                  ),
                                ));
                              }
                            } else {
                              HelperFunctions.showAlert(
                                  "AMIGO", value.responseMessage!);
                            }
                          });
                        } catch (e) {
                          HelperFunctions.showAlert("Error", e.toString());
                        }
                      },
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/icart_icon.png',
                              width: 70,
                              height: 60,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              'iCART 2.0',
                              style: TextStyle(
                                  color: FColors.textPrimary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        var fpnloginJson = <String, String>{
                          "EmpActiveDirectoryId": GlobalVariables.userName,
                          "IMEICode": GlobalVariables.iMEICODE,
                          "FPNPsd": GlobalVariables.password
                        };
                        GlobalVariables.isRequestType = 'FPN';
                        try {
                          Provider.of<LoginProvider>(context, listen: false)
                              .fPNLogin(fpnloginJson)
                              .then((value) {
                            if (value.returnStatus == 2) {
                              if (value.fpnLoginData != null) {
                                Get.offAll(ChangeNotifierProvider<
                                    FPNDashboardProvider>(
                                  create: (_) => FPNDashboardProvider(),
                                  child: const FPNDashboardScreen(),
                                ));
                              }
                            } else {
                              HelperFunctions.showAlert(
                                  "Error", value.responseMessage!);
                            }
                          });
                        } catch (e) {
                          HelperFunctions.showAlert("Error", e.toString());
                        }
                      },
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/FPN.png',
                              width: 70,
                              height: 60,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              'iApproval',
                              style: TextStyle(
                                  color: FColors.textPrimary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
