import 'dart:async';
import 'package:push_notification/features/user/providers/home_provider.dart';
import 'package:push_notification/features/user/screens/home/home_screen.dart';
import 'package:push_notification/utility/authentication/authenticator.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/user/screens/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      authenticateUser();
    });
  }

  Future<void> authenticateUser() async {
    bool success = false;

    String? accessToken;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    while (!success) {
      try {
        accessToken = prefs.getString("accessToken");
        print(accessToken);
        if (HelperFunctions.isNullorEmpty(accessToken)) {
          accessToken = await MsalAuthService().authenticateWithMicrosoft();
        }
        if (!HelperFunctions.isNullorEmpty(accessToken)) {
          bool isValid = await MsalAuthService().vaidateToken(accessToken!);
          if (isValid) {
            success = true;
            await loginSuccess(accessToken, prefs);
          } else {
            accessToken = await MsalAuthService().authenticateWithMicrosoft();

            success = true;
            await loginSuccess(accessToken!, prefs);
          }
        }
        // await Authenticator.loadAccount();
      } catch (e) {}
    }
  }

  Future<void> loginSuccess(String accessToken, SharedPreferences prefs) async {
    GlobalVariables.version = await HelperFunctions.getVersion();
    await MsalAuthService().fetchUserData(accessToken!);

    String? username = prefs.getString("username");

    var iMEICODE = await HelperFunctions.getUniqueIdentifier();
    GlobalVariables.userName = username ?? "";
    GlobalVariables.iMEICODE = iMEICODE;
    Get.offAll(ChangeNotifierProvider<HomeProvider>(
      create: (_) => HomeProvider(),
      child: const HomeScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(0),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/splash.png'),
                  fit: BoxFit.cover)),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
        )
      ],
    ));
  }
}
