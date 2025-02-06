import 'package:push_notification/common/widgets/background_screen.dart';
import 'package:push_notification/common/widgets/no_data_found_widget.dart';
import 'package:push_notification/common/widgets/somthing_went_wrong.dart';
import 'package:push_notification/features/iApproval/screens/dashboard/widget/header_widget.dart';
import 'package:push_notification/features/iSAC/models/isac_request_details_response.dart';
import 'package:push_notification/features/iSAC/screens/request_list/widget/isac_request_item_widget.dart';
import 'package:push_notification/features/iSAC/screens/request_list_details/widget/audit_list_widget.dart';
import 'package:push_notification/features/iSAC/screens/request_list_details/widget/business_approver.dart';
import 'package:push_notification/features/iSAC/screens/request_list_details/widget/info_application_specific_widget.dart';
import 'package:push_notification/features/iSAC/screens/request_list_details/widget/info_details_widget.dart';
import 'package:push_notification/features/iSAC/screens/request_list_details/widget/info_functional.dart';
import 'package:push_notification/features/iSAC/screens/request_list_details/widget/recepient_details_widget.dart';
import 'package:push_notification/features/iSAC/screens/request_list_details/widget/reject_reason_widget.dart';
import 'package:push_notification/utility/constants/colors.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../providers/isac_provider.dart';

//typedef StringCallback = void Function(String val);

class ISACDetailsScreen extends StatefulWidget {
  final String encrequestID;
  final String formID;
  final String ticketnumber;
  final bool isButtonVisible;
  //final StringCallback callback;
  final List<String>? filteredRequestNo;
  final List<String>? filteredFormNo;
  const ISACDetailsScreen(
      {super.key,
      required this.encrequestID,
      required this.isButtonVisible,
      required this.formID,
      required this.ticketnumber,
      //required this.callback,
      required this.filteredRequestNo,
      required this.filteredFormNo});

  @override
  State<ISACDetailsScreen> createState() => _ISACDetailsScreenState();
}

class _ISACDetailsScreenState extends State<ISACDetailsScreen> {
  TextEditingController txtRejectRemarkController = TextEditingController();
  TextEditingController txtApproveRemarkController = TextEditingController();
  @override
  void dispose() {
    txtRejectRemarkController.dispose();
    txtApproveRemarkController.dispose();
    super.dispose();
  }

  String encrequestID = "";
  String ticketnumber = "";
  String formID = "";
  bool isNumChanged = false;
  //List<RejectReasonData> rejectReasonLis = [];

  @override
  Widget build(BuildContext context) {
    if (!isNumChanged) {
      encrequestID = widget.encrequestID;
      ticketnumber = widget.ticketnumber;
      if (widget.isButtonVisible == true) {
        formID = widget.formID;
      } else if (widget.isButtonVisible == false) {
        formID = "0";
      }
    }
    var requestJson = <String, String>{
      'ENC_RequestID': encrequestID,
      'FormID': formID,
    };
    var requestApproveJson = {
      'ENC_RequestID': encrequestID,
      'command': 'AUTHORISE',
      'RejectionResentRemark': '',
      'RejectionReasonID': 0
    };
    var requestRejectJson = {
      'ENC_RequestID': encrequestID,
      'command': 'REJECT',
      'RejectionResentRemark': '',
      'RejectionReasonID': 0
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
            overlayColor: Colors.black.withOpacity(0.2),
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
                  Expanded(
                    child: FutureBuilder(
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          context.loaderOverlay.show();
                        }
                        if (snapshot.connectionState == ConnectionState.done) {
                          context.loaderOverlay.hide();
                          if (snapshot.hasError) {
                            return const NoDataFountWidget();
                          } else if (snapshot.hasData) {
                            var data = snapshot.data as ISACRequestDetailsClass;
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
                                    Container(
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/screen_bg.png'),
                                            fit: BoxFit.cover),
                                      ),
                                      child: ExpansionTile(
                                        textColor: FColors.textWhite,
                                        collapsedIconColor: FColors.textWhite,
                                        title: Consumer<ISACProvider>(
                                            builder: (context, value, child) {
                                          ticketnumber = value.selectedNumber;
                                          return Text(
                                            value.selectedNumber,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          );
                                        }),
                                        iconColor: FColors.textWhite,
                                        children: [
                                          ExpansionTileInfo(data: data),
                                        ],
                                        onExpansionChanged: (bool isExpanded) {
                                          if (isExpanded == true) {
                                            Provider.of<SelectedValueNotifier>(
                                                    context,
                                                    listen: false)
                                                .setHeight(470);
                                          } else {
                                            Provider.of<SelectedValueNotifier>(
                                                    context,
                                                    listen: false)
                                                .setHeight(320);
                                          }
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0),
                                      child: Column(
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          'assets/images/screen_bg.png'),
                                                      fit: BoxFit.cover),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10,
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
                                                                      top:
                                                                          14.0),
                                                              child: Container(
                                                                height: 50,
                                                                width: 50,
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        color: FColors
                                                                            .textWhite),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            70),
                                                                    color: FColors
                                                                        .textWhite,
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                          color: Colors.grey[
                                                                              400]!,
                                                                          blurRadius:
                                                                              3.0,
                                                                          blurStyle:
                                                                              BlurStyle.normal),
                                                                    ]),
                                                                child: const Icon(
                                                                    FontAwesomeIcons
                                                                        .circleInfo,
                                                                    color: FColors
                                                                        .textHeader,
                                                                    size: 30),
                                                              ),
                                                            ),
                                                            const Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 7.0),
                                                              child: Text(
                                                                  "Information",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
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
                                                                        top:
                                                                            10.0),
                                                                child:
                                                                    Visibility(
                                                                  visible:
                                                                      selectedValueNotifier
                                                                          .infoVisible,
                                                                  child:
                                                                      Container(
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
                                                      const SizedBox(
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
                                                                      top:
                                                                          14.0),
                                                              child: Container(
                                                                height: 50,
                                                                width: 50,
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        color: FColors
                                                                            .textWhite),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            70),
                                                                    color: FColors
                                                                        .textWhite,
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                          color: Colors.grey[
                                                                              400]!,
                                                                          blurRadius:
                                                                              3.0,
                                                                          blurStyle:
                                                                              BlurStyle.normal),
                                                                    ]),
                                                                child: const Icon(
                                                                    FontAwesomeIcons
                                                                        .listCheck,
                                                                    color: FColors
                                                                        .textHeader,
                                                                    size: 30),
                                                              ),
                                                            ),
                                                            const Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 7.0),
                                                              child: Text(
                                                                  "Audit",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
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
                                                                        top:
                                                                            10.0),
                                                                child:
                                                                    Visibility(
                                                                  visible:
                                                                      selectedValueNotifier
                                                                          .auditVisible,
                                                                  child:
                                                                      Container(
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
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                            ],
                                          ),
                                          // SizedBox(
                                          //   height: 15,
                                          // ),
                                          Consumer<SelectedValueNotifier>(
                                            builder: (context,
                                                    selectedValueNotifier, _) =>
                                                Consumer<ISACProvider>(builder:
                                                    (context, isacprovider,
                                                        child) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 12.0),
                                                child: mainCardWidget(
                                                    context,
                                                    isacprovider.isacdetailres,
                                                    selectedValueNotifier
                                                        .selectedValue,
                                                    selectedValueNotifier
                                                        .scrollHeight),
                                              );
                                            }),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            } else if (data.returnStatus == 1) {
                              return const SomthingWentWrongWidget();
                            }
                          }
                        }
                        return const LoadingPage();
                      },
                      future: context
                          .read<ISACProvider>()
                          .getiSACRequestListDetailsData(requestJson),
                    ),
                  ),
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
                                                'ENC_RequestID':
                                                    encrequestID.toString(),
                                                'command': 'AUTHORISE',
                                                'RejectionResentRemark': '',
                                                'RejectionReasonID': 0
                                              },
                                              HelperFunctions.confirmAlert(
                                                      "Authorizations",
                                                      'Are you sure on Authorization for Ticket No. [${ticketnumber}]')
                                                  .then((value) {
                                                if (value == "Yes") {
                                                  context.loaderOverlay.show();
                                                  context
                                                      .read<ISACProvider>()
                                                      .isacApproveRejectRequest(
                                                          requestApproveJson)
                                                      .then((value) async {
                                                    context.loaderOverlay
                                                        .hide();

                                                    if (value.returnStatus ==
                                                        2) {
                                                      await HelperFunctions
                                                          .showAsyncAlert(
                                                              "Success",
                                                              '${ticketnumber} has been approved successfully.');
                                                      //widget.callback("refresh");
                                                      context.loaderOverlay
                                                          .show();
                                                      encrequestID =
                                                          getNextRequest(
                                                              encrequestID);
                                                      formID =
                                                          getNextFormID(formID);
                                                      if (!HelperFunctions
                                                          .isNullorEmpty(
                                                              encrequestID)) {
                                                        context
                                                            .read<
                                                                ISACProvider>()
                                                            .getiSACRequestListDetailsData({
                                                          'ENC_RequestID':
                                                              encrequestID,
                                                          'FormID': formID,
                                                        });
                                                        context.loaderOverlay
                                                            .hide();
                                                      } else {
                                                        Get.back(
                                                            result: "refresh");
                                                      }
                                                    } else if ((value
                                                                .returnStatus ==
                                                            1) ||
                                                        (value.returnStatus ==
                                                            4)) {
                                                      HelperFunctions.showAlert(
                                                          "AMIGO",
                                                          value
                                                              .responseMessage!);
                                                    } else {
                                                      HelperFunctions.showAlert(
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
                                                  true),
                                        ).then((value) async {
                                          if (value['Value'] == 'Submit') {
                                            context.loaderOverlay.show();
                                            requestRejectJson = {
                                              'ENC_RequestID':
                                                  encrequestID.toString(),
                                              'command': 'REJECT',
                                              'RejectionResentRemark':
                                                  value['Remark'],
                                              'RejectionReasonID':
                                                  value['RejectionReasonID']
                                            };
                                            HelperFunctions.confirmAlert(
                                                    "Rejection",
                                                    'Are you sure on Rejection for Ticket No. [${ticketnumber}]')
                                                .then((value) {
                                              if (value == "Yes") {
                                                context
                                                    .read<ISACProvider>()
                                                    .isacApproveRejectRequest(
                                                        requestRejectJson)
                                                    .then((value) async {
                                                  context.loaderOverlay.hide();
                                                  if (value.returnStatus == 2) {
                                                    await HelperFunctions
                                                        .showAsyncAlert(
                                                            "Success",
                                                            '${ticketnumber} has been rejected successfully.');
                                                    //widget.callback("refresh");
                                                    context.loaderOverlay
                                                        .show();
                                                    encrequestID =
                                                        getNextRequest(
                                                            encrequestID);
                                                    formID =
                                                        getNextFormID(formID);
                                                    if (!HelperFunctions
                                                        .isNullorEmpty(
                                                            encrequestID)) {
                                                      context
                                                          .read<ISACProvider>()
                                                          .getiSACRequestListDetailsData({
                                                        'ENC_RequestID':
                                                            encrequestID,
                                                        'FormID': formID,
                                                      });
                                                      context.loaderOverlay
                                                          .hide();
                                                    } else {
                                                      Get.back(
                                                          result: "refresh");
                                                    }
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
                                              } else if (value == "No") {
                                                context.loaderOverlay.hide();
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

  String getNextFormID(String requestNo) {
    print(widget.filteredFormNo);
    String requestNumber = "";
    int currentIndex = widget.filteredFormNo!.indexOf(requestNo);
    widget.filteredFormNo!.removeAt(currentIndex);

    if (widget.filteredFormNo!.isNotEmpty) {
      if (currentIndex <
          HelperFunctions.getNumber(widget.filteredFormNo?.length) - 1) {
        requestNumber = widget.filteredFormNo![currentIndex];
      } else {
        currentIndex = 0;
        requestNumber = widget.filteredFormNo![currentIndex];
      }
    } else {
      requestNumber = "";
    }

    return requestNumber;
  }
}

///************************************************
///  ExpansionTileData Information View
///************************************************
class ExpansionTileInfo extends StatefulWidget {
  const ExpansionTileInfo({super.key, required this.data});
  final ISACRequestDetailsClass data;

  @override
  State<ExpansionTileInfo> createState() => _ExpansionTileInfoState();
}

class _ExpansionTileInfoState extends State<ExpansionTileInfo> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '${widget.data.ticketData!.identityStoreMaster?.empName.toString()} (${widget.data.ticketData?.identityStoreMaster?.empCode.toString()})',
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
              Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.solidEnvelope,
                    color: FColors.textWhite,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Text(
                    widget.data.ticketData?.identityStoreMaster?.emailId
                            .toString() ??
                        "NA",
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  )
                ],
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.locationDot,
                    color: FColors.textWhite,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Text(
                    '${widget.data.ticketData!.identityStoreMaster?.branchCode.toString()} - ${widget.data.ticketData?.identityStoreMaster?.branchName.toString()}',
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  )
                ],
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.peopleGroup,
                    color: FColors.textWhite,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Text(
                    '${widget.data.ticketData!.identityStoreMaster?.costCode.toString()} - ${widget.data.ticketData?.identityStoreMaster?.costCenterName.toString()}',
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  )
                ],
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.building,
                    color: FColors.textWhite,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Text(
                    widget.data.ticketData?.identityStoreMaster?.companyName
                            .toString() ??
                        "NA",
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///************************************************
///  Selected Card tab View
///************************************************

mainCardWidget(BuildContext context, ISACRequestDetailsClass data,
    String selectedtabvalue, double height) {
  print(data.ticketData!.requestTypeValue);
  if (selectedtabvalue == "Info") {
    return SizedBox(
      height: MediaQuery.of(context).size.height - height,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            getSelectedScreen(context, data, selectedtabvalue,
                "Application User ID Information"),
            getSelectedScreen(context, data, selectedtabvalue,
                "Application Specific Information"),
            if ((data.ticketData!.vendorCompany != null) &&
                (data.ticketData!.vendorCompany!.isNotEmpty))
              getSelectedScreen(
                  context, data, selectedtabvalue, "Recepient Details"),
            if ((data.ticketData!.currentApprover != null) &&
                (data.ticketData!.currentApprover!.isNotEmpty))
              getSelectedScreen(context, data, selectedtabvalue,
                  "Functional Approver Information"),
            if ((data.ticketData!.reasonDesc != null) &&
                (data.ticketData!.reasonDesc!.isNotEmpty))
              getSelectedScreen(
                  context, data, selectedtabvalue, "Reject Reason"),
            if ((data.ticketData!.businessApproverName!.isNotEmpty) &&
                (data.ticketData!.businessApproverName!.trim() != null))
              getSelectedScreen(context, data, selectedtabvalue,
                  "Business Approver Information"),
          ],
        ),
      ),
    );
  }
  if (selectedtabvalue == "Audit") {
    return SizedBox(
      height: MediaQuery.of(context).size.height - height,
      child: SingleChildScrollView(
        child: Column(children: [
          getSelectedScreen(context, data, selectedtabvalue, "Audit Trail")
        ]),
      ),
    );
  }
}

///************************************************
///  Selected tab View
///************************************************

getSelectedScreen(BuildContext context, ISACRequestDetailsClass data,
    String screenType, String displayHeading) {
  SizedBox nullWidget = const SizedBox(child: NoDataFountWidget());
  SizedBox widget = nullWidget;
  if (data.ticketData == null) {
    return Padding(padding: const EdgeInsets.only(top: 8.0), child: nullWidget);
  }
  {
    switch (screenType) {
      case "Info":
        if (displayHeading.contains("User")) {
          widget = data.ticketData != null
              ? SizedBox(
                  child: Card(
                      margin: const EdgeInsets.all(8),
                      child: InfoDetailsView(
                        infoDetails: data,
                      )),
                )
              : nullWidget;
        }
        if (displayHeading.contains("Specific")) {
          widget = data.ticketData != null
              ? SizedBox(
                  child: Card(
                      margin: const EdgeInsets.all(8),
                      child: InfoAppSpecificView(
                        appListData: data.ticketData!.applicationSpecificInfo!,
                      )),
                )
              : nullWidget;
        }
        if (displayHeading.contains("Functional")) {
          widget = data.ticketData != null
              ? SizedBox(
                  child: Card(
                      margin: const EdgeInsets.all(8),
                      child: InfoFUNCTIONALView(
                        infoDetails: data,
                      )),
                )
              : nullWidget;
        }
        if (displayHeading.contains("Recepient")) {
          widget = data.ticketData != null
              ? SizedBox(
                  child: Card(
                      margin: const EdgeInsets.all(8),
                      child: RecepientDetailsView(
                        infoDetails: data,
                      )),
                )
              : nullWidget;
        }
        if (displayHeading.contains("Reject")) {
          widget = data.ticketData != null
              ? SizedBox(
                  child: Card(
                      margin: const EdgeInsets.all(8),
                      child: RejectReasonView(
                        infoDetails: data,
                      )),
                )
              : nullWidget;
        }
        if (data.ticketData!.businessApproverName!.trim() != "") {
          if (displayHeading.contains("Business")) {
            widget = data.ticketData != null
                ? SizedBox(
                    child: Card(
                        margin: const EdgeInsets.all(8),
                        child: BusinessApproverView(
                          infoDetails: data,
                        )),
                  )
                : nullWidget;
          }
        }
        break;
      case "Audit":
        widget = SizedBox(
          child: AuditListWidget(
            requestTicketMISDetailsList:
                data.ticketData!.requestTicketMISDetailsList!,
          ),
        );
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
              padding: const EdgeInsets.all(12),
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
