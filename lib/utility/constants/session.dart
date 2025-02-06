import 'dart:async';

import 'package:push_notification/features/user/providers/home_provider.dart';
import 'package:push_notification/features/user/screens/home/home_screen.dart';
import 'package:push_notification/utility/constants/colors.dart';
import 'package:push_notification/utility/constants/global_methods.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SessionManagement {
  static Timer? timer;
  static void init() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      GlobalVariables.secondsLeft--;
    });
  }

  static void checkSession(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent));
    if (Get.currentRoute == '/LoginScreen') {
      if (timer != null) {
        timer!.cancel();
        GlobalVariables.secondsLeft = GlobalVariables.sessionTime;
      }
    } else if (Get.currentRoute == '/HomeScreen') {
      if (timer != null) {
        timer!.cancel();
        GlobalVariables.secondsLeft = GlobalVariables.sessionTime;
      }
    } else {
      if (GlobalVariables.secondsLeft <= 0) {
        expireUserSession();
      } else {
        ///*****************************
        // Update Timer again in seconds
        ///*****************************
        GlobalVariables.secondsLeft = GlobalVariables.sessionTime;
      }
    }
  }

  static void expireUserSession() {
    ///*****************************
    // Show snackbar for session time out
    ///*****************************
    Get.rawSnackbar(
        borderRadius: 8,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        backgroundColor: FColors.rejectedDark,
        message: 'Your session is expired!');

    ///*****************************
    ///Do LogOut
    ///*****************************
    GlobalMethods.doLogout(GlobalVariables.isRequestType);

    ///*****************************
    // Navigate to Home Screen
    ///*****************************

    Get.offAll(() => ChangeNotifierProvider<HomeProvider>(
          create: (_) => HomeProvider(),
          child: const HomeScreen(),
        ));

    ///*****************************
    // Stop Timer and reset
    ///*****************************
    timer!.cancel();
    GlobalVariables.secondsLeft = GlobalVariables.sessionTime;
  }
}

// class CurrentScreen {
//   static String _currentScreenName = '/';
//   void updateScreenName(String newScreenName) {
//     _currentScreenName = newScreenName;
//   }

//   static String get currentScreenName => _currentScreenName;
// }

// class Route{
//   static Route<dynamic> generateRoute(RouteSettings settings){
//     switch (settings.name){
//       case '/':
//       return MaterialPageRoute(builder: (context)=>const LoginScreen());
//     }
//   }
// }
