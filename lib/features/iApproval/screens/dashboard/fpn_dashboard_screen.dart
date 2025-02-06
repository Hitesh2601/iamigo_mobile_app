import 'package:push_notification/common/widgets/background_screen.dart';
import 'package:push_notification/features/iApproval/models/fpn_dashboard_response.dart';
import 'package:push_notification/features/iApproval/providers/fpn_dashboard_provider.dart';
import 'package:push_notification/features/iApproval/screens/dashboard/widget/fpn_progress_card_widget.dart';
import 'package:push_notification/features/iApproval/screens/dashboard/widget/fpn_small_card.dart';
import 'package:push_notification/features/iApproval/screens/dashboard/widget/header_widget.dart';
import 'package:push_notification/utility/constants/colors.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:push_notification/utility/constants/session.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class FPNDashboardScreen extends StatefulWidget {
  const FPNDashboardScreen({super.key});

  @override
  State<FPNDashboardScreen> createState() => _FPNDashboardScreenState();
}

class _FPNDashboardScreenState extends State<FPNDashboardScreen> {
  Future<FpnDashboardResponse>? _myFuture;
  @override
  void initState() {
    super.initState();
    SessionManagement.init();
    _myFuture = getDashboardData();
  }

  Future<FpnDashboardResponse> getDashboardData() async {
    var res = await Provider.of<FPNDashboardProvider>(context, listen: false)
        .getDashboardData({"UserId": GlobalVariables.userName});
    return res;
  }

  @override
  Widget build(BuildContext context) {
    //final double bPadding = MediaQuery.of(context).padding.bottom;
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
                BackgrounScreenWidget(
                  height: 300,
                ),
                const HeaderWidget(
                  title: "Dashboard",
                  icon: "home",
                  iconColor: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 75.0),
                  child: SingleChildScrollView(
                      child: FutureBuilder(
                          future: _myFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              context.loaderOverlay.show();
                            } else if (snapshot.connectionState ==
                                ConnectionState.done) {
                              context.loaderOverlay.hide();
                              if (snapshot.hasError) {
                                return const Text("No Data Found");
                              } else if (snapshot.hasData) {
                                return Consumer<FPNDashboardProvider>(
                                    builder: (context, value, child) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FPNProgressCardWidget(
                                        countData: value
                                            .dashboardData.fpnPendingCount!,
                                        count: value.pendingPercent,
                                        cardTitle: "Pending For Approval",
                                        cardType: "Pending",
                                      ),
                                      FPNProgressCardWidget(
                                        countData: value
                                            .dashboardData.fpnFeedbackCount!,
                                        count: value.feedbackPercent,
                                        cardTitle: "Feedback Approval Request",
                                        cardType: "Feedback",
                                      ),
                                      FPNSmallCard(
                                        countData: value
                                            .dashboardData.fpnAuthorizedCount!,
                                        cardTitle: "Approved Request",
                                        cardType: "Approved",
                                      ),
                                      FPNSmallCard(
                                        countData: value
                                            .dashboardData.fpnRejectedCount!,
                                        cardTitle: "Rejected Request",
                                        cardType: "Rejected",
                                      ),
                                      FPNSmallCard(
                                        countData:
                                            value.dashboardData.fpnLockedCount!,
                                        cardTitle: "Locked Request",
                                        cardType: "Locked",
                                      )
                                    ],
                                  );
                                });
                              }
                            }
                            return const SizedBox();
                          })),
                )
              ],
            ),
          )),
    );
  }
}
