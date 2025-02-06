import 'dart:io';

import 'package:push_notification/features/iApproval/providers/fpn_dashboard_provider.dart';
import 'package:push_notification/features/iApproval/providers/fpn_request_list_provider.dart';
import 'package:push_notification/features/iApproval/screens/dashboard/fpn_dashboard_screen.dart';
import 'package:push_notification/features/iApproval/screens/request_list/fpn_requests_screen.dart';
import 'package:push_notification/features/user/providers/home_provider.dart';
import 'package:push_notification/features/user/providers/login_provider.dart';
import 'package:push_notification/features/user/screens/home/home_screen.dart';
import 'package:push_notification/features/user/screens/login/login_screen.dart';
import 'package:push_notification/splash_screen.dart';
import 'package:push_notification/utility/constants/colors.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FPNMenusWidget extends StatelessWidget {
  const FPNMenusWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var fpnlogoutJson = <String, String>{
      "EmpActiveDirectoryId": GlobalVariables.userName,
      "IMEICode": GlobalVariables.iMEICODE,
      "FPNPsd": GlobalVariables.password
    };
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  GlobalVariables.isRequestType = 'FPN';
                  Provider.of<LoginProvider>(context, listen: false)
                      .fpnLogout(fpnlogoutJson)
                      .then((value) {
                    if (value.returnStatus == 2) {
                      Get.offAll(ChangeNotifierProvider<HomeProvider>(
                        create: (_) => HomeProvider(),
                        child: const HomeScreen(),
                      ));
                    }
                  });
                },
                child: Row(
                  children: [
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                          border: Border.all(color: FColors.light),
                          borderRadius: BorderRadius.circular(30),
                          color: FColors.light,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[400]!,
                                blurRadius: 3.0,
                                blurStyle: BlurStyle.normal),
                          ]),
                      padding: const EdgeInsets.all(8),
                      child: Image.asset(
                        'assets/images/home_icon.png',
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Text('Home',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: FColors.textPrimary,
                              fontSize: 18)),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    const Icon(
                      FontAwesomeIcons.angleRight,
                      size: 20,
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(),
              ),
              InkWell(
                onTap: () =>
                    Get.to(ChangeNotifierProvider<FPNDashboardProvider>(
                  create: (_) => FPNDashboardProvider(),
                  child: const FPNDashboardScreen(),
                )),
                child: Row(
                  children: [
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                          border: Border.all(color: FColors.light),
                          borderRadius: BorderRadius.circular(30),
                          color: FColors.light,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[400]!,
                                blurRadius: 3.0,
                                blurStyle: BlurStyle.normal),
                          ]),
                      padding: const EdgeInsets.all(8),
                      child: Image.asset(
                        'assets/images/dashboard.png',
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Text('Dashboard',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: FColors.textPrimary,
                              fontSize: 18)),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    const Icon(
                      FontAwesomeIcons.angleRight,
                      size: 20,
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(),
              ),
              InkWell(
                onTap: () =>
                    Get.to(ChangeNotifierProvider<FPNRequestListProvider>(
                        create: (_) => FPNRequestListProvider(),
                        child: const FPNRequestListScreen(
                          requestType: "Pending",
                          isButtonsVisible: true,
                        ))),
                child: Row(
                  children: [
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                          border: Border.all(color: FColors.light),
                          borderRadius: BorderRadius.circular(30),
                          color: FColors.light,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[400]!,
                                blurRadius: 3.0,
                                blurStyle: BlurStyle.normal),
                          ]),
                      padding: const EdgeInsets.all(8),
                      child: Image.asset(
                        'assets/images/approval.png',
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Text('Pending For Approval',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: FColors.textPrimary,
                              fontSize: 18)),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    const Icon(
                      FontAwesomeIcons.angleRight,
                      size: 20,
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(),
              ),
              InkWell(
                onTap: () async {
                  HelperFunctions.confirmAlert(
                          "Confirm", "Are you sure you want to logout?")
                      .then((value) {
                    if (value == "Yes") {
                      GlobalVariables.isRequestType = 'FPN';
                      Provider.of<LoginProvider>(context, listen: false)
                          .fpnLogout(fpnlogoutJson)
                          .then((value) async {
                        if (value.returnStatus == 2) {
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString("accessToken", "");
                          exit(0);
                        }
                      });
                    } else {}
                  });
                },
                child: Row(
                  children: [
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                          border: Border.all(color: FColors.light),
                          borderRadius: BorderRadius.circular(30),
                          color: FColors.light,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[400]!,
                                blurRadius: 3.0,
                                blurStyle: BlurStyle.normal),
                          ]),
                      padding: const EdgeInsets.all(8),
                      child: Image.asset(
                        'assets/images/logout.png',
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Text('Sign Out',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: FColors.textPrimary,
                              fontSize: 18)),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    const Icon(
                      FontAwesomeIcons.angleRight,
                      size: 20,
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
