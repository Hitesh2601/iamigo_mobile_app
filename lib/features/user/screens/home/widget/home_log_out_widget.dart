import 'dart:io';

import 'package:push_notification/features/user/screens/login/login_screen.dart';
import 'package:push_notification/splash_screen.dart';
import 'package:push_notification/utility/constants/colors.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeLogOutButtonWidget extends StatelessWidget {
  const HomeLogOutButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35, right: 45),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[400]!,
                      blurRadius: 3.0,
                      blurStyle: BlurStyle.normal),
                ]),
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(30),
                  color: FColors.textHeader,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[400]!,
                        blurRadius: 3.0,
                        blurStyle: BlurStyle.normal),
                  ]),
              child: IconButton(
                color: FColors.textHeader,
                padding: EdgeInsets.zero,
                iconSize: 30,
                icon: const Icon(FontAwesomeIcons.powerOff,
                    color: FColors.textWhite),
                onPressed: () {
                  HelperFunctions.confirmAlert(
                          "Confirm", "Are you sure you want to logout?")
                      .then((value) async {
                    if (value == "Yes") {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString("accessToken", "");
                      exit(0);
                    }
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
