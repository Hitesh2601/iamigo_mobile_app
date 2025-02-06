import 'package:push_notification/features/iApproval/screens/dashboard/widget/header_widget.dart';
import 'package:push_notification/features/user/screens/master/widget/fpn_menus_widget.dart';
import 'package:push_notification/features/user/screens/master/widget/home_menu_widget.dart';
import 'package:push_notification/features/user/screens/master/widget/icart_menus_widget.dart';
import 'package:push_notification/features/user/screens/master/widget/isac_menus_widget.dart';
import 'package:push_notification/features/user/screens/master/widget/profile_card_widget.dart';
import 'package:push_notification/utility/constants/colors.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:flutter/material.dart';

class MasterPageScreen extends StatelessWidget {
  const MasterPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FColors.light,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              const HeaderWidget(
                title: "",
                icon: "back",
                iconColor: FColors.textHeader,
              ),
              const ProfileCard(),
              const HomeMenuWidget(),
              //FPNMenusWidget(),
              getMenus(),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Version ${GlobalVariables.version}',
                )),
          )
        ],
      ),
    );
  }

  StatelessWidget getMenus() {
    if (GlobalVariables.isRequestType == "FPN") {
      return const FPNMenusWidget();
    }
    if (GlobalVariables.isRequestType == "iSAC") {
      return const ISACMenusWidget();
    }
    if (GlobalVariables.isRequestType == "iCart") {
      return const ICartMenusWidget();
    }
    return const ISACMenusWidget();
  }
}
