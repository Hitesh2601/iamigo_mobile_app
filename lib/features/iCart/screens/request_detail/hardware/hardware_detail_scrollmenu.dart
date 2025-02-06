// // ignore_for_file: prefer_const_constructors, annotate_overrides, camel_case_types, unnecessary_this, unused_import, avoid_web_libraries_in_flutter, override_on_non_overriding_member

// //import 'dart:js';

// import 'package:push_notification/common/widgets/background_screen.dart';
// import 'package:push_notification/common/widgets/no_data_found_widget.dart';
// import 'package:push_notification/features/iApproval/screens/dashboard/widget/header_widget.dart';
// import 'package:push_notification/features/iApproval/screens/request_detail/fpn_details_screen.dart';
// import 'package:push_notification/features/iApproval/screens/request_detail/widget/fpn_detail_menu_card_widget.dart';
// import 'package:push_notification/features/iApproval/screens/request_list/fpn_requests_screen.dart';
// import 'package:push_notification/features/iApproval/screens/request_list/widget/fpn_request_item_widget.dart';
// import 'package:push_notification/features/iCart/models/icart_hardware_detail_response.dart';
// import 'package:push_notification/features/iCart/providers/hardware_detail_provider.dart';
// import 'package:push_notification/features/iCart/providers/icart_provider.dart';
// import 'package:push_notification/features/iCart/screens/request_detail/hardware/screens/approver_details.dart';
// import 'package:push_notification/features/iCart/screens/request_detail/hardware/screens/approver_history_details.dart';
// import 'package:push_notification/features/iCart/screens/request_detail/hardware/screens/checklist_validation_screen.dart';
// import 'package:push_notification/features/iCart/screens/request_detail/hardware/screens/delivery_address_details.dart';
// import 'package:push_notification/features/iCart/screens/request_detail/hardware/screens/employee_details.view.dart';
// import 'package:push_notification/features/iCart/screens/request_detail/hardware/screens/invoicing_payment_screen.dart';
// import 'package:push_notification/features/iCart/screens/request_detail/hardware/screens/po_insurance_installation.dart';
// import 'package:push_notification/features/iCart/screens/request_detail/hardware/screens/query_feedback_view.dart';
// import 'package:push_notification/features/iCart/screens/request_detail/hardware/screens/request_details_view.dart';
// import 'package:push_notification/features/iCart/screens/request_detail/hardware/screens/request_reason_view.dart';
// import 'package:push_notification/features/iCart/screens/request_detail/hardware/screens/unit_details_view.dart';
// import 'package:push_notification/features/iCart/screens/request_list/hardware/hardware_request_item.dart';
// import 'package:push_notification/utility/constants/colors.dart';
// import 'package:push_notification/utility/constants/global_variables.dart';
// import 'package:push_notification/utility/constants/icart_menu_list.dart';
// import 'package:push_notification/utility/helpers/helper_functions.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:loader_overlay/loader_overlay.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:provider/provider.dart';

// class HardwareDetailsScrollScreen extends StatefulWidget {
//   final String requestNumber;
//   final String profile;
//   final bool isButtonVisible;
//   final List<String>? filteredRequestNo;
//   const HardwareDetailsScrollScreen({
//     super.key,
//     required this.requestNumber,
//     required this.isButtonVisible,
//     required this.profile,
//     required this.filteredRequestNo,
//   });

//   @override
//   State<HardwareDetailsScrollScreen> createState() => _FpnDetailsScreenState();
// }

// class _FpnDetailsScreenState extends State<HardwareDetailsScrollScreen> {
//   TextEditingController txtRejectRemarkController = TextEditingController();

//   TextEditingController txtApproveRemarkController = TextEditingController();
//   @override
//   void dispose() {
//     txtRejectRemarkController.dispose();
//     txtApproveRemarkController.dispose();
//     super.dispose();
//   }

//   ICartHardwareDetailModel? response;
//   bool pageLoad = true;
//   String requestNumber = "";
//   bool isNumChanged = false;
//   // final ScrollController _scrollController = ScrollController();
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _scrollController.addListener(_onScroll);
//   // }

//   // @override
//   // void dispose() {
//   //   _scrollController.removeListener(_onScroll);
//   //   super.dispose();
//   // }

//   // void _onScroll() {
//   //   final scrollNotifier = Provider.of<ScrollNotifier>(context, listen: false);
//   //   double offset = _scrollController.offset;
//   //   double maxExtent = _scrollController.position.maxScrollExtent;
//   //   int selectedIndex = (offset / (maxExtent / 10)).round();
//   //   scrollNotifier.updateSelectedIndex(selectedIndex);
//   // }

//   @override
//   Widget build(BuildContext context) {
//     if (!isNumChanged) {
//       requestNumber = widget.requestNumber;
//     }
//     var requestJson = {
//       "RegObj": {
//         "UserId": GlobalVariables.userName,
//         "RequestNo": requestNumber,
//         "RequestType": "Hardware",
//         "Profile": widget.profile,
//       }
//     };
//     var requestApproveJson = {
//       "RegObj": {
//         "UserId": GlobalVariables.userName,
//         "Profile": widget.profile,
//         "RequestType": "Hardware",
//         "Request": [
//           {
//             "RequestNo": requestNumber,
//             "Remark": "",
//             "ChangeApprover": false,
//             "NextApproverId": "",
//             "Reason": "",
//             "IsHardDiskFormatting": ""
//           }
//         ]
//       }
//     };

//     var requestRejectJson = {
//       "RegObj": {
//         "UserId": GlobalVariables.userName,
//         "Profile": widget.profile,
//         "RequestType": "Hardware",
//         "Request": [
//           {"RequestNo": requestNumber, "Remark": ""}
//         ]
//       }
//     };

//     return ChangeNotifierProvider(
//         create: (context) => ICartProvider(),
//         child: Scaffold(
//             backgroundColor: FColors.light,
//             body: LoaderOverlay(
//               useDefaultLoading: false,
//               overlayColor: Colors.black.withOpacity(0.1),
//               overlayWidgetBuilder: (_) {
//                 //ignored progress for the moment
//                 return Center(
//                   child: LoadingAnimationWidget.discreteCircle(
//                     color: FColors.textHeader,
//                     secondRingColor: FColors.textHeader,
//                     thirdRingColor: const Color(0xFFEA3799),
//                     size: 50,
//                   ),
//                 );
//               },
//               child: Stack(children: [
//                 BackgrounScreenWidget(
//                   height: 310,
//                 ),
//                 Column(
//                   children: [
//                     Consumer<HardwareDetailProvider>(
//                         builder: (context, value, child) {
//                       return Padding(
//                         padding: const EdgeInsets.only(left: 8.0),
//                         child: HeaderWidget(
//                           title: value.selectedNumber,
//                           icon: "back",
//                           iconColor: Colors.white,
//                         ),
//                       );
//                     }),
//                     Expanded(
//                         child: Column(
//                       children: [
//                         getHardwareMenus(context),
//                         FutureBuilder(
//                           builder: (context, snapshot) {
//                             if (snapshot.connectionState ==
//                                 ConnectionState.waiting) {
//                               context.loaderOverlay.show();
//                             } else if (snapshot.connectionState ==
//                                 ConnectionState.done) {
//                               context.loaderOverlay.hide();
//                               if (snapshot.hasError) {
//                                 return const NoDataFountWidget();
//                               } else if (snapshot.hasData) {
//                                 var data =
//                                     snapshot.data as ICartHardwareDetailModel;
//                                 if (data.returnStatus == 3) {
//                                   return const NoDataFountWidget();
//                                 } else if (data.returnStatus == 2) {
//                                   return OrientationBuilder(
//                                     builder: (context, orientation) {
//                                       return (orientation ==
//                                               Orientation.portrait)
//                                           ? Consumer<HardwareDetailProvider>(
//                                               builder: (context, value, child) {
//                                                 return getSelectedScreen(
//                                                     context,
//                                                     value.detailResponse,
//                                                     value.selectedValue);
//                                               },
//                                             )
//                                           : const SizedBox();
//                                     },
//                                   );
//                                 } else if ((data.returnStatus == 1) ||
//                                     (data.returnStatus == 4)) {
//                                   HelperFunctions.showAlert(
//                                       "AMIGO", data.responseMessage!);
//                                 } else {
//                                   HelperFunctions.showAlert(
//                                       "Error", "Oops! Something went wrong");
//                                 }
//                               }
//                             }
//                             return SizedBox();
//                           },
//                           future: Provider.of<HardwareDetailProvider>(context,
//                                   listen: false)
//                               .getRequestDetailsData(requestJson),
//                         ),
//                       ],
//                     )),
//                     Visibility(
//                       visible: widget.isButtonVisible,
//                       child: Align(
//                         alignment: Alignment.bottomCenter,
//                         child: Card(
//                           elevation: 0,
//                           shadowColor: Colors.black,
//                           color: FColors.textWhite,
//                           shape: const RoundedRectangleBorder(
//                             borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(15),
//                                 topRight: Radius.circular(15),
//                                 bottomLeft: Radius.circular(0),
//                                 bottomRight: Radius.circular(0)),
//                           ),
//                           margin: EdgeInsets.zero,
//                           child: SizedBox(
//                             height: 70,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Expanded(
//                                   child: Padding(
//                                     padding: const EdgeInsets.fromLTRB(
//                                         10, 10, 0, 10),
//                                     child: ElevatedButton(
//                                         style: ButtonStyle(
//                                             padding:
//                                                 const WidgetStatePropertyAll(
//                                                     EdgeInsets.zero),
//                                             shape: WidgetStateProperty.all<
//                                                     RoundedRectangleBorder>(
//                                                 RoundedRectangleBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             8))),
//                                             backgroundColor:
//                                                 WidgetStateProperty.all<Color>(
//                                                     FColors.submitColor)),
//                                         child: const Text(
//                                           'Authorize',
//                                           style: TextStyle(
//                                               color: FColors.textWhite),
//                                         ),
//                                         onPressed: () => {
//                                               showDialog(
//                                                 context: context,
//                                                 builder: (BuildContext
//                                                         context) =>
//                                                     iCartHWApproveAlert(context,
//                                                         txtApproveRemarkController),
//                                               ).then((value) {
//                                                 if (value == 'Submit') {
//                                                   ///To Show Loader Popup
//                                                   // requestApproveJson['Remark'] =
//                                                   //     txtApproveRemarkController.text;
//                                                   context.loaderOverlay.show();
//                                                   requestApproveJson = {
//                                                     "RegObj": {
//                                                       "UserId": GlobalVariables
//                                                           .userName,
//                                                       "Profile": widget.profile,
//                                                       "RequestType": "Hardware",
//                                                       "Request": [
//                                                         {
//                                                           "RequestNo": widget
//                                                               .requestNumber,
//                                                           "Remark":
//                                                               txtApproveRemarkController
//                                                                   .text
//                                                                   .toString(),
//                                                           "ChangeApprover":
//                                                               false,
//                                                           "NextApproverId": "",
//                                                           "Reason": "",
//                                                           "IsHardDiskFormatting":
//                                                               ""
//                                                         }
//                                                       ]
//                                                     }
//                                                   };
//                                                   context
//                                                       .read<ICartProvider>()
//                                                       .iCartApproveRequest(
//                                                           requestApproveJson)
//                                                       .then((value) async {
//                                                     context.loaderOverlay
//                                                         .hide();
//                                                     if (value.returnStatus ==
//                                                         2) {
//                                                       HelperFunctions.showAlert(
//                                                           "Success",
//                                                           '${widget.requestNumber} has been approved successfully.');
//                                                       context.loaderOverlay
//                                                           .show();
//                                                       requestNumber =
//                                                           getNextRequest(
//                                                               requestNumber);
//                                                       await Provider.of<
//                                                                   HardwareDetailProvider>(
//                                                               context,
//                                                               listen: false)
//                                                           .getRequestDetailsData({
//                                                         "RegObj": {
//                                                           "UserId":
//                                                               GlobalVariables
//                                                                   .userName,
//                                                           "RequestNo":
//                                                               requestNumber,
//                                                           "RequestType":
//                                                               "Hardware",
//                                                           "Profile":
//                                                               widget.profile,
//                                                         }
//                                                       });
//                                                       context.loaderOverlay
//                                                           .hide();
//                                                       //widget.callback("refresh");
//                                                     } else if ((value
//                                                                 .returnStatus ==
//                                                             1) ||
//                                                         (value.returnStatus ==
//                                                             4)) {
//                                                       HelperFunctions.showAlert(
//                                                           "AMIGO",
//                                                           value
//                                                               .responseMessage!);
//                                                     } else {
//                                                       HelperFunctions.showAlert(
//                                                           "Error",
//                                                           "Oops! Something went wrong");
//                                                     }
//                                                   });
//                                                 } else {}
//                                               })
//                                             }),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Padding(
//                                     padding: const EdgeInsets.fromLTRB(
//                                         10, 10, 0, 10),
//                                     child: ElevatedButton(
//                                       style: ButtonStyle(
//                                           padding: const WidgetStatePropertyAll(
//                                               EdgeInsets.zero),
//                                           shape: WidgetStateProperty.all<
//                                                   RoundedRectangleBorder>(
//                                               RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           8))),
//                                           backgroundColor:
//                                               WidgetStateProperty.all<Color>(
//                                                   FColors.rejectedDark)),
//                                       child: const Text(
//                                         'Reject',
//                                         style:
//                                             TextStyle(color: FColors.textWhite),
//                                       ),
//                                       onPressed: () => {
//                                         ///Json Create here
//                                         // requestRejectJson['FpnNo'] =
//                                         //     widget.requestNumber.toString(),
//                                         showDialog(
//                                           context: context,
//                                           builder: (BuildContext context) =>
//                                               iCartHWRejectAlert(context,
//                                                   txtRejectRemarkController),
//                                         ).then((value) async {
//                                           if (value == 'Submit') {
//                                             /// To Show Loader
//                                             if (txtRejectRemarkController
//                                                 .text.isEmpty) {
//                                               HelperFunctions.showAlert(
//                                                   "Validation",
//                                                   'Please Enter Reject Remarks.');
//                                             } else {
//                                               requestRejectJson = {
//                                                 "RegObj": {
//                                                   "UserId":
//                                                       GlobalVariables.userName,
//                                                   "Profile": widget.profile,
//                                                   "RequestType": "Hardware",
//                                                   "Request": [
//                                                     {
//                                                       "RequestNo":
//                                                           requestNumber,
//                                                       "Remark":
//                                                           txtRejectRemarkController
//                                                               .text
//                                                               .toString()
//                                                     }
//                                                   ]
//                                                 }
//                                               };
//                                               context.loaderOverlay.show();
//                                               context
//                                                   .read<ICartProvider>()
//                                                   .iCartRejectRequest(
//                                                       requestRejectJson)
//                                                   .then((value) async {
//                                                 context.loaderOverlay.hide();
//                                                 if (value.returnStatus == 2) {
//                                                   HelperFunctions.showAlert(
//                                                       "Success",
//                                                       '${widget.requestNumber} has been rejected successfully.');
//                                                   requestNumber =
//                                                       getNextRequest(
//                                                           requestNumber);
//                                                   context.loaderOverlay.show();
//                                                   await Provider.of<
//                                                               HardwareDetailProvider>(
//                                                           context,
//                                                           listen: false)
//                                                       .getRequestDetailsData({
//                                                     "RegObj": {
//                                                       "UserId": GlobalVariables
//                                                           .userName,
//                                                       "RequestNo":
//                                                           requestNumber,
//                                                       "RequestType": "Hardware",
//                                                       "Profile": widget.profile,
//                                                     }
//                                                   });
//                                                   context.loaderOverlay.hide();
//                                                 } else if ((value
//                                                             .returnStatus ==
//                                                         1) ||
//                                                     (value.returnStatus == 4)) {
//                                                   HelperFunctions.showAlert(
//                                                       "AMIGO",
//                                                       value.responseMessage!);
//                                                 } else {
//                                                   HelperFunctions.showAlert(
//                                                       "Error",
//                                                       "Oops! Something went wrong");
//                                                 }
//                                               });
//                                             }
//                                           } else {}
//                                         })
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 )
//               ]),
//             )));
//   }

//   String getNextRequest(String requestNo) {
//     String requestNumber = "";

//     int currentIndex = widget.filteredRequestNo!.indexOf(requestNo);
//     widget.filteredRequestNo!.removeAt(currentIndex);

//     if (widget.filteredRequestNo!.isNotEmpty) {
//       if (currentIndex <
//           HelperFunctions.getNumber(widget.filteredRequestNo?.length) - 1) {
//         requestNumber = widget.filteredRequestNo![currentIndex];
//       } else {
//         currentIndex = 0;
//         requestNumber = widget.filteredRequestNo![currentIndex];
//       }
//     } else {
//       requestNumber = "";
//     }

//     return requestNumber;
//   }

//   Padding getHardwareMenus(BuildContext context) {
//     ScrollController scrollController = ScrollController();
//     // scrollController.addListener(() {
//     //   Provider.of<ScrollNotifier>(context, listen: false)
//     //       .updateScrollPosition(scrollController.position.pixels);
//     // });
//     final scrollNotifier = Provider.of<ScrollNotifier>(context, listen: false);
//     const containerWidth = 150;
//     scrollController.addListener(() {
//       final scrollOffset = scrollController.position.pixels + 180;
//       final currentIndex = (scrollOffset / containerWidth).round();
//       scrollNotifier.currentIndex = currentIndex;
//     });

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final initialScrollOffset = scrollController.position.pixels + 180;
//       final initialIndex = (initialScrollOffset / containerWidth).round();
//       scrollNotifier.currentIndex = initialIndex;
//     });
//     //final scrollNotifier = Provider.of<ScrollNotifier>(context);
//     return Padding(
//         padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
//         child: Card(
//           child: SizedBox(
//             width: MediaQuery.of(context).size.width,
//             height: 172,
//             child: Consumer<HardwareDetailProvider>(
//               builder: (context, iCartProvider, _) =>
//                   NotificationListener<ScrollNotification>(
//                 onNotification: (scrollNotification) {
//                   if (scrollController.offset >=
//                           scrollController.position.maxScrollExtent &&
//                       !scrollController.position.outOfRange) {
//                     iCartProvider.setPositionEnd(true);
//                   }
//                   if (scrollController.offset <=
//                           scrollController.position.minScrollExtent &&
//                       !scrollController.position.outOfRange) {
//                     iCartProvider.setPositionEnd(false);
//                   }
//                   return true;
//                 },
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         controller: scrollController,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             const SizedBox(
//                               height: 15,
//                             ),
//                             Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   InkWell(
//                                     onTap: () {
//                                       iCartProvider.setSelectedValue(
//                                           ICartDetailMenus
//                                               .icartMenuList[0].name);
//                                     },
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(5.0),
//                                       child: BorderedLabelIconWidget(
//                                           icon: ICartDetailMenus
//                                               .icartMenuList[0].icon,
//                                           name: ICartDetailMenus
//                                               .icartMenuList[0].name,
//                                           height: 115,
//                                           isSelected: ICartDetailMenus
//                                                   .icartMenuList[0].name ==
//                                               iCartProvider.selectedValue),
//                                     ),
//                                   ),
//                                   InkWell(
//                                     onTap: () {
//                                       iCartProvider.setSelectedValue(
//                                           ICartDetailMenus
//                                               .icartMenuList[1].name);
//                                     },
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(2.0),
//                                       child: BorderedLabelIconWidget(
//                                           icon: ICartDetailMenus
//                                               .icartMenuList[1].icon,
//                                           name: ICartDetailMenus
//                                               .icartMenuList[1].name,
//                                           height: 115,
//                                           isSelected: ICartDetailMenus
//                                                   .icartMenuList[1].name ==
//                                               iCartProvider.selectedValue),
//                                     ),
//                                   ),
//                                   InkWell(
//                                     onTap: () {
//                                       iCartProvider.setSelectedValue(
//                                           ICartDetailMenus
//                                               .icartMenuList[2].name);
//                                     },
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(2.0),
//                                       child: BorderedLabelIconWidget(
//                                           icon: ICartDetailMenus
//                                               .icartMenuList[2].icon,
//                                           name: ICartDetailMenus
//                                               .icartMenuList[2].name,
//                                           height: 115,
//                                           isSelected: ICartDetailMenus
//                                                   .icartMenuList[2].name ==
//                                               iCartProvider.selectedValue),
//                                     ),
//                                   ),
//                                   InkWell(
//                                     onTap: () {
//                                       iCartProvider.setSelectedValue(
//                                           ICartDetailMenus
//                                               .icartMenuList[4].name);
//                                     },
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(2.0),
//                                       child: BorderedLabelIconWidget(
//                                           icon: ICartDetailMenus
//                                               .icartMenuList[4].icon,
//                                           name: ICartDetailMenus
//                                               .icartMenuList[4].name,
//                                           height: 115,
//                                           isSelected: ICartDetailMenus
//                                                   .icartMenuList[4].name ==
//                                               iCartProvider.selectedValue),
//                                     ),
//                                   ),
//                                 ]),
//                             Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   InkWell(
//                                     onTap: () {
//                                       iCartProvider.setSelectedValue(
//                                           ICartDetailMenus
//                                               .icartMenuList[3].name);
//                                     },
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(2.0),
//                                       child: BorderedLabelIconWidget(
//                                           icon: ICartDetailMenus
//                                               .icartMenuList[3].icon,
//                                           name: ICartDetailMenus
//                                               .icartMenuList[3].name,
//                                           height: 115,
//                                           isSelected: ICartDetailMenus
//                                                   .icartMenuList[3].name ==
//                                               iCartProvider.selectedValue),
//                                     ),
//                                   ),
//                                   InkWell(
//                                     onTap: () {
//                                       iCartProvider.setSelectedValue(
//                                           ICartDetailMenus
//                                               .icartMenuList[5].name);
//                                     },
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(2.0),
//                                       child: BorderedLabelIconWidget(
//                                           icon: ICartDetailMenus
//                                               .icartMenuList[5].icon,
//                                           name: ICartDetailMenus
//                                               .icartMenuList[5].name,
//                                           height: 115,
//                                           isSelected: ICartDetailMenus
//                                                   .icartMenuList[5].name ==
//                                               iCartProvider.selectedValue),
//                                     ),
//                                   ),
//                                   InkWell(
//                                     onTap: () {
//                                       iCartProvider.setSelectedValue(
//                                           ICartDetailMenus
//                                               .icartMenuList[6].name);
//                                     },
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(2.0),
//                                       child: BorderedLabelIconWidget(
//                                           icon: ICartDetailMenus
//                                               .icartMenuList[6].icon,
//                                           name: ICartDetailMenus
//                                               .icartMenuList[6].name,
//                                           height: 115,
//                                           isSelected: ICartDetailMenus
//                                                   .icartMenuList[6].name ==
//                                               iCartProvider.selectedValue),
//                                     ),
//                                   ),
//                                   // InkWell(
//                                   //   onTap: () => {
//                                   //     !iCartProvider.isPositionEnd
//                                   //         ? scrollController.animateTo(
//                                   //             scrollController
//                                   //                 .position.maxScrollExtent,
//                                   //             duration:
//                                   //                 const Duration(milliseconds: 300),
//                                   //             curve: Curves.easeIn)
//                                   //         : scrollController.animateTo(0,
//                                   //             duration:
//                                   //                 const Duration(milliseconds: 300),
//                                   //             curve: Curves.easeIn)
//                                   //   },
//                                   //   child: BorderedLabelIconWidget(
//                                   //     icon: iCartProvider.isPositionEnd
//                                   //         ? FontAwesomeIcons.circleChevronUp
//                                   //         : FontAwesomeIcons.circleChevronDown,
//                                   //     name: "",
//                                   //     height: 117,
//                                   //   ),
//                                   // )
//                                 ]),
//                             Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   InkWell(
//                                     onTap: () async {
//                                       iCartProvider.setSelectedValue(
//                                           ICartDetailMenus
//                                               .icartMenuList[7].name);
//                                     },
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(2.0),
//                                       child: BorderedLabelIconWidget(
//                                           icon: ICartDetailMenus
//                                               .icartMenuList[7].icon,
//                                           name: ICartDetailMenus
//                                               .icartMenuList[7].name,
//                                           height: 115,
//                                           isSelected: ICartDetailMenus
//                                                   .icartMenuList[7].name ==
//                                               iCartProvider.selectedValue),
//                                     ),
//                                   ),
//                                   InkWell(
//                                     onTap: () async {
//                                       iCartProvider.setSelectedValue(
//                                           ICartDetailMenus
//                                               .icartMenuList[8].name);
//                                     },
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(2.0),
//                                       child: BorderedLabelIconWidget(
//                                           icon: ICartDetailMenus
//                                               .icartMenuList[8].icon,
//                                           name: ICartDetailMenus
//                                               .icartMenuList[8].name,
//                                           height: 115,
//                                           isSelected: ICartDetailMenus
//                                                   .icartMenuList[8].name ==
//                                               iCartProvider.selectedValue),
//                                     ),
//                                   ),
//                                   InkWell(
//                                     onTap: () async {
//                                       iCartProvider.setSelectedValue(
//                                           ICartDetailMenus
//                                               .icartMenuList[9].name);
//                                     },
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(2.0),
//                                       child: BorderedLabelIconWidget(
//                                           icon: ICartDetailMenus
//                                               .icartMenuList[9].icon,
//                                           name: ICartDetailMenus
//                                               .icartMenuList[9].name,
//                                           height: 115,
//                                           isSelected: ICartDetailMenus
//                                                   .icartMenuList[9].name ==
//                                               iCartProvider.selectedValue),
//                                     ),
//                                   ),
//                                   InkWell(
//                                     onTap: () async {
//                                       iCartProvider.setSelectedValue(
//                                           ICartDetailMenus
//                                               .icartMenuList[10].name);
//                                     },
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(2.0),
//                                       child: BorderedLabelIconWidget(
//                                           icon: ICartDetailMenus
//                                               .icartMenuList[10].icon,
//                                           name: ICartDetailMenus
//                                               .icartMenuList[10].name,
//                                           height: 115,
//                                           isSelected: ICartDetailMenus
//                                                   .icartMenuList[10].name ==
//                                               iCartProvider.selectedValue),
//                                     ),
//                                   ),
//                                 ]),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     // if (scrollController.hasClients &&
//                     //     scrollController.position.maxScrollExtent > 0)
//                     //   if (scrollNotifier._currentIndex > 0)
//                     //     Positioned(
//                     //       left: 0,
//                     //       top: 0,
//                     //       bottom: 0,
//                     //       child: GestureDetector(
//                     //         onTap: () {
//                     //           scrollController.animateTo(
//                     //             scrollController.position.pixels - 120,
//                     //             duration: Duration(milliseconds: 300),
//                     //             curve: Curves.easeInOut,
//                     //           );
//                     //         },
//                     //         child: CircleAvatar(
//                     //           backgroundColor: Colors.black.withOpacity(0.5),
//                     //           child:
//                     //               Icon(Icons.arrow_back, color: Colors.white),
//                     //         ),
//                     //       ),
//                     //     ),
//                     // if (scrollController.hasClients &&
//                     //     scrollController.position.maxScrollExtent > 0)
//                     //   if (scrollNotifier._currentIndex <
//                     //       scrollController.position.maxScrollExtent)
//                     //     Positioned(
//                     //       right: 0,
//                     //       top: 0,
//                     //       bottom: 0,
//                     //       child: GestureDetector(
//                     //         onTap: () {
//                     //           scrollController.animateTo(
//                     //             scrollController.position.pixels + 120,
//                     //             duration: Duration(milliseconds: 300),
//                     //             curve: Curves.easeInOut,
//                     //           );
//                     //         },
//                     //         child: CircleAvatar(
//                     //           backgroundColor: Colors.black.withOpacity(0.5),
//                     //           child: Icon(Icons.arrow_forward,
//                     //               color: Colors.white),
//                     //         ),
//                     //       ),
//                     //     ),
//                     // Positioned(
//                     //   bottom: 10,
//                     //   left: 0,
//                     //   right: 0,
//                     //   child: Row(
//                     //     mainAxisAlignment: MainAxisAlignment.center,
//                     //     children: List.generate(
//                     //       11,
//                     //       (index) => Container(
//                     //         margin: EdgeInsets.symmetric(horizontal: 4.0),
//                     //         width: 10,
//                     //         height: 10,
//                     //         decoration: BoxDecoration(
//                     //           shape: BoxShape.circle,
//                     //           color: (scrollNotifier.scrollPosition >=
//                     //                       (index * 120) &&
//                     //                   scrollNotifier.scrollPosition <
//                     //                       ((index + 5) * 120))
//                     //               ? Colors.blue
//                     //               : Colors.grey,
//                     //         ),
//                     //       ),
//                     //     ),
//                     //   ),
//                     // ),
//                     Consumer<ScrollNotifier>(
//                       builder: (context, notifier, child) {
//                         return Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               //           // List.generate(11, (index) =>
//                               //           // Container(
//                               //           //   width: 5,height: 5,margin:
//                               //           //   EdgeInsets.symmetric(horizontal:
//                               //           //   4.0),
//                               //           //   decoration:
//                               //           //   BoxDecoration(shape:
//                               //           //   BoxShape.circle,
//                               //           //   color: notifier.selectedIndex==index?
//                               //           //   Colors.blue:
//                               //           //   Colors.grey,),))

//                               for (int i = 0; i < 11; i++)
//                                 CircleAvatar(
//                                   radius: 5,
//                                   backgroundColor: i == 0 &&
//                                           notifier._currentIndex == 5
//                                       ? FColors.rolepanelcolor
//                                       : (i < 5
//                                           ? FColors.textHeader
//                                           : (i > notifier._currentIndex - 4 &&
//                                                   i <
//                                                       notifier._currentIndex +
//                                                           4)
//                                               ? FColors.textHeader
//                                               : FColors.rolepanelcolor),
//                                 )
//                             ]);
//                       },
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ));
//   }

//   Padding getSelectedScreen(
//       BuildContext context, ICartHardwareDetailModel data, String screenType) {
//     SizedBox nullWidget = const SizedBox(child: NoDataFountWidget());
//     SizedBox widget = nullWidget;
//     if (data.requestDetails == null) {
//       return Padding(
//           padding: const EdgeInsets.only(top: 8.0), child: nullWidget);
//     }
//     switch (screenType) {
//       case "Request Information":
//         widget = data.requestDetails?.requestInfo != null
//             ? SizedBox(
//                 child: Card(
//                     child: RequestDetailsView(
//                   requestInfo: data.requestDetails!.requestInfo!,
//                 )),
//               )
//             : nullWidget;
//         break;
//       case "Employee Information":
//         widget = data.requestDetails?.employeeInformation != null
//             ? SizedBox(
//                 child: Card(
//                     child: EmployeeDetailsView(
//                   employeeInformation:
//                       data.requestDetails!.employeeInformation!,
//                 )),
//               )
//             : nullWidget;
//         break;
//       case "Unit Details":
//         widget = data.requestDetails?.unitDetails != null
//             ? SizedBox(
//                 child: Card(
//                     child: UnitDetailsView(
//                   unitDetails: data.requestDetails!.unitDetails!,
//                 )),
//               )
//             : nullWidget;
//         break;
//       case "Existing Asset Details":
//         widget = data.requestDetails?.requestInfo != null
//             ? SizedBox(
//                 child: Card(
//                     child: RequestDetailsView(
//                   requestInfo: data.requestDetails!.requestInfo!,
//                 )),
//               )
//             : nullWidget;
//         break;
//       case "Checklist & Validation":
//         widget = data.requestDetails?.checklistValidations != null
//             ? SizedBox(
//                 child: Card(
//                     child: ChecklistValidationScreen(
//                   checklistValidations:
//                       data.requestDetails!.checklistValidations!,
//                 )),
//               )
//             : nullWidget;
//         break;
//       case "Delivery Details":
//         widget = data.requestDetails?.deliveryDetails != null
//             ? SizedBox(
//                 child: Card(
//                     child: DeliveryDetailsView(
//                   deliveryDetails: data.requestDetails!.deliveryDetails!,
//                 )),
//               )
//             : nullWidget;
//         break;
//       case "PO, Insurance & Installation":
//         widget = data.requestDetails?.poInsuranceInstallation != null
//             ? SizedBox(
//                 child: Card(
//                     child: POInsuranceInstallationView(
//                   poInsuranceInstallation:
//                       data.requestDetails!.poInsuranceInstallation!,
//                 )),
//               )
//             : nullWidget;
//         break;
//       case "Invoicing Payment & FAR',":
//         widget = data.requestDetails?.invoicingPaymentFar != null
//             ? SizedBox(
//                 child: Card(
//                     child: InvoicingPaymentScreen(
//                   invoicingPaymentFar:
//                       data.requestDetails!.invoicingPaymentFar!,
//                 )),
//               )
//             : nullWidget;
//         break;
//       case "Request Reason":
//         widget = data.requestDetails?.requestReason != null
//             ? SizedBox(
//                 child: Card(
//                     child: RequestReasonView(
//                   requestReason: data.requestDetails!.requestReason!,
//                 )),
//               )
//             : nullWidget;
//         break;
//       case "Approver Details":
//         widget = data.requestDetails?.approverDetail != null
//             ? SizedBox(
//                 child: Card(
//                     child: ApproverDetailsView(
//                   approverDetail: data.requestDetails!.approverDetail!,
//                 )),
//               )
//             : nullWidget;
//         break;
//       case "Approver History":
//         widget = data.requestDetails?.approverHistory != null
//             ? SizedBox(
//                 child: Card(
//                     child: ApproverHistoryView(
//                   approverHistory: data.requestDetails!.approverHistory!,
//                 )),
//               )
//             : nullWidget;
//         break;
//       case "Query Feedback Details":
//         widget = data.requestDetails?.queryFeedback != null
//             ? SizedBox(
//                 child: Card(
//                     child: QueryFeedbackView(
//                   queryFeedback: data.requestDetails!.queryFeedback!,
//                 )),
//               )
//             : nullWidget;
//         break;
//     }

//     return Padding(
//       padding: const EdgeInsets.fromLTRB(10, 2, 10, 0),
//       child: SizedBox(
//         height: MediaQuery.of(context).size.height - 395,
//         child: SingleChildScrollView(
//           child: Column(children: [
//             SizedBox(
//               width: MediaQuery.of(context).size.width,
//               child: Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: Text(screenType,
//                     textAlign: TextAlign.start,
//                     style: const TextStyle(
//                         fontWeight: FontWeight.w600,
//                         color: FColors.textWhite,
//                         fontSize: 16)),
//               ),
//             ),
//             widget
//           ]),
//         ),
//       ),
//     );
//   }
// }

// class ScrollNotifier with ChangeNotifier {
//   // double _scrollPosition = 0.0;
//   // double get scrollPosition => _scrollPosition;

//   // void updateScrollPosition(double position) {
//   //   _scrollPosition = position;
//   //   notifyListeners();
//   // }
// //   ScrollController _scrollController = ScrollController();

//   int _currentIndex = 0;
//   int get currentIndex => _currentIndex;
//   set currentIndex(int index) {
//     _currentIndex = index;
//     notifyListeners();
//   }
// }
