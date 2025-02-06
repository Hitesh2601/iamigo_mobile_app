import 'dart:io';

import 'package:push_notification/features/iCart/providers/icart_dashboard_provider.dart';
import 'package:push_notification/features/iCart/screens/dashboard/icart_dashboard_screen.dart';
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

class ICartMenusWidget extends StatelessWidget {
  const ICartMenusWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var icartlogoutJson = {
      "RegObj": {
        "UserId": GlobalVariables.userName,
      }
    };
    print(
        'GlobalVariables.iCartUserProfile ${GlobalVariables.iCartUserProfile}');
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  GlobalVariables.isRequestType = 'iCart';
                  Provider.of<LoginProvider>(context, listen: false)
                      .icartLogout(icartlogoutJson)
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
                    Get.to(ChangeNotifierProvider<ICartDashboardProvider>(
                  create: (_) => ICartDashboardProvider(),
                  child: ICartDashboardScreen(
                    userProfile: GlobalVariables.iCartUserProfile!,
                  ),
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
                onTap: () async {
                  HelperFunctions.confirmAlert(
                          "Confirm", "Are you sure you want to logout?")
                      .then((value) {
                    if (value == "Yes") {
                      GlobalVariables.isRequestType = 'iCart';
                      Provider.of<LoginProvider>(context, listen: false)
                          .icartLogout(icartlogoutJson)
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
