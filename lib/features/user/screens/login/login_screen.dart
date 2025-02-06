// ignore_for_file: prefer_const_constructors

import 'package:push_notification/common/widgets/background_screen.dart';
import 'package:push_notification/features/user/screens/login/widget/login_form_widget.dart';
import 'package:push_notification/utility/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FColors.light,
      body: LoaderOverlay(
        useDefaultLoading: false,
        overlayWidgetBuilder: (_) {
          return Container(
            alignment: Alignment.center,
            child: Card(
              color: Colors.white,
              child: SizedBox(
                height: 160,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoadingAnimationWidget.discreteCircle(
                      color: FColors.textHeader,
                      secondRingColor: FColors.textHeader,
                      thirdRingColor: const Color(0xFFEA3799),
                      size: 50,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(50, 20, 50, 10),
                      child: Text(
                        "authenticating user. please wait...",
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        overlayColor: Colors.black.withOpacity(0.6),
        child: SingleChildScrollView(
          child: Stack(
            children: [BackgrounScreenWidget(), LoginFormWidget()],
          ),
        ),
      ),
    );
  }
}
