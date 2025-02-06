import 'dart:io';

import 'package:push_notification/features/user/providers/home_provider.dart';
import 'package:push_notification/features/user/screens/home/widget/custom_shape_widget.dart';
import 'package:push_notification/features/user/screens/home/widget/home_background_widget.dart';
import 'package:push_notification/features/user/screens/home/widget/home_log_out_widget.dart';
import 'package:push_notification/features/user/screens/home/widget/profile_widget.dart';
import 'package:push_notification/features/user/screens/home/widget/user_applications_widget.dart';
import 'package:push_notification/utility/constants/colors.dart';
import 'package:push_notification/utility/constants/sizes.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await HelperFunctions.showExitDialog(context) ?? false;
      },
      child: Scaffold(
          backgroundColor: FColors.light,
          body: LoaderOverlay(
            useDefaultLoading: false,
            overlayWidgetBuilder: (_) {
              return Center(
                child: LoadingAnimationWidget.discreteCircle(
                  color: FColors.textHeader,
                  secondRingColor: FColors.textHeader,
                  thirdRingColor: const Color(0xFFEA3799),
                  size: 50,
                ),
              );
            },
            overlayColor: Colors.black.withOpacity(0.1),
            child: Stack(
              children: [
                const HomeBackgroundWidget(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 70, 20, 10),
                  child: Column(
                    children: [
                      Consumer<HomeProvider>(builder: (context, value, child) {
                        // Display user details
                        return ProfileWidget(
                          userDetails: value.userDetails,
                        );
                      }),
                      const Stack(children: [
                        //displays white background shape
                        CustomShapeWidget(),

                        //displays user icons
                        UserApplications(),

                        //log out button
                        HomeLogOutButtonWidget(),
                      ]),
                      FutureBuilder(
                          future:
                              context.read<HomeProvider>().getPendingCount(),
                          builder: (context, snapshot) {
                            try {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                context.loaderOverlay.show();
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                context.loaderOverlay.hide();
                                return SizedBox(
                                  height: 0,
                                );
                              }
                            } catch (e) {
                              //HelperFunctions.showAsyncAlert("Error", '$e');
                              if (context.loaderOverlay.visible) {
                                context.loaderOverlay.hide();
                              }
                            }
                            return Container();
                          }),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 80),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'Note: Please authenticate on zscaler to use iAmigo application',
                      style: TextStyle(
                          color: FColors.textWhite,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
