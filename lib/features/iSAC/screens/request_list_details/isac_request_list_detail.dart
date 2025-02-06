// ignore_for_file: prefer_const_constructors

import 'package:push_notification/common/widgets/background_screen.dart';
import 'package:push_notification/common/widgets/no_data_found_widget.dart';
import 'package:push_notification/features/iApproval/screens/dashboard/widget/header_widget.dart';
import 'package:push_notification/features/iSAC/models/isac_request_details_response.dart';
import 'package:push_notification/features/iSAC/providers/isac_provider.dart';
import 'package:push_notification/features/iSAC/screens/request_list/widget/isac_request_item_widget.dart';
import 'package:push_notification/features/iSAC/screens/request_list_details/widget/Info_requestor_details_widget.dart';
import 'package:push_notification/features/iSAC/screens/request_list_details/widget/audit_list_widget.dart';
import 'package:push_notification/features/iSAC/screens/request_list_details/widget/info_application_specific_widget.dart';
import 'package:push_notification/features/iSAC/screens/request_list_details/widget/info_details_widget.dart';
import 'package:push_notification/features/iSAC/screens/request_list_details/widget/info_functional.dart';
import 'package:push_notification/features/iSAC/screens/request_list_details/widget/recepient_details_widget.dart';
import 'package:push_notification/features/iSAC/screens/request_list_details/widget/reject_reason_widget.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:push_notification/features/iSAC/screens/request_list_details/widget/iSAC_menu_list.dart';
import 'package:push_notification/utility/constants/colors.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ISACDetailScreen extends StatefulWidget {
  final String encrequestID;
  final String formID;
  final String ticketnumber;
  final bool isButtonVisible;
  const ISACDetailScreen(
      {super.key,
      required this.encrequestID,
      required this.isButtonVisible,
      required this.formID,
      required this.ticketnumber});

  @override
  State<ISACDetailScreen> createState() => _ISACDetailsScreenState();
}

class _ISACDetailsScreenState extends State<ISACDetailScreen> {
  TextEditingController txtRejectRemarkController = TextEditingController();
  TextEditingController txtApproveRemarkController = TextEditingController();
  @override
  void dispose() {
    txtRejectRemarkController.dispose();
    txtApproveRemarkController.dispose();
    super.dispose();
  }

  String selectedValue = "Information";
  @override
  Widget build(BuildContext context) {
    var requestJson = <String, String>{
      'ENC_RequestID': widget.encrequestID,
      'FormID': widget.formID,
    };
    var requestApproveJson = <String, String>{
      'UserId': GlobalVariables.userName,
      'ticketnumber': '',
      'Remark': ''
    };
    var requestRejectJson = <String, String>{
      'UserId': GlobalVariables.userName,
      'FpnNo': '',
      'Remark': ''
    };
    return Scaffold(
        backgroundColor: FColors.light,
        body: Stack(children: [
          BackgrounScreenWidget(
            height: 240,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: HeaderWidget(
                  title: widget.ticketnumber,
                  icon: "back",
                  iconColor: Colors.white,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    getISACMenus(context),
                    FutureBuilder(
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            return const NoDataFountWidget();
                          } else if (snapshot.hasData) {
                            var data = snapshot.data as ISACRequestDetailsClass;
                            if (data.returnStatus == 3) {
                              return const NoDataFountWidget();
                            } else if (data.returnStatus == 2) {
                              return OrientationBuilder(
                                builder: (context, orientation) {
                                  return (orientation == Orientation.portrait)
                                      ? Consumer<ISACProvider>(
                                          builder: (context, value, child) {
                                            return mainCardWidget(
                                                context, data, selectedValue);
                                          },
                                        )
                                      : const SizedBox();
                                },
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
                          .getRequestListDetailsData(requestJson),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
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
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    padding: const WidgetStatePropertyAll(
                                        EdgeInsets.zero),
                                    shape: WidgetStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8))),
                                    backgroundColor:
                                        WidgetStateProperty.all<Color>(
                                            FColors.submitColor)),
                                child: const Text(
                                  'Approve',
                                  style: TextStyle(color: FColors.textWhite),
                                ),
                                onPressed: () => {
                                      ///Json Create here
                                      requestApproveJson['TicketNo'] =
                                          widget.ticketnumber.toString(),
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            popupApproveAlert(context,
                                                txtApproveRemarkController),
                                      ).then((value) {
                                        if (value == 'Submit') {
                                          ///To Show Loader Popup
                                          requestApproveJson['Remark'] =
                                              txtApproveRemarkController.text;
                                          context.loaderOverlay.show();
                                          context
                                              .read<ISACProvider>()
                                              .isacApproveRejectRequest(
                                                  requestApproveJson)
                                              .then((value) async {
                                            /// To Close Loader
                                            context.loaderOverlay.hide();
                                            if (value.returnStatus == 2) {
                                              await HelperFunctions.showAsyncAlert(
                                                  "Success",
                                                  '${widget.ticketnumber} has been approved successfully.');
                                              // widget.callback("refresh");
                                            }
                                          });
                                        } else {}
                                      })
                                    }),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  padding: const WidgetStatePropertyAll(
                                      EdgeInsets.zero),
                                  shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(
                                          FColors.rejectedDark)),
                              child: const Text(
                                'Reject',
                                style: TextStyle(color: FColors.textWhite),
                              ),
                              onPressed: () => {
                                ///Json Create here

                                requestRejectJson['TicketNumber'] =
                                    widget.ticketnumber.toString(),
                                // showDialog(
                                //   context: context,
                                //   builder: (BuildContext context) =>
                                //       popupRejectAlert(
                                //           context,
                                //           txtRejectRemarkController,
                                //           rejectReasonLis),
                                //   ).then((value) async {
                                //   if (value == 'Submit') {
                                //     /// To Show Loader
                                //     requestRejectJson['Remark'] =
                                //         txtRejectRemarkController.text;
                                //     context
                                //         .read<ISACProvider>()
                                //         .isacRejectRequest(requestRejectJson)
                                //         .then((value) {
                                //       /// To Close Loader
                                //       if (value.returnStatus == 2) {
                                //         HelperFunctions.showAlert("Success",
                                //             '${widget.ticketnumber} has been rejected successfully.');
                                //         // widget.callback("refresh");
                                //       }
                                //     });
                                //   } else {}
                                // })
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ]));
  }

  Padding getISACMenus(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: Card(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedValue =
                                ISACDetailMenus.isacMenuList[0].name;
                          });
                        },
                        child: BorderedLabelIconWidget(
                            icon: ISACDetailMenus.isacMenuList[0].icon,
                            name: ISACDetailMenus.isacMenuList[0].name,
                            height: 110,
                            isSelected: ISACDetailMenus.isacMenuList[0].name ==
                                selectedValue),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedValue =
                                ISACDetailMenus.isacMenuList[1].name;
                          });
                        },
                        child: BorderedLabelIconWidget(
                            icon: ISACDetailMenus.isacMenuList[1].icon,
                            name: ISACDetailMenus.isacMenuList[1].name,
                            height: 110,
                            isSelected: ISACDetailMenus.isacMenuList[1].name ==
                                selectedValue),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedValue =
                                ISACDetailMenus.isacMenuList[2].name;
                          });
                        },
                        child: BorderedLabelIconWidget(
                            icon: ISACDetailMenus.isacMenuList[2].icon,
                            name: ISACDetailMenus.isacMenuList[2].name,
                            height: 110,
                            isSelected: ISACDetailMenus.isacMenuList[2].name ==
                                selectedValue),
                      ),
                    ]),
              ],
            ),
          ),
        ));
  }

  mainCardWidget(BuildContext context, ISACRequestDetailsClass data,
      String selectedtabvalue) {
    if (selectedtabvalue == "Information") {
      return SizedBox(
        height: MediaQuery.of(context).size.height - 295,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              getSelectedScreen(context, data, selectedtabvalue,
                  "Application User ID Information"),
              getSelectedScreen(context, data, selectedtabvalue,
                  "Application Specific Information"),
              getSelectedScreen(
                  context, data, selectedtabvalue, "Recepient Details"),
              getSelectedScreen(context, data, selectedtabvalue,
                  "Functional Approver Information"),
              getSelectedScreen(
                  context, data, selectedtabvalue, "Reject Reason"),
            ],
          ),
        ),
      );
    }
    if (selectedtabvalue == "Audit Trail") {
      return SizedBox(
        height: MediaQuery.of(context).size.height - 295,
        child: SingleChildScrollView(
          child: Column(children: [
            getSelectedScreen(context, data, selectedtabvalue, "")
          ]),
        ),
      );
    }
    if (selectedtabvalue == "Requestor Info") {
      return SizedBox(
        height: MediaQuery.of(context).size.height - 295,
        child: SingleChildScrollView(
          child: Column(children: [
            getSelectedScreen(context, data, selectedtabvalue, "Requestor")
          ]),
        ),
      );
    }
  }

  Padding getSelectedScreen(BuildContext context, ISACRequestDetailsClass data,
      String screenType, String displayHeading) {
    SizedBox nullWidget = const SizedBox(child: NoDataFountWidget());
    SizedBox widget = nullWidget;
    if (data.ticketData == null) {
      return Padding(
          padding: const EdgeInsets.only(top: 8.0), child: nullWidget);
    }
    switch (screenType) {
      case "Information":
        if (displayHeading.contains("User")) {
          widget = data.ticketData != null
              ? SizedBox(
                  child: Card(
                      margin: EdgeInsets.all(8),
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
                      margin: EdgeInsets.all(8),
                      child: InfoAppSpecificView(
                        appListData: data.ticketData!.applicationSpecificInfo!,
                      )),
                )
              : nullWidget;
        }
        if (displayHeading.contains("Approver")) {
          widget = data.ticketData != null
              ? SizedBox(
                  child: Card(
                      margin: EdgeInsets.all(8),
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
                      margin: EdgeInsets.all(8),
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
                      margin: EdgeInsets.all(8),
                      child: RejectReasonView(
                        infoDetails: data,
                      )),
                )
              : nullWidget;
        }

        break;
      case "Requestor Info":
        if (displayHeading.contains("Requestor")) {
          widget = data.ticketData != null
              ? SizedBox(
                  child: Card(
                      child: RequestorInfoDetailsView(
                    infoDetails: data,
                  )),
                )
              : nullWidget;
          break;
        }
      case "Audit Trail":
        widget = SizedBox(
          child: AuditListWidget(
            requestTicketMISDetailsList:
                data.ticketData!.requestTicketMISDetailsList!,
          ),
        );
        break;
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: SizedBox(
        //height: MediaQuery.of(context).size.height - 395,
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

class Divider extends StatelessWidget {
  const Divider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 1.5, width: double.infinity, color: FColors.dividerColor);
  }
}
