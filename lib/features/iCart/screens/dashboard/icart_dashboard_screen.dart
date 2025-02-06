import 'package:push_notification/common/widgets/background_screen.dart';
import 'package:push_notification/common/widgets/no_data_found_widget.dart';
import 'package:push_notification/features/iApproval/screens/dashboard/widget/header_widget.dart';
import 'package:push_notification/features/iCart/models/icart_dashboard_response.dart';
import 'package:push_notification/features/iCart/providers/icart_dashboard_provider.dart';
import 'package:push_notification/features/iCart/providers/icart_request_list_provider.dart';
import 'package:push_notification/features/iCart/screens/request_list/icart_request_list_screen.dart';
import 'package:push_notification/utility/constants/colors.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:push_notification/utility/constants/session.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class ICartDashboardScreen extends StatefulWidget {
  const ICartDashboardScreen({super.key, required this.userProfile});
  final List<String> userProfile;
  @override
  State<ICartDashboardScreen> createState() => _ICartDashboardScreenState();
}

class _ICartDashboardScreenState extends State<ICartDashboardScreen> {
  Future<ICartDashboardResponse>? _myFuture;
  @override
  void initState() {
    super.initState();
    SessionManagement.init();
    _myFuture = getDashboardData();
  }

  Future<ICartDashboardResponse> getDashboardData() async {
    var res = await Provider.of<ICartDashboardProvider>(context, listen: false)
        .getDashboardData({
      "RegObj": {
        "UserId": GlobalVariables.userName,
        "UserProfile": widget.userProfile
      }
    });
    return res;
  }

  @override
  Widget build(BuildContext context) {
    // final double bPadding = MediaQuery.of(context).padding.bottom;
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
            child: Stack(children: [
              BackgrounScreenWidget(
                height: 85,
              ),
              Column(
                children: [
                  const HeaderWidget(
                    title: "Dashboard",
                    icon: "home",
                    iconColor: Colors.white,
                  ),
                  FutureBuilder(
                    future: _myFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        context.loaderOverlay.show();
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        context.loaderOverlay.hide();
                        if (snapshot.hasError) {
                          return const NoDataFountWidget();
                        } else if (snapshot.hasData) {
                          var data = snapshot.data as ICartDashboardResponse;
                          if (data.returnStatus == 3) {
                            return const NoDataFountWidget();
                          } else if (data.returnStatus == 2) {
                            return Consumer<ICartDashboardProvider>(
                              builder: (context, provider, child) {
                                var dataItem = provider.dashboardData;

                                return Expanded(
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: dataItem.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: const EdgeInsets.fromLTRB(
                                                12, 12, 0, 12),
                                            child: Text(
                                                dataItem[index].profile! ==
                                                        "User"
                                                    ? 'My Approvals'
                                                    : '${dataItem[index].profile!} Requests',
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700,
                                                    color:
                                                        FColors.textPrimary)),
                                          ),
                                          getRequestStack(
                                              context,
                                              dataItem[index].pending!,
                                              "Pending",
                                              FColors.pendingiCartDark,
                                              FColors.pendingiCartLight,
                                              FColors.pendingiCartMedium,
                                              dataItem[index].profile!,
                                              FontAwesomeIcons.userClock),
                                          getRequestStack(
                                              context,
                                              dataItem[index].approved!,
                                              "Approved",
                                              FColors.approvediCartDark,
                                              FColors.approvediCartLight,
                                              FColors.approvediCartMedium,
                                              dataItem[index].profile!,
                                              FontAwesomeIcons.userCheck),
                                          getRequestStack(
                                              context,
                                              dataItem[index].rejected!,
                                              "Rejected",
                                              FColors.rejectediCartDark,
                                              FColors.rejectedLight,
                                              FColors.rejectediCartMedium,
                                              dataItem[index].profile!,
                                              FontAwesomeIcons.userXmark),
                                          (dataItem[index].delegatedPending !=
                                                  0)
                                              ? getRequestStack(
                                                  context,
                                                  dataItem[index]
                                                      .delegatedPending!,
                                                  "Delegated",
                                                  FColors.delegiCartDark,
                                                  FColors.feedbackLight,
                                                  FColors.delegiCartMedium,
                                                  dataItem[index].profile!,
                                                  FontAwesomeIcons.users)
                                              : const SizedBox()
                                        ]),
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          } else {
                            HelperFunctions.showAlert(
                                "AMIGO", data.responseMessage!);
                          }
                        }
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ]),
          )),
    );
  }

  // Request panel widget
  Padding getRequestStack(
      BuildContext contextfinal,
      int countData,
      String cardTitle,
      Color darkColor,
      Color lightColor,
      Color midColor,
      String profile,
      IconData icon) {
    //var color = darkColor;
    darkColor = Colors.black;
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: InkWell(
        onTap: () async {
          await Get.to(ChangeNotifierProvider<ICartRequestListProvider>(
              create: (_) => ICartRequestListProvider(),
              child: ICartRequestListScreen(
                requestType:
                    cardTitle == "Delegated" ? "DelegatedPending" : cardTitle,
                profile: profile,
              )));
          context.loaderOverlay.show();
          await context.read<ICartDashboardProvider>().getDashboardData({
            "RegObj": {
              "UserId": GlobalVariables.userName,
              "UserProfile": widget.userProfile
            }
          });
          context.loaderOverlay.hide();
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 10, 10, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Card(
                                color: midColor,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child:
                                      Icon(icon, size: 25, color: Colors.white),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(left: 14.0),
                              child: Text(
                                cardTitle != "Delegated"
                                    ? '$cardTitle Requests'
                                    : '$cardTitle Pending',
                                style: TextStyle(
                                  color: darkColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Card(
                          color: midColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                '$countData',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
