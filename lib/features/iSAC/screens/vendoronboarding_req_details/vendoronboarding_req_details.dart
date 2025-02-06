// ignore_for_file: prefer_const_constructors, override_on_non_overriding_member, must_be_immutable, unused_label, dead_code, camel_case_types, empty_constructor_bodies, use_key_in_widget_constructors, unnecessary_null_comparison, unnecessary_cast, non_constant_identifier_names, duplicate_ignore

import 'package:push_notification/common/widgets/background_screen.dart';
import 'package:push_notification/common/widgets/no_data_found_widget.dart';
import 'package:push_notification/features/iApproval/screens/dashboard/widget/header_widget.dart';
import 'package:push_notification/features/iSAC/models/vendor_req_details_response.dart';
import 'package:push_notification/features/iSAC/screens/vendorcode_req_list/widget/vendorcode_req_item_widget.dart';
import 'package:push_notification/features/iSAC/screens/vendorcode_req_list/widget/vendorcode_req_list_widget.dart';
import 'package:push_notification/features/iSAC/screens/vendoronboarding_req_details/widget/VendorHDFCContactList.dart';
import 'package:push_notification/features/iSAC/screens/vendoronboarding_req_details/widget/proprietor_partnerPANDetails.dart';
import 'package:push_notification/features/iSAC/screens/vendoronboarding_req_details/widget/vendor_audit_trail.dart';
import 'package:push_notification/features/iSAC/screens/vendoronboarding_req_details/widget/vendoronboarding_req_list_widget.dart';
import 'package:push_notification/utility/constants/colors.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../providers/isac_provider.dart';

class VendorOnboardingDetailsScreen extends StatefulWidget {
  final String encrequestID;
  final String ticketnumber;
  final bool isButtonVisible;
  final String requestType;
  final StringCallback callback;
  final List<String>? filteredRequestNo;

  const VendorOnboardingDetailsScreen(
      {super.key,
      required this.requestType,
      required this.encrequestID,
      required this.isButtonVisible,
      required this.ticketnumber,
      required this.callback,
      required this.filteredRequestNo});

  @override
  State<VendorOnboardingDetailsScreen> createState() =>
      _VendorOnboardingDetailsScreenState();
}

class _VendorOnboardingDetailsScreenState
    extends State<VendorOnboardingDetailsScreen> {
  TextEditingController txtRejectRemarkController = TextEditingController();
  TextEditingController txtApproveRemarkController = TextEditingController();
  @override
  void dispose() {
    txtRejectRemarkController.dispose();
    txtApproveRemarkController.dispose();
    super.dispose();
  }

  String encrequestID = "";
  bool isNumChanged = false;
  List<DetailData> mainDataList = [];

  @override
  Widget build(BuildContext context) {
    if (!isNumChanged) {
      encrequestID = widget.encrequestID;
    }
    var requestJson = {
      "ReqObj": {
        "UserId": GlobalVariables.userName,
        "ENC_Cid": encrequestID,
        "RequestType": widget.requestType
      }
    };
    var requestApproveJson = {
      "ReqObj": {
        "UserId": GlobalVariables.userName,
        "ENC_Cid": encrequestID,
        "RequestType": widget.requestType,
      }
    };
    var requestRejectJson = {
      "ReqObj": {
        "UserId": GlobalVariables.userName,
        "ENC_Cid": encrequestID,
        "RejectionReasonId": "0",
        "OtherRejectReason": "Reject",
        "RequestType": widget.requestType
      }
    };

    return ChangeNotifierProvider(
      create: (context) => SelectedValueNotifier(),
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
              Column(
                children: [BackgrounScreenWidget(height: 230)],
              ),
              Column(
                children: [
                  const HeaderWidget(
                    title: 'Request Details',
                    icon: "back",
                    iconColor: Colors.white,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  // Expanded(
                  // child:
                  FutureBuilder(
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        context.loaderOverlay.show();
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        context.loaderOverlay.hide();
                        if (snapshot.hasError) {
                          return const NoDataFountWidget();
                        } else if (snapshot.hasData) {
                          var data =
                              snapshot.data as ISACVendorRequestDetailModel;
                          if (data.returnStatus == 3) {
                            return const NoDataFountWidget();
                          } else if (data.returnStatus == 2) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 0.0, right: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0.0),
                                    child: Column(
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/screen_bg.png'),
                                                    fit: BoxFit.cover),
                                              ),
                                              child: Consumer<ISACProvider>(
                                                  builder:
                                                      (context, value, child) {
                                                return Text(
                                                  //widget.ticketnumber,
                                                  value.selectedNumber,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17),
                                                );
                                              }),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10,
                                                  top: 10,
                                                  bottom: 10.0),
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () async {
                                                      Provider.of<SelectedValueNotifier>(
                                                              context,
                                                              listen: false)
                                                          .setSelectedValue(
                                                              'Info');
                                                    },
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 14.0),
                                                          child: Container(
                                                            height: 50,
                                                            width: 50,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: FColors
                                                                        .textWhite),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            70),
                                                                color: FColors
                                                                    .textWhite,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      color: Colors
                                                                              .grey[
                                                                          400]!,
                                                                      blurRadius:
                                                                          3.0,
                                                                      blurStyle:
                                                                          BlurStyle
                                                                              .normal),
                                                                ]),
                                                            child: Icon(
                                                                FontAwesomeIcons
                                                                    .circleInfo,
                                                                color: FColors
                                                                    .textHeader,
                                                                size: 30),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 7.0),
                                                          child: Text(
                                                              "Information",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: FColors
                                                                      .textWhite,
                                                                  fontSize:
                                                                      12)),
                                                        ),
                                                        Consumer<
                                                            SelectedValueNotifier>(
                                                          builder: (context,
                                                                  selectedValueNotifier,
                                                                  _) =>
                                                              Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 10.0),
                                                            child: Visibility(
                                                              visible:
                                                                  selectedValueNotifier
                                                                      .infoVisible,
                                                              child: Container(
                                                                width: 75,
                                                                height: 3,
                                                                color: FColors
                                                                    .textWhite,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      Provider.of<SelectedValueNotifier>(
                                                              context,
                                                              listen: false)
                                                          .setSelectedValue(
                                                              'Audit');
                                                    },
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 14.0),
                                                          child: Container(
                                                            height: 50,
                                                            width: 50,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: FColors
                                                                        .textWhite),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            70),
                                                                color: FColors
                                                                    .textWhite,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      color: Colors
                                                                              .grey[
                                                                          400]!,
                                                                      blurRadius:
                                                                          3.0,
                                                                      blurStyle:
                                                                          BlurStyle
                                                                              .normal),
                                                                ]),
                                                            child: Icon(
                                                                FontAwesomeIcons
                                                                    .listCheck,
                                                                color: FColors
                                                                    .textHeader,
                                                                size: 30),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 7.0),
                                                          child: Text("Audit",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: FColors
                                                                      .textWhite,
                                                                  fontSize:
                                                                      12)),
                                                        ),
                                                        Consumer<
                                                            SelectedValueNotifier>(
                                                          builder: (context,
                                                                  selectedValueNotifier,
                                                                  _) =>
                                                              Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 10.0),
                                                            child: Visibility(
                                                              visible:
                                                                  selectedValueNotifier
                                                                      .auditVisible,
                                                              child: Container(
                                                                width: 40,
                                                                height: 3,
                                                                color: FColors
                                                                    .textWhite,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Consumer<SelectedValueNotifier>(
                                            builder: (context,
                                                    selectedValueNotifier, _) =>
                                                Consumer<ISACProvider>(builder:
                                                    (context, isacprovider,
                                                        child) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: mainCardWidget(
                                                        context,
                                                        isacprovider
                                                            .vendorRequestModel,
                                                        selectedValueNotifier
                                                            .selectedValue,
                                                        selectedValueNotifier
                                                            .scrollHeight),
                                                  );
                                                }))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          } else if (data.returnStatus == 1) {
                            return const Text("Error");
                          }
                        }
                      }
                      return const LoadingPage();
                    },
                    future: context
                        .read<ISACProvider>()
                        .GetVendorThirdPartyRequestDetails(requestJson),
                  ),
                  // ),
                  Visibility(
                    visible: widget.isButtonVisible,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        //height: 60,
                        child: Card(
                          elevation: 0,
                          shadowColor: Colors.black,
                          color: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0)),
                          ),
                          margin: EdgeInsets.zero,
                          child: SizedBox(
                            height: 55,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 0, 10),
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            padding:
                                                const WidgetStatePropertyAll(
                                                    EdgeInsets.zero),
                                            shape: WidgetStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8))),
                                            backgroundColor:
                                                WidgetStateProperty.all<Color>(
                                                    FColors.submitColor)),
                                        child: const Text(
                                          'Authorize',
                                          style: TextStyle(
                                              color: FColors.textWhite),
                                        ),
                                        onPressed: () => {
                                              ///Json Create here
                                              requestApproveJson = {
                                                "ReqObj": {
                                                  "UserId":
                                                      GlobalVariables.userName,
                                                  "ENC_Cid": encrequestID,
                                                  "RequestType":
                                                      widget.requestType,
                                                }
                                              },
                                              HelperFunctions.confirmAlert(
                                                      "Authorizations",
                                                      'Are you sure on Authorization for Ticket No. [${widget.ticketnumber}]')
                                                  .then((value) {
                                                if (value == "Yes") {
                                                  context.loaderOverlay.show();
                                                  context
                                                      .read<ISACProvider>()
                                                      .vendorAuthRequest(
                                                          requestApproveJson)
                                                      .then((value) async {
                                                    context.loaderOverlay
                                                        .hide();

                                                    if ((value.returnStatus ==
                                                        2)) {
                                                      //To Show dialog Popup
                                                      await HelperFunctions
                                                          .showAsyncAlert(
                                                              "Success",
                                                              '${widget.ticketnumber} has been approved successfully.');

                                                      //widget
                                                      //   .callback("refresh");
                                                      context.loaderOverlay
                                                          .show();
                                                      encrequestID =
                                                          getNextRequest(
                                                              encrequestID);

                                                      if (!HelperFunctions
                                                          .isNullorEmpty(
                                                              encrequestID)) {
                                                        await Provider.of<
                                                                    ISACProvider>(
                                                                context,
                                                                listen: false)
                                                            .GetVendorThirdPartyRequestDetails({
                                                          "ReqObj": {
                                                            "UserId":
                                                                GlobalVariables
                                                                    .userName,
                                                            "ENC_Cid":
                                                                encrequestID,
                                                            "RequestType":
                                                                widget
                                                                    .requestType
                                                          }
                                                        });
                                                        context.loaderOverlay
                                                            .hide();
                                                      } else {
                                                        context.loaderOverlay
                                                            .hide();
                                                        Get.back();
                                                      }
                                                    } else if ((value
                                                                .returnStatus ==
                                                            1) ||
                                                        (value.returnStatus ==
                                                            4)) {
                                                      await HelperFunctions
                                                          .showAsyncAlert(
                                                              "AMIGO",
                                                              value
                                                                  .responseMessage!);
                                                    } else {
                                                      if (context.loaderOverlay
                                                          .visible) {
                                                        context.loaderOverlay
                                                            .hide();
                                                      }

                                                      await HelperFunctions
                                                          .showAsyncAlert(
                                                              "Error",
                                                              "Oops! Something went wrong");
                                                    }
                                                  });
                                                }
                                              }),
                                            }),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 10),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          padding: const WidgetStatePropertyAll(
                                              EdgeInsets.zero),
                                          shape: WidgetStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8))),
                                          backgroundColor:
                                              WidgetStateProperty.all<Color>(
                                                  FColors.rejectColor)),
                                      child: const Text(
                                        'Reject',
                                        style:
                                            TextStyle(color: FColors.textWhite),
                                      ),
                                      onPressed: () => {
                                        ///Json Create here

                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              openRejectPopup(
                                            context,
                                            txtRejectRemarkController,
                                          ),
                                        ).then((value) async {
                                          if (value['Value'] == 'Submit') {
                                            requestRejectJson = {
                                              "ReqObj": {
                                                "UserId":
                                                    GlobalVariables.userName,
                                                "ENC_Cid": encrequestID,
                                                "RejectionReasonId":
                                                    value['RejectionReasonId'],
                                                "OtherRejectReason":
                                                    value['Remark'],
                                                "RequestType":
                                                    widget.requestType
                                              }
                                            };
                                            HelperFunctions.confirmAlert(
                                                    "Rejection",
                                                    'Are you sure on Rejection for Ticket No. [${widget.ticketnumber}]')
                                                .then((value) {
                                              if (value == "Yes") {
                                                context
                                                    .read<ISACProvider>()
                                                    .vendorRejectRequest(
                                                        requestRejectJson)
                                                    .then((value) async {
                                                  /// To Close Loader
                                                  if (value.returnStatus == 2) {
                                                    await HelperFunctions
                                                        .showAsyncAlert(
                                                            "Success",
                                                            '${widget.ticketnumber} has been rejected successfully.');
                                                    //widget.callback("refresh");
                                                    context.loaderOverlay
                                                        .show();
                                                    encrequestID =
                                                        getNextRequest(
                                                            encrequestID);

                                                    if (!HelperFunctions
                                                        .isNullorEmpty(
                                                            encrequestID)) {
                                                      Provider.of<ISACProvider>(
                                                              context,
                                                              listen: false)
                                                          .GetVendorThirdPartyRequestDetails({
                                                        "ReqObj": {
                                                          "UserId":
                                                              GlobalVariables
                                                                  .userName,
                                                          "ENC_Cid":
                                                              encrequestID,
                                                          "RequestType":
                                                              widget.requestType
                                                        }
                                                      });
                                                    } else {
                                                      Get.back();
                                                    }
                                                    context.loaderOverlay
                                                        .hide();
                                                  } else if ((value
                                                              .returnStatus ==
                                                          1) ||
                                                      (value.returnStatus ==
                                                          4)) {
                                                    HelperFunctions.showAlert(
                                                        "AMIGO",
                                                        value.responseMessage!);
                                                  } else {
                                                    HelperFunctions.showAlert(
                                                        "Error",
                                                        "Oops! Something went wrong");
                                                  }
                                                });
                                              }
                                            });
                                          } else {}
                                        })
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ]),
          )),
    );
  }

  String getNextRequest(String requestNo) {
    print(widget.filteredRequestNo);
    String requestNumber = "";
    int currentIndex = widget.filteredRequestNo!.indexOf(requestNo);
    widget.filteredRequestNo!.removeAt(currentIndex);

    if (widget.filteredRequestNo!.isNotEmpty) {
      if (currentIndex <
          HelperFunctions.getNumber(widget.filteredRequestNo?.length) - 1) {
        requestNumber = widget.filteredRequestNo![currentIndex];
      } else {
        currentIndex = 0;
        requestNumber = widget.filteredRequestNo![currentIndex];
      }
    } else {
      requestNumber = "";
    }

    return requestNumber;
  }
}

// String getTicketNumber(String requestNo) {

//     String requestNumber = "";
//     int currentIndex = widget.VendorTicketNumber!.indexOf(requestNo);
//     widget.VendorTicketNumber!.removeAt(currentIndex);

//     if (widget.VendorTicketNumber!.isNotEmpty) {
//       if (currentIndex <
//           HelperFunctions.getNumber(widget.VendorTicketNumber?.length) - 1) {
//         requestNumber = widget.VendorTicketNumber![currentIndex];
//       } else {
//         currentIndex = 0;
//         requestNumber = widget.VendorTicketNumber![currentIndex];
//       }
//     } else {
//       requestNumber = "";
//     }

//     return requestNumber;
//   }
// }

///************************************************
///  Selected Card tab View
///************************************************

mainCardWidget(BuildContext context, ISACVendorRequestDetailModel model,
    String selectedtabvalue, double height) {
  List<ProprietorPANDetail> proprietorDetails = [];
  List<DetailData> data = [];
  List<AuditTrail> AuditdataItem = [];
  List<VendorHDFCContactList> vendorHDFCContactList = [];
  if (model.detailData != null) {
    data = model.detailData!;
  }

  if (model.auditTrail != null) {
    AuditdataItem = model.auditTrail!;
  }
  if (model.proprietorPANDetail != null) {
    proprietorDetails = model.proprietorPANDetail!;
  }
  if (model.vendorHDFCContactList != null) {
    vendorHDFCContactList = model.vendorHDFCContactList!;
  }
  if (selectedtabvalue == "Info") {
    return SizedBox(
      height: MediaQuery.of(context).size.height - height,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            getSelectedScreen(
                context,
                data as List<DetailData>,
                AuditdataItem as List<AuditTrail>,
                proprietorDetails as List<ProprietorPANDetail>,
                vendorHDFCContactList as List<VendorHDFCContactList>,
                selectedtabvalue,
                "Vendor Details",
                height),
            if ((proprietorDetails != null) && (proprietorDetails.isNotEmpty))
              getSelectedScreen(
                  context,
                  data as List<DetailData>,
                  AuditdataItem as List<AuditTrail>,
                  proprietorDetails as List<ProprietorPANDetail>,
                  vendorHDFCContactList as List<VendorHDFCContactList>,
                  selectedtabvalue,
                  "Proprietor / Partner / Director's PAN Details",
                  height),
            if ((vendorHDFCContactList != null) &&
                (vendorHDFCContactList.isNotEmpty))
              getSelectedScreen(
                  context,
                  data as List<DetailData>,
                  AuditdataItem as List<AuditTrail>,
                  proprietorDetails as List<ProprietorPANDetail>,
                  vendorHDFCContactList as List<VendorHDFCContactList>,
                  selectedtabvalue,
                  "Vendor HDFC Contact (SPOC) List",
                  height),
          ],
        ),
      ),
    );
  }
  if (selectedtabvalue == "Audit") {
    SizedBox nullWidget = const SizedBox(child: NoDataFountWidget());
    if (AuditdataItem == null) {
      return Padding(
          padding: const EdgeInsets.only(top: 5.0), child: nullWidget);
    } else {
      return getSelectedScreen(
          context,
          data as List<DetailData>,
          AuditdataItem as List<AuditTrail>,
          proprietorDetails as List<ProprietorPANDetail>,
          vendorHDFCContactList as List<VendorHDFCContactList>,
          selectedtabvalue,
          "Audit Trail",
          height);
    }
  }
}

///************************************************
///  Selected tab View
///************************************************

Padding getSelectedScreen(
    BuildContext context,
    List<DetailData> detaildata,
    List<AuditTrail> data,
    List<ProprietorPANDetail> proprietorDetails,
    List<VendorHDFCContactList> vendorHDFCContactList,
    String screenType,
    String displayHeading,
    double height) {
  SizedBox nullWidget = const SizedBox(child: NoDataFountWidget());
  SizedBox widget = nullWidget;
  if (data.isEmpty) {
    return Padding(padding: const EdgeInsets.only(top: 8.0), child: nullWidget);
  }
  switch (screenType) {
    case "Info":
      if (displayHeading.contains("Proprietor")) {
        widget = data != null
            ? SizedBox(
                child: Card(
                    margin: const EdgeInsets.all(8),
                    child: PropritorPartnerDetailsView(
                      proprietorDetails: proprietorDetails,
                    )),
              )
            : nullWidget;
      }
      if (displayHeading.contains("Vendor Details")) {
        widget = data != null
            ? SizedBox(
                child: Card(
                    margin: const EdgeInsets.all(8),
                    child:
                        VendorRequestListDetailsWidget(dataItem: detaildata)),
              )
            : nullWidget;
      }
      if (displayHeading.contains("Vendor HDFC Contact (SPOC) List")) {
        widget = data != null
            ? SizedBox(
                child: Card(
                    margin: const EdgeInsets.all(8),
                    child: VendorHDFCContactListView(
                        vendorHDFCContactList: vendorHDFCContactList)),
              )
            : nullWidget;
      }
      break;
    case "Audit":
      widget = data != null
          ? SizedBox(
              height: MediaQuery.of(context).size.height - height - 40,
              child: Card(
                margin: EdgeInsets.all(8),
                child: Column(children: [
                  Expanded(
                    child: AuditListWidget(
                      auditTrail: data,
                    ),
                  ),
                ]),
              ))
          : nullWidget;
      break;
  }

  return Padding(
    padding: const EdgeInsets.only(top: 0.0),
    child: SizedBox(
      //height: 220,
      child: Column(children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(displayHeading,
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: FColors.textPrimary,
                    fontSize: 16)),
          ),
        ),
        widget
      ]),
    ),
  );
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: LoadingAnimationWidget.discreteCircle(
          color: FColors.textHeader,
          secondRingColor: FColors.textHeader,
          thirdRingColor: const Color(0xFFEA3799),
          size: 200,
        ),
      ),
    );
  }
}
