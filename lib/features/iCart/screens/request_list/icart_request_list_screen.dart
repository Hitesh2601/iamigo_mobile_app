import 'package:push_notification/common/widgets/background_screen.dart';
import 'package:push_notification/common/widgets/no_data_found_widget.dart';
import 'package:push_notification/common/widgets/somthing_went_wrong.dart';
import 'package:push_notification/features/iApproval/screens/dashboard/widget/header_widget.dart';
import 'package:push_notification/features/iCart/models/icart_request_response.dart';
import 'package:push_notification/features/iCart/providers/icart_filter_provider.dart';
import 'package:push_notification/features/iCart/providers/icart_request_list_provider.dart';
import 'package:push_notification/features/iCart/screens/request_list/hardware/hardware_request_screen.dart';
import 'package:push_notification/features/iCart/screens/request_list/software/software_request_screen.dart';
import 'package:push_notification/utility/constants/colors.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class ICartRequestListScreen extends StatefulWidget {
  final String requestType;
  final String profile;
  const ICartRequestListScreen(
      {required this.requestType, required this.profile, super.key});

  @override
  State<ICartRequestListScreen> createState() => ICartRequestListScreenState();
}

class ICartRequestListScreenState extends State<ICartRequestListScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _pageLoad = true;
  bool _hwCheck = true;
  Future<ICartRequestsResponse>? _myFuture;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _myFuture = getRequestListData();
  }

  Future<ICartRequestsResponse> getRequestListData() async {
    var res =
        await Provider.of<ICartRequestListProvider>(context, listen: false)
            .getRequestListData({
      "RegObj": {
        "UserId": GlobalVariables.userName,
        "RequestStatus": widget.requestType,
        "Profile": widget.profile,
        "HardwareReqParams": {
          "HardwarePageNo": "0",
          "filter": {
            "Unit": "",
            "HardwareRequestType": "",
            "UnitSpecification": null
          }
        },
        "SoftwareReqParams": {
          "SoftwarePageNo": "0",
          "filter": {"SoftwareRequestType": "", "Software": ""}
        }
      }
    });
    return res;
  }

  @override
  Widget build(BuildContext context) {
    // final double bPadding = MediaQuery.of(context).padding.bottom;
    return Scaffold(
        backgroundColor: FColors.light,
        body: LoaderOverlay(
          useDefaultLoading: false,
          overlayColor: Colors.black.withOpacity(0.1),
          overlayWidgetBuilder: (_) {
            //ignored progress for the moment
            return Center(
              child: LoadingAnimationWidget.discreteCircle(
                color: FColors.textHeader,
                secondRingColor: FColors.textHeader,
                thirdRingColor: const Color(0xFFEA3799),
                size: 50,
              ),
            );
          },
          child: Stack(
            children: [
              BackgrounScreenWidget(
                height: 200,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
                    child: HeaderWidget(
                      title: '${widget.requestType} Requests',
                      icon: "back",
                      iconColor: Colors.white,
                    ),
                  ),
                  Consumer<ICartFilterProvider>(
                      builder: (context, filterNotifier, _) {
                    if (_pageLoad) {
                      filterNotifier.clearSelection();
                      _pageLoad = false;
                    }
                    return FutureBuilder(
                      future: _myFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          context.loaderOverlay.show();
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          context.loaderOverlay.hide();
                          if (snapshot.hasError) {
                            return const NoDataFountWidget();
                          } else if (snapshot.hasData) {
                            var data = snapshot.data as ICartRequestsResponse;
                            if (data.returnStatus == 3) {
                              return const NoDataFountWidget();
                            } else if (data.returnStatus == 2) {
                              return Consumer<ICartRequestListProvider>(
                                  builder: (context, provider, child) {
                                var isPending =
                                    widget.requestType.contains("Pending");
                                var hardwareText = "Hardware";
                                if (provider.hardware.requestListHardware !=
                                        null &&
                                    provider.hardware.requestListHardware!
                                        .isNotEmpty) {
                                  hardwareText =
                                      '$hardwareText (${provider.hardware.totalCount})';
                                }
                                var softwareText = "Software";
                                if (provider.software.requestListSoftware !=
                                        null &&
                                    provider.software.requestListSoftware!
                                        .isNotEmpty) {
                                  softwareText =
                                      '$softwareText (${provider.software.totalCount})';
                                  if (provider.hardware.requestListHardware ==
                                          null ||
                                      !provider.hardware.requestListHardware!
                                          .isNotEmpty) {
                                    if (_hwCheck) {
                                      _tabController.animateTo(1);
                                    }
                                  }
                                }
                                _hwCheck = false;
                                return Column(
                                  children: [
                                    TabBar(
                                      controller: _tabController,
                                      labelColor: Colors.white,
                                      unselectedLabelColor: Colors.white70,
                                      indicatorSize: TabBarIndicatorSize.tab,
                                      indicatorPadding:
                                          const EdgeInsets.all(5.0),
                                      indicatorColor: Colors.white,
                                      tabs: <Widget>[
                                        Tab(
                                          text: hardwareText,
                                        ),
                                        Tab(
                                          text: softwareText,
                                        )
                                      ],
                                    ),
                                    SingleChildScrollView(
                                      child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height -
                                                165,
                                        child: TabBarView(
                                          controller: _tabController,
                                          children: <Widget>[
                                            HardwareRequestScreen(
                                              isPending: isPending,
                                              hardwareFilter:
                                                  provider.hardwareFilter!,
                                              profile: widget.profile,
                                              requestType: widget.requestType,
                                            ),
                                            SoftwareRequestScreen(
                                              isPending: isPending,
                                              softwareFilter:
                                                  provider.softwareFilter!,
                                              profile: widget.profile,
                                              requestType: widget.requestType,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
                            } else if (data.returnStatus == 1) {
                              return const SomthingWentWrongWidget();
                            }
                          }
                        }
                        return const SizedBox();
                      },
                    );
                  }),
                ],
              ),
            ],
          ),
        ));
  }
}
