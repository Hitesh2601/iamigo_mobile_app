// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unrelated_type_equality_checks, deprecated_member_use, dead_code, unused_field, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, avoid_types_as_parameter_names, prefer_final_fields, prefer_const_declarations, unnecessary_import, unused_element, unnecessary_cast
//import 'dart:html';

//import 'dart:async';

import 'dart:convert';

import 'package:push_notification/common/widgets/background_screen.dart';
import 'package:push_notification/features/iApproval/screens/dashboard/widget/header_widget.dart';
import 'package:push_notification/features/iSAC/models/isac_dashboard_response.dart';
import 'package:push_notification/features/iSAC/providers/isac_provider.dart';
import 'package:push_notification/features/iSAC/screens/request_list/isac_request_list.dart';
import 'package:push_notification/features/iSAC/screens/vendorcode_req_list/vendorcode_req_list.dart';
import 'package:push_notification/features/iSAC/screens/vendoronboarding_req_list/vendoronboarding_req_list.dart';
import 'package:push_notification/features/user/providers/home_provider.dart';
import 'package:push_notification/features/user/screens/home/home_screen.dart';
import 'package:push_notification/utility/constants/colors.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:push_notification/utility/constants/session.dart';
import 'package:push_notification/utility/constants/url_configuration.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:push_notification/utility/network/http_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class ISACDashboardScreen extends StatefulWidget {
  const ISACDashboardScreen({super.key});

  @override
  State<ISACDashboardScreen> createState() => _ISACDashboard();
}

class _ISACDashboard extends State<ISACDashboardScreen> {
  late TextEditingController pendingCountController = TextEditingController();
  TextEditingController approvedCountController = TextEditingController();
  TextEditingController rejectedCountController = TextEditingController();
  TextEditingController selectedRoleController =
      TextEditingController(text: 'Supervisor');

  final ScrollController _scrollController = ScrollController();

  late int _selectedIndex = 1;
  Future<IsacDashboardResponse>? _myFuture;
  @override
  void dispose() {
    super.dispose();
    pendingCountController.dispose();
    approvedCountController.dispose();
    rejectedCountController.dispose();
    selectedRoleController.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
  }

  @override
  void initState() {
    super.initState();
    SessionManagement.init();
    _myFuture = getDashboardData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollListener();
      } // Initialize arrow visibility based on initial position
    });
  }

  Future<IsacDashboardResponse> getDashboardData() async {
    var res = await Provider.of<ISACProvider>(context, listen: false)
        .getDashboardData({});
    return res;
  }

  void _scrollListener() {
    if (_scrollController.hasClients) {
      final scrollProvider =
          Provider.of<ScrollProvider>(context, listen: false);
      final maxScrollExtent = _scrollController.position.maxScrollExtent;
      final offset = _scrollController.offset;
      final viewportWidth = MediaQuery.of(context).size.width;

      scrollProvider.updateScrollPosition(
          offset, maxScrollExtent, viewportWidth);

      final scrollPositonNotifier =
          Provider.of<ScrollPositonNotifier>(context, listen: false);
      scrollPositonNotifier.updateIndicators(offset, viewportWidth);
    }
  }

  void _scrollLeft() {
    if (_scrollController.hasClients) {
      _scrollController
          .animateTo(
        _scrollController.offset - 142, // Adjust this value as needed
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      )
          .then((_) {
        _scrollListener();
      });
    }
  }

  void _scrollRight() {
    if (_scrollController.hasClients) {
      _scrollController
          .animateTo(
        _scrollController.offset + 142, // Adjust this value as needed
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      )
          .then((_) {
        _scrollListener();
      });
    }
  }

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
            child: FutureBuilder(
                future: _myFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    context.loaderOverlay.show();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    context.loaderOverlay.hide();
                    if (snapshot.hasError) {
                      return const Text("No Data Found");
                    } else if (snapshot.hasData) {
                      return Consumer<ISACProvider>(
                          builder: (context, provider, child) {
                        var response = provider.dashboardData;
                        DashboardData countData = DashboardData();
                        countData = response.dashboardData!;
                        if (selectedRoleController.text == "Supervisor") {
                          pendingCountController.text = countData
                              .supervisorPendingRequestsCount
                              .toString();
                          approvedCountController.text = countData
                              .supervisorApprovedRequestsCount
                              .toString();
                          rejectedCountController.text = countData
                              .supervisorRejectedRequestsCount
                              .toString();
                        }
                        if (selectedRoleController.text ==
                            "Business Approver") {
                          pendingCountController.text = countData
                              .businessOwnerPendingRequestsCount
                              .toString();
                          approvedCountController.text = countData
                              .businessOwnerApprovedRequestsCount
                              .toString();
                          rejectedCountController.text = countData
                              .businessOwnerRejectedRequestsCount
                              .toString();
                        }
                        if (selectedRoleController.text == "Generic ID Owner") {
                          pendingCountController.text = countData
                              .genericIDOwnerPendingRequestsCount
                              .toString();
                          approvedCountController.text = countData
                              .genericIDOwnerApprovedRequestsCount
                              .toString();
                          rejectedCountController.text = countData
                              .genericIDOwnerRejectedRequestsCount
                              .toString();
                        }
                        if (selectedRoleController.text ==
                            "Vendor Onboarding") {
                          pendingCountController.text = countData
                              .vendorOnboardingPendingRequestsCount
                              .toString();
                          approvedCountController.text = countData
                              .vendorOnboardingApprovedRequestsCount
                              .toString();
                          rejectedCountController.text = countData
                              .vendorCodeRejectedRequestsCount
                              .toString();
                        }
                        if (selectedRoleController.text == "Vendor Code") {
                          pendingCountController.text = countData
                              .vendorCodePendingRequestsCount
                              .toString();
                          approvedCountController.text = countData
                              .vendorCodeApprovedRequestsCount
                              .toString();
                          rejectedCountController.text = countData
                              .vendorCodeRejectedRequestsCount
                              .toString();
                        }

                        return Stack(children: [
                          BackgrounScreenWidget(
                            height: 350,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    HeaderWidget(
                                      title: "Dashboard",
                                      icon: "home",
                                      iconColor: Colors.white,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 230,
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 241, 240, 240),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 15.0,
                                                blurStyle: BlurStyle.outer,
                                                spreadRadius: 8,
                                                offset: Offset(0.0, 0.75),
                                                color: FColors.shadowcolor,
                                              ),
                                            ]),
                                        child: NotificationListener<
                                            ScrollNotification>(
                                          onNotification:
                                              (ScrollNotification scrollInfo) {
                                            _scrollListener();
                                            return true;
                                          },
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Column(
                                              children: [
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  //controller: scrollController,
                                                  controller: _scrollController,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SupervisorContainerData(
                                                        selectedRoleController:
                                                            selectedRoleController,
                                                        pendingCountController:
                                                            pendingCountController,
                                                        approvedCountController:
                                                            approvedCountController,
                                                        rejectedCountController:
                                                            rejectedCountController,
                                                        countData: countData,
                                                      ),
                                                      VendorOnboardingContainer(
                                                        selectedRoleController:
                                                            selectedRoleController,
                                                        pendingCountController:
                                                            pendingCountController,
                                                        approvedCountController:
                                                            approvedCountController,
                                                        rejectedCountController:
                                                            rejectedCountController,
                                                        countData: countData,
                                                      ),
                                                      BusinessContainer(
                                                        selectedRoleController:
                                                            selectedRoleController,
                                                        pendingCountController:
                                                            pendingCountController,
                                                        approvedCountController:
                                                            approvedCountController,
                                                        rejectedCountController:
                                                            rejectedCountController,
                                                        countData: countData,
                                                      ),
                                                      VendorCodeContainer(
                                                        selectedRoleController:
                                                            selectedRoleController,
                                                        pendingCountController:
                                                            pendingCountController,
                                                        approvedCountController:
                                                            approvedCountController,
                                                        rejectedCountController:
                                                            rejectedCountController,
                                                        countData: countData,
                                                      ),
                                                      GenericIDOwnerContainer(
                                                        selectedRoleController:
                                                            selectedRoleController,
                                                        pendingCountController:
                                                            pendingCountController,
                                                        approvedCountController:
                                                            approvedCountController,
                                                        rejectedCountController:
                                                            rejectedCountController,
                                                        countData: countData,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // SizedBox(
                                                //   height: 1,
                                                // ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Consumer<ScrollProvider>(
                                                      builder: (context,
                                                          scrollProvider,
                                                          child) {
                                                        return Visibility(
                                                          visible: scrollProvider
                                                              .showLeftArrow,
                                                          child: IconButton(
                                                            icon: Icon(
                                                                FontAwesomeIcons
                                                                    .circleChevronLeft,
                                                                color: FColors
                                                                    .textHeader,
                                                                size: 20),
                                                            onPressed: scrollProvider
                                                                    .showLeftArrow
                                                                ? _scrollLeft
                                                                : null,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                    Consumer<
                                                        ScrollPositonNotifier>(
                                                      builder: (context,
                                                          scrollPositonNotifier,
                                                          child) {
                                                        return Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children:
                                                              List.generate(5,
                                                                  (index) {
                                                            return Container(
                                                              margin: EdgeInsets
                                                                  .all(1),
                                                              child:
                                                                  CircleAvatar(
                                                                radius: 5,
                                                                backgroundColor: scrollPositonNotifier
                                                                            .visibleIndicator[
                                                                        index]
                                                                    ? FColors
                                                                        .textHeader
                                                                    : FColors
                                                                        .rolepanelcolor,
                                                              ),
                                                            );
                                                          }),
                                                        );
                                                      },
                                                    ),
                                                    Consumer<ScrollProvider>(
                                                      builder: (context,
                                                          scrollProvider,
                                                          child) {
                                                        return Visibility(
                                                          visible: scrollProvider
                                                              .showRightArrow,
                                                          child: IconButton(
                                                            icon: Icon(
                                                                FontAwesomeIcons
                                                                    .circleChevronRight,
                                                                color: FColors
                                                                    .textHeader,
                                                                size: 20),
                                                            onPressed: scrollProvider
                                                                    .showRightArrow
                                                                ? _scrollRight
                                                                : null,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: BottomContainer(
                                            selectedRoleController:
                                                selectedRoleController,
                                            pendingCountController:
                                                pendingCountController,
                                            approvedCountController:
                                                approvedCountController,
                                            rejectedCountController:
                                                rejectedCountController)),
                                    SizedBox(
                                      height: 18,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.to(ChangeNotifierProvider<
                                                  HomeProvider>(
                                                create: (_) => HomeProvider(),
                                                child: HomeScreen(),
                                              ));
                                            },
                                            child: Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: FColors.textWhite),
                                                  borderRadius:
                                                      BorderRadius.circular(70),
                                                  color: FColors.textWhite,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color:
                                                            Colors.grey[400]!,
                                                        blurRadius: 3.0,
                                                        blurStyle:
                                                            BlurStyle.normal),
                                                  ]),
                                              child: Icon(
                                                FontAwesomeIcons
                                                    .circleArrowLeft,
                                                color: FColors.textHeader,
                                                size: 35,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ]),
                            ),
                          )
                        ]);
                      });
                    }
                  }
                  return const CircularProgressIndicator();
                }),
          )),
    );
  }
}

class BottomContainer extends StatelessWidget {
  const BottomContainer(
      {super.key,
      required this.selectedRoleController,
      required this.pendingCountController,
      required this.approvedCountController,
      required this.rejectedCountController});
  final TextEditingController selectedRoleController;
  final TextEditingController pendingCountController;
  final TextEditingController approvedCountController;
  final TextEditingController rejectedCountController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 390,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 241, 240, 240),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              blurRadius: 15.0,
              blurStyle: BlurStyle.outer,
              spreadRadius: 8,
              offset: Offset(0.0, 0.75),
              color: FColors.shadowcolor,
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 2, 8, 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 18,
              child: TextField(
                  controller: selectedRoleController,
                  enableInteractiveSelection: false,
                  enabled: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      height: 1,
                      color: FColors.textPrimary,
                      fontSize: 18)),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 7.0, top: 12.0),
                  child: InkWell(
                    onTap: () async {
                      GlobalVariables.selectedRole =
                          selectedRoleController.text.toString();
                      GlobalVariables.selectedStatus = "Pending";
                      if (selectedRoleController.text.toString() ==
                          "Vendor Onboarding") {
                        await Get.to(VendorOnboardRequestListScreen(
                          requestType: "Pending",
                          isButtonsVisible: true,
                        ));
                      } else if (selectedRoleController.text.toString() ==
                          "Vendor Code") {
                        await Get.to(VendorCodeRequestListScreen(
                          requestType: "Pending",
                          isButtonsVisible: true,
                        ));
                      } else {
                        await Get.to(ISACRequestListScreen(
                          requestType: "Pending",
                          isButtonsVisible: true,
                        ));
                      }
                      await Provider.of<ISACProvider>(context, listen: false)
                          .getDashboardData({});
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.42,
                      height: 300,
                      decoration: BoxDecoration(
                          color: FColors.pendingpanelcolor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, right: 8),
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: FColors.textWhite),
                                    borderRadius: BorderRadius.circular(70),
                                    color: FColors.textWhite,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[400]!,
                                          blurRadius: 3.0,
                                          blurStyle: BlurStyle.normal),
                                    ]),
                                child: Icon(FontAwesomeIcons.hourglassHalf,
                                    color: FColors.roleStatuscolor, size: 30),
                              ),
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 6, bottom: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextField(
                                      controller: pendingCountController,
                                      enableInteractiveSelection: false,
                                      enabled: false,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          height: 1.3,
                                          color: FColors.textPrimary,
                                          fontSize: 40)),
                                  Text("Pending Request",
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: FColors.roleStatuscolor,
                                          fontSize: 18,
                                          height: 1.3)),
                                ],
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 7.0, left: 7.0, top: 12.0),
                  child: Column(children: [
                    InkWell(
                      onTap: () async {
                        GlobalVariables.selectedRole =
                            selectedRoleController.text.toString();
                        GlobalVariables.selectedStatus = "Approved";
                        if (selectedRoleController.text.toString() ==
                            "Vendor Onboarding") {
                          Get.to(VendorOnboardRequestListScreen(
                            requestType: "Approved",
                            isButtonsVisible: false,
                          ));
                        } else if (selectedRoleController.text.toString() ==
                            "Vendor Code") {
                          Get.to(VendorCodeRequestListScreen(
                            requestType: "Approved",
                            isButtonsVisible: false,
                          ));
                        } else {
                          Get.to(ISACRequestListScreen(
                            requestType: "Approved",
                            isButtonsVisible: false,
                          ));
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.42,
                        height: 144,
                        decoration: BoxDecoration(
                            color: FColors.approvedpanelcolor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 4.0, right: 8),
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: FColors.textWhite),
                                      borderRadius: BorderRadius.circular(70),
                                      color: FColors.textWhite,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey[400]!,
                                            blurRadius: 3.0,
                                            blurStyle: BlurStyle.normal),
                                      ]),
                                  child: Icon(FontAwesomeIcons.thumbsUp,
                                      color: FColors.approvetextpanelcolor,
                                      size: 30),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 6, bottom: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    TextField(
                                        controller: approvedCountController,
                                        enableInteractiveSelection: false,
                                        enabled: false,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            height: 1.3,
                                            color: FColors.textPrimary,
                                            fontSize: 25)),
                                    Text("Approved Request",
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color:
                                                FColors.approvetextpanelcolor,
                                            fontSize: 16,
                                            height: 1.3)),
                                  ],
                                ),
                              ),
                            ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 7.0, right: 7.0, left: 7.0),
                      child: InkWell(
                        onTap: () async {
                          GlobalVariables.selectedRole =
                              selectedRoleController.text.toString();
                          GlobalVariables.selectedStatus = "Rejected";
                          if (selectedRoleController.text.toString() ==
                              "Vendor Onboarding") {
                            Get.to(VendorOnboardRequestListScreen(
                              requestType: "Rejected",
                              isButtonsVisible: false,
                            ));
                          } else if (selectedRoleController.text.toString() ==
                              "Vendor Code") {
                            Get.to(VendorCodeRequestListScreen(
                              requestType: "Rejected",
                              isButtonsVisible: false,
                            ));
                          } else {
                            Get.to(ISACRequestListScreen(
                              requestType: "Rejected",
                              isButtonsVisible: false,
                            ));
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.42,
                          height: 144,
                          decoration: BoxDecoration(
                              color: FColors.rejectedpanelcolor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, right: 8),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: FColors.textWhite),
                                        borderRadius: BorderRadius.circular(70),
                                        color: FColors.textWhite,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey[400]!,
                                              blurRadius: 3.0,
                                              blurStyle: BlurStyle.normal),
                                        ]),
                                    child: Icon(FontAwesomeIcons.thumbsDown,
                                        color: FColors.rejecttextpanelcolor,
                                        size: 30),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 6, bottom: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      TextField(
                                          controller: rejectedCountController,
                                          enableInteractiveSelection: false,
                                          enabled: false,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              height: 1.3,
                                              color: FColors.textPrimary,
                                              fontSize: 25)),
                                      Text("Rejected Request",
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color:
                                                  FColors.rejecttextpanelcolor,
                                              fontSize: 16,
                                              height: 1.3)),
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ),
                  ]),
                )
              ],
              // children:Column(

              // ),
            ),
          ],
        ),
      ),
    );
  }
}

class SupervisorContainerData extends StatelessWidget {
  final TextEditingController selectedRoleController;
  final TextEditingController pendingCountController;
  final TextEditingController approvedCountController;
  final TextEditingController rejectedCountController;
  final DashboardData countData;
  //final containerWidth;

  const SupervisorContainerData({
    super.key,
    required this.selectedRoleController,
    required this.pendingCountController,
    required this.approvedCountController,
    required this.rejectedCountController,
    required this.countData,
  }); //   required this.containerWidth

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectedContainerIndex>(
        builder: (context, SelectedContainerIndex, _) => GestureDetector(
              onTap: () {
                SelectedContainerIndex.setSelectedIndex(1);
                pendingCountController.text =
                    countData.supervisorPendingRequestsCount.toString();
                approvedCountController.text =
                    countData.supervisorApprovedRequestsCount.toString();
                rejectedCountController.text =
                    countData.supervisorRejectedRequestsCount.toString();
                selectedRoleController.text = "Supervisor";
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  //duration: Duration(milliseconds: 300),
                  width: 120,
                  height: 150,
                  decoration: BoxDecoration(
                      color: FColors.rolepanelcolor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Container(
                        //duration: Duration(milliseconds: 300),
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: SelectedContainerIndex.SelectedIndex == 1
                                    ? FColors.textHeader
                                    : FColors.textWhite),
                            borderRadius: BorderRadius.circular(70),
                            color: SelectedContainerIndex.SelectedIndex == 1
                                ? FColors.textHeader
                                : FColors.textWhite,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[400]!,
                                  blurRadius: 3.0,
                                  blurStyle: BlurStyle.normal),
                            ]),
                        child: Icon(FontAwesomeIcons.personCircleCheck,
                            color: SelectedContainerIndex.SelectedIndex == 1
                                ? FColors.textWhite
                                : FColors.textHeader,
                            size: 25),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text("Supervisor",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: FColors.textPrimary,
                              height: 1.3,
                              fontSize: 16)),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                              '${countData.supervisorPendingRequestsCount.toString()} Pending',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: FColors.roleStatuscolor,
                                  fontSize: 14)),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ));
  }
}

class GenericIDOwnerContainer extends StatelessWidget {
  final TextEditingController selectedRoleController;
  final TextEditingController pendingCountController;
  final TextEditingController approvedCountController;
  final TextEditingController rejectedCountController;
  final DashboardData countData;
  //final containerWidth;
  const GenericIDOwnerContainer({
    super.key,
    required this.selectedRoleController,
    required this.pendingCountController,
    required this.approvedCountController,
    required this.rejectedCountController,
    required this.countData,
  }); // required this.containerWidth

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectedContainerIndex>(
        builder: (context, SelectedContainerIndex, _) => GestureDetector(
              onTap: () {
                SelectedContainerIndex.setSelectedIndex(2);
                pendingCountController.text =
                    countData.genericIDOwnerPendingRequestsCount.toString();
                approvedCountController.text =
                    countData.genericIDOwnerApprovedRequestsCount.toString();
                rejectedCountController.text =
                    countData.genericIDOwnerRejectedRequestsCount.toString();
                selectedRoleController.text = "Generic ID Owner";
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  //duration: Duration(milliseconds: 300),
                  width: 120,
                  height: 150,
                  decoration: BoxDecoration(
                      color: FColors.rolepanelcolor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Container(
                        //duration: Duration(milliseconds: 300),
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: SelectedContainerIndex.SelectedIndex == 2
                                    ? FColors.textHeader
                                    : FColors.textWhite),
                            borderRadius: BorderRadius.circular(70),
                            color: SelectedContainerIndex.SelectedIndex == 2
                                ? FColors.textHeader
                                : FColors.textWhite,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[400]!,
                                  blurRadius: 3.0,
                                  blurStyle: BlurStyle.normal),
                            ]),
                        child: Icon(FontAwesomeIcons.circleCheck,
                            color: SelectedContainerIndex.SelectedIndex == 2
                                ? FColors.textWhite
                                : FColors.textHeader,
                            size: 30),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text("Generic ID Owner",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: FColors.textPrimary,
                              height: 1.3,
                              fontSize: 16)),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                              '${countData.genericIDOwnerPendingRequestsCount.toString()} Pending',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: FColors.roleStatuscolor,
                                  fontSize: 14)),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ));
  }
}

class VendorOnboardingContainer extends StatelessWidget {
  final TextEditingController selectedRoleController;
  final TextEditingController pendingCountController;
  final TextEditingController approvedCountController;
  final TextEditingController rejectedCountController;
  final DashboardData countData;
  //final containerWidth;
  const VendorOnboardingContainer({
    super.key,
    required this.selectedRoleController,
    required this.pendingCountController,
    required this.approvedCountController,
    required this.rejectedCountController,
    required this.countData,
  }); //required this.containerWidth

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectedContainerIndex>(
        builder: (context, SelectedContainerIndex, _) => GestureDetector(
              onTap: () {
                SelectedContainerIndex.setSelectedIndex(3);
                pendingCountController.text =
                    countData.vendorOnboardingPendingRequestsCount.toString();
                approvedCountController.text =
                    countData.vendorOnboardingApprovedRequestsCount.toString();
                rejectedCountController.text =
                    countData.vendorCodeRejectedRequestsCount.toString();
                selectedRoleController.text = "Vendor Onboarding";
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  //duration: Duration(milliseconds: 300),
                  width: 120,
                  height: 150,
                  decoration: BoxDecoration(
                      color: FColors.rolepanelcolor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Container(
                        //duration: Duration(milliseconds: 300),
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: SelectedContainerIndex.SelectedIndex == 3
                                    ? FColors.textHeader
                                    : FColors.textWhite),
                            borderRadius: BorderRadius.circular(70),
                            color: SelectedContainerIndex.SelectedIndex == 3
                                ? FColors.textHeader
                                : FColors.textWhite,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[400]!,
                                  blurRadius: 3.0,
                                  blurStyle: BlurStyle.normal),
                            ]),
                        child: Icon(FontAwesomeIcons.chalkboardUser,
                            color: SelectedContainerIndex.SelectedIndex == 3
                                ? FColors.textWhite
                                : FColors.textHeader,
                            size: 25),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text("Vendor Onboarding",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              height: 1.3,
                              color: FColors.textPrimary,
                              fontSize: 16)),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                              '${countData.vendorOnboardingPendingRequestsCount.toString()} Pending',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: FColors.roleStatuscolor,
                                  fontSize: 14)),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ));
  }
}

class BusinessContainer extends StatelessWidget {
  final TextEditingController selectedRoleController;
  final TextEditingController pendingCountController;
  final TextEditingController approvedCountController;
  final TextEditingController rejectedCountController;
  final DashboardData countData;
  //final containerWidth;

  const BusinessContainer({
    super.key,
    required this.selectedRoleController,
    required this.pendingCountController,
    required this.approvedCountController,
    required this.rejectedCountController,
    required this.countData,
  }); //required this.containerWidth

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectedContainerIndex>(
      builder: (context, SelectedContainerIndex, _) => GestureDetector(
        onTap: () {
          SelectedContainerIndex.setSelectedIndex(4);
          pendingCountController.text =
              countData.businessOwnerPendingRequestsCount.toString();
          approvedCountController.text =
              countData.businessOwnerApprovedRequestsCount.toString();
          rejectedCountController.text =
              countData.businessOwnerRejectedRequestsCount.toString();

          selectedRoleController.text = "Business Approver";
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            //duration: Duration(milliseconds: 300),
            width: 120,
            height: 150,
            decoration: BoxDecoration(
                color: FColors.rolepanelcolor,
                borderRadius: BorderRadius.circular(20)),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Container(
                  //duration: Duration(milliseconds: 300),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: SelectedContainerIndex.SelectedIndex == 4
                              ? FColors.textHeader
                              : FColors.textWhite),
                      borderRadius: BorderRadius.circular(70),
                      color: SelectedContainerIndex.SelectedIndex == 4
                          ? FColors.textHeader
                          : FColors.textWhite,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[400]!,
                            blurRadius: 3.0,
                            blurStyle: BlurStyle.normal),
                      ]),
                  child: Icon(FontAwesomeIcons.briefcase,
                      color: SelectedContainerIndex.SelectedIndex == 4
                          ? FColors.textWhite
                          : FColors.textHeader,
                      size: 25),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text("Business Approver",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                        color: FColors.textPrimary,
                        fontSize: 16)),
              ),
              Spacer(
                flex: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                        '${countData.businessOwnerPendingRequestsCount.toString()} Pending',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: FColors.roleStatuscolor,
                            fontSize: 14)),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class VendorCodeContainer extends StatelessWidget {
  final TextEditingController selectedRoleController;
  final TextEditingController pendingCountController;
  final TextEditingController approvedCountController;
  final TextEditingController rejectedCountController;
  final DashboardData countData;
  //final containerWidth;
  const VendorCodeContainer({
    super.key,
    required this.selectedRoleController,
    required this.pendingCountController,
    required this.approvedCountController,
    required this.rejectedCountController,
    required this.countData,
  }); // required this.containerWidth

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectedContainerIndex>(
      builder: (context, SelectedContainerIndex, _) => GestureDetector(
        onTap: () {
          SelectedContainerIndex.setSelectedIndex(5);
          pendingCountController.text =
              countData.vendorCodePendingRequestsCount.toString();
          approvedCountController.text =
              countData.vendorCodeApprovedRequestsCount.toString();
          rejectedCountController.text =
              countData.vendorCodeRejectedRequestsCount.toString();
          selectedRoleController.text = "Vendor Code";
        },
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            width: 120,
            height: 150,
            decoration: BoxDecoration(
                color: FColors.rolepanelcolor,
                borderRadius: BorderRadius.circular(20)),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 12.0, right: 8),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: SelectedContainerIndex.SelectedIndex == 5
                              ? FColors.textHeader
                              : FColors.textWhite),
                      borderRadius: BorderRadius.circular(70),
                      color: SelectedContainerIndex.SelectedIndex == 5
                          ? FColors.textHeader
                          : FColors.textWhite,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[400]!,
                            blurRadius: 3.0,
                            blurStyle: BlurStyle.normal),
                      ]),
                  child: Icon(FontAwesomeIcons.codePullRequest,
                      color: SelectedContainerIndex.SelectedIndex == 5
                          ? FColors.textWhite
                          : FColors.textHeader,
                      size: 25),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text("Vendor Code",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                        color: FColors.textPrimary,
                        fontSize: 16)),
              ),
              Spacer(
                flex: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                        '${countData.vendorCodePendingRequestsCount.toString()} Pending',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: FColors.roleStatuscolor,
                            fontSize: 14)),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class SelectedContainerIndex extends ChangeNotifier {
  late int _selectedIndex = 1;
  int get SelectedIndex => _selectedIndex;
  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}

class ScrollPositonNotifier with ChangeNotifier {
  //ScrollController _scrollController = ScrollController();
  List<bool> _visibleIndicator = [true, true, true, false, false];

  List<bool> get visibleIndicator => _visibleIndicator;

  void updateIndicators(double offset, double viewportWidth) {
    int visibleCount = (viewportWidth / 120).floor();
    int startIndex = (offset / 120).floor();
    _visibleIndicator = List.generate(
        5, (index) => index >= startIndex && index < startIndex + visibleCount);
    notifyListeners();
  }
  // int _currentIndex = 0;
  // int get currentIndex => _currentIndex;
  // set currentIndex(int index) {
  //   _currentIndex = index;
  //   notifyListeners();
  // }
}

class ScrollProvider with ChangeNotifier {
  bool _showLeftArrow = false;
  bool _showRightArrow = true;

  bool get showLeftArrow => _showLeftArrow;
  bool get showRightArrow => _showRightArrow;

  void updateScrollPosition(
      double offset, double maxScrollExtent, double viewportWidth) {
    if (offset <= 0) {
      // print(
      //   'updateScrollPosition called with offset: $offset,showLeftarrow: $_showLeftArrow, showRightarrow:$_showRightArrow,viewportWidth:$viewportWidth');
      _showLeftArrow = false;
      _showRightArrow = true;
      //print(
      //  'At Start-- showLeftArrow: $_showLeftArrow, showRightarrow:$_showRightArrow');
    } else if (offset <= viewportWidth - maxScrollExtent + 120) {
      _showLeftArrow = true;
      _showRightArrow = true;
      // print(
      //   'Nearing end-- showLeftArrow: $_showLeftArrow, showRightarrow:$_showRightArrow');
    } else if (offset >= viewportWidth - maxScrollExtent) {
      _showLeftArrow = true;
      _showRightArrow = false;
      //print(
      //  'At end-- showLeftArrow: $_showLeftArrow, showRightarrow:$_showRightArrow');
    } else {
      _showLeftArrow = true;
      _showRightArrow = true;
      //print(
      //  'At middle-- showLeftArrow: $_showLeftArrow, showRightarrow:$_showRightArrow');
    }

    notifyListeners();
  }
}
