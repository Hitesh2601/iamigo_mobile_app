import 'package:push_notification/common/widgets/bottom_right_curve_card.dart';
import 'package:push_notification/common/widgets/label_value_widget.dart';
import 'package:push_notification/features/iCart/models/icart_request_response.dart';
import 'package:push_notification/features/iCart/providers/icart_filter_provider.dart';
import 'package:push_notification/features/iCart/providers/icart_request_list_provider.dart';
import 'package:push_notification/features/iCart/providers/software_detail_provider.dart';
import 'package:push_notification/features/iCart/screens/request_detail/software/software_detail_screen.dart';
import 'package:push_notification/utility/constants/colors.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class SoftwareRequestItem extends StatelessWidget {
  final RequestListSoftware dataItem;
  final bool isPending;
  final String profile;
  final String requestType;
  final List<String>? filteredRequestNo;

  const SoftwareRequestItem({
    required this.dataItem,
    required this.isPending,
    required this.profile,
    required this.requestType,
    required this.filteredRequestNo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController txtApproveRemarkController = TextEditingController();
    TextEditingController txtRejectRemarkController = TextEditingController();

    return Stack(
      children: [
        const BottomRightCurveCardWidget(
          height: 310,
        ),
        InkWell(
          onTap: () async {
            await Get.to(ChangeNotifierProvider<SoftwareDetailProvider>(
              create: (_) => SoftwareDetailProvider(),
              child: SoftwareDetailsScreen(
                  requestNumber: '${dataItem.requestNo}',
                  profile: profile,
                  isButtonVisible: isPending,
                  filteredRequestNo: filteredRequestNo),
            ));
            context.loaderOverlay.show();
            await context.read<ICartRequestListProvider>().getRequestListData({
              "RegObj": {
                "UserId": GlobalVariables.userName,
                "RequestStatus": requestType,
                "Profile": profile,
                "HardwareReqParams": {
                  "HardwarePageNo": "0",
                  "filter": {
                    "Unit": context.read<ICartFilterProvider>().selectedUnit,
                    "HardwareRequestType":
                        context.read<ICartFilterProvider>().selectedType,
                    "UnitSpecification":
                        context.read<ICartFilterProvider>().selectedDesc.isEmpty
                            ? null
                            : [context.read<ICartFilterProvider>().selectedDesc]
                  }
                },
                "SoftwareReqParams": {
                  "SoftwarePageNo": "0",
                  "filter": {
                    "SoftwareRequestType":
                        context.read<ICartFilterProvider>().selectedSWType,
                    "Software":
                        context.read<ICartFilterProvider>().selectedSWUnit
                  }
                }
              }
            });
            context.loaderOverlay.hide();
          },
          child: Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(95)),
            ),
            color: Colors.white,
            elevation: 1,
            child: SizedBox(
              height: 310,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 0,
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 0,
                          child: Text(
                            '${dataItem.requestNo}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: FColors.listHeaderText,
                                fontSize: 17),
                          ),
                        ),
                        Visibility(
                          visible: isPending,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                color: Colors.white,
                                padding: EdgeInsets.zero,
                                iconSize: 30,
                                icon: const Icon(
                                    FontAwesomeIcons.solidCircleCheck,
                                    color: FColors.submitColor),
                                onPressed: () => {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        iCartSWApproveAlert(context,
                                            txtApproveRemarkController),
                                  ).then((value) {
                                    try {
                                      if (value == 'Submit') {
                                        ///To Show Loader Popup
                                        context.loaderOverlay.show();
                                        context
                                            .read<ICartRequestListProvider>()
                                            .iCartApproveRequest({
                                          "RegObj": {
                                            "UserId": GlobalVariables.userName,
                                            "Profile": profile,
                                            "RequestType": "Software",
                                            "Request": [
                                              {
                                                "RequestNo": dataItem.requestNo,
                                                "Remark":
                                                    txtApproveRemarkController
                                                        .text
                                                        .toString(),
                                                "ChangeApprover": false,
                                                "NextApproverId": "",
                                                "Reason": "",
                                                "IsHardDiskFormatting": ""
                                              }
                                            ]
                                          }
                                        }).then((value) async {
                                          context.loaderOverlay.hide();
                                          if (value.returnStatus == 2) {
                                            txtApproveRemarkController.text =
                                                "";
                                            await HelperFunctions.showAsyncAlert(
                                                "Success",
                                                '${dataItem.requestNo} has been approved successfully.');
                                            context.loaderOverlay.show();
                                            await context
                                                .read<
                                                    ICartRequestListProvider>()
                                                .getRequestListData({
                                              "RegObj": {
                                                "UserId":
                                                    GlobalVariables.userName,
                                                "RequestStatus": requestType,
                                                "Profile": profile,
                                                "HardwareReqParams": {
                                                  "HardwarePageNo": "0",
                                                  "filter": {
                                                    "Unit": context
                                                        .read<
                                                            ICartFilterProvider>()
                                                        .selectedUnit,
                                                    "HardwareRequestType": context
                                                        .read<
                                                            ICartFilterProvider>()
                                                        .selectedType,
                                                    "UnitSpecification": context
                                                            .read<
                                                                ICartFilterProvider>()
                                                            .selectedDesc
                                                            .isEmpty
                                                        ? null
                                                        : [
                                                            context
                                                                .read<
                                                                    ICartFilterProvider>()
                                                                .selectedDesc
                                                          ]
                                                  }
                                                },
                                                "SoftwareReqParams": {
                                                  "SoftwarePageNo": "0",
                                                  "filter": {
                                                    "SoftwareRequestType": context
                                                        .read<
                                                            ICartFilterProvider>()
                                                        .selectedSWType,
                                                    "Software": context
                                                        .read<
                                                            ICartFilterProvider>()
                                                        .selectedSWUnit
                                                  }
                                                }
                                              }
                                            });
                                            context.loaderOverlay.hide();
                                          } else if ((value.returnStatus ==
                                                  1) ||
                                              (value.returnStatus == 4)) {
                                            HelperFunctions.showAlert("AMIGO",
                                                value.responseMessage!);
                                          } else {
                                            HelperFunctions.showAlert("Error",
                                                "Oops! Something went wrong");
                                          }
                                        });
                                      } else {}
                                    } catch (e) {
                                      HelperFunctions.showAlert("Error",
                                          "Oops! Something went wrong");
                                    } finally {
                                      if (context.loaderOverlay.visible) {
                                        context.loaderOverlay.hide();
                                      }
                                    }
                                  })
                                },
                              ),
                              IconButton(
                                color: Colors.white,
                                padding: EdgeInsets.zero,
                                iconSize: 30,
                                icon: const Icon(
                                    FontAwesomeIcons.solidCircleXmark,
                                    color: FColors.rejectColor),
                                onPressed: () => {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        iCartSWRejectAlert(
                                            context, txtRejectRemarkController),
                                  ).then((value) async {
                                    try {
                                      if (value == 'Submit') {
                                        context.loaderOverlay.show();
                                        context
                                            .read<ICartRequestListProvider>()
                                            .iCartRejectRequest({
                                          "RegObj": {
                                            "UserId": GlobalVariables.userName,
                                            "Profile": profile,
                                            "RequestType": "Software",
                                            "Request": [
                                              {
                                                "RequestNo": dataItem.requestNo,
                                                "Remark":
                                                    txtRejectRemarkController
                                                        .text
                                                        .toString()
                                              }
                                            ]
                                          }
                                        }).then((value) async {
                                          context.loaderOverlay.hide();
                                          if (value.returnStatus == 2) {
                                            await HelperFunctions.showAsyncAlert(
                                                "Success",
                                                '${dataItem.requestNo} has been rejected successfully.');
                                            txtRejectRemarkController.text = "";
                                            context.loaderOverlay.show();
                                            await context
                                                .read<
                                                    ICartRequestListProvider>()
                                                .getRequestListData({
                                              "RegObj": {
                                                "UserId":
                                                    GlobalVariables.userName,
                                                "RequestStatus": requestType,
                                                "Profile": profile,
                                                "HardwareReqParams": {
                                                  "HardwarePageNo": "0",
                                                  "filter": {
                                                    "Unit": context
                                                        .read<
                                                            ICartFilterProvider>()
                                                        .selectedUnit,
                                                    "HardwareRequestType": context
                                                        .read<
                                                            ICartFilterProvider>()
                                                        .selectedType,
                                                    "UnitSpecification": context
                                                            .read<
                                                                ICartFilterProvider>()
                                                            .selectedDesc
                                                            .isEmpty
                                                        ? null
                                                        : [
                                                            context
                                                                .read<
                                                                    ICartFilterProvider>()
                                                                .selectedDesc
                                                          ]
                                                  }
                                                },
                                                "SoftwareReqParams": {
                                                  "SoftwarePageNo": "0",
                                                  "filter": {
                                                    "SoftwareRequestType": context
                                                        .read<
                                                            ICartFilterProvider>()
                                                        .selectedSWType,
                                                    "Software": context
                                                        .read<
                                                            ICartFilterProvider>()
                                                        .selectedSWUnit
                                                  }
                                                }
                                              }
                                            });
                                            context.loaderOverlay.hide();
                                          } else if ((value.returnStatus ==
                                                  1) ||
                                              (value.returnStatus == 4)) {
                                            HelperFunctions.showAlert("AMIGO",
                                                value.responseMessage!);
                                          } else {
                                            HelperFunctions.showAlert("Error",
                                                "Oops! Something went wrong");
                                          }
                                        });
                                      } else {}
                                    } catch (e) {
                                      HelperFunctions.showAlert("Error",
                                          "Oops! Something went wrong");
                                    } finally {
                                      if (context.loaderOverlay.visible) {
                                        context.loaderOverlay.hide();
                                      }
                                    }
                                  })
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                        height: isPending ? 0.5 : 10, width: double.infinity),
                    LabelValueWidget(
                        label: 'Request By',
                        value: HelperFunctions.truncateText(
                            dataItem.requestBy.toString(), 21)),
                    LabelValueWidget(
                        label: 'Request For',
                        value: HelperFunctions.truncateText(
                            dataItem.requestFor.toString(), 21)),
                    LabelValueWidget(
                        label: 'Request Type',
                        value: dataItem.requestType.toString()),
                    LabelValueWidget(
                        label: 'Software Name',
                        value: HelperFunctions.truncateText(
                            dataItem.softwareName.toString(), 21)),
                    LabelValueWidget(
                        label: 'Software Version',
                        value: dataItem.softwareVersion.toString()),
                    LabelValueWidget(
                        label: 'Software Type',
                        value: dataItem.softwareType.toString()),
                    LabelValueWidget(
                        label: 'Acquisition Type',
                        value: dataItem.acquisitionType.toString()),
                    LabelValueWidget(
                        label: 'Previous Approver',
                        value: HelperFunctions.truncateText(
                            dataItem.previousApprover.toString(), 21)),
                    LabelValueWidget(
                        label: 'Amount(In ₹)',
                        value: '₹ ${dataItem.amount.toString()}'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget iCartSWApproveAlert(
    BuildContext context, TextEditingController txtApproveRemarkController) {
  String value;

  return AlertDialog(
    title: const Text(
      'Approve Remark',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
    ),
    titlePadding: const EdgeInsets.all(0),
    contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
    buttonPadding: const EdgeInsets.all(0),
    icon: const Icon(
      FontAwesomeIcons.solidCircleCheck,
      color: FColors.submitColor,
      size: 60,
    ),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5))),
    content: Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: const BorderRadius.all(Radius.circular(3))),
      child: TextField(
        controller: txtApproveRemarkController,
        keyboardType: TextInputType.multiline,
        maxLines: 4,
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(0),
            border: InputBorder.none,
            hintText: 'Enter Remark'),
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 40,
                padding: const EdgeInsets.only(left: 16),
                child: ElevatedButton(
                  style: ButtonStyle(
                      padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      backgroundColor:
                          WidgetStateProperty.all<Color>(FColors.submitColor)),
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: FColors.textWhite),
                  ),
                  onPressed: () {
                    // if (HelperFunctions.isNullorEmpty(
                    //     txtApproveRemarkController.text)) {
                    //   HelperFunctions.showAlert(
                    //       "Warning", "Please enter Remarks");
                    //   return;
                    // } else if (txtApproveRemarkController.text.length > 500) {
                    //   HelperFunctions.showAlert("Warning",
                    //       "Max Limit for remark exceeded.Must not be greater than 500");
                    //   return;
                    // }
                    Navigator.pop(context, "Submit");
                  },
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Container(
                height: 40,
                padding: const EdgeInsets.only(left: 8, right: 16),
                child: ElevatedButton(
                  style: ButtonStyle(
                      padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      backgroundColor:
                          WidgetStateProperty.all<Color>(FColors.rejectColor)),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: FColors.textWhite),
                  ),
                  onPressed: () =>
                      {value = 'Cancel', Navigator.pop(context, value)},
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget iCartSWRejectAlert(
    BuildContext context, TextEditingController txtRejectRemarkController) {
  String value;
  return AlertDialog(
    title: const Text(
      'Reject Remark',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
    ),
    titlePadding: const EdgeInsets.all(0),
    contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
    buttonPadding: const EdgeInsets.all(0),
    icon: const Icon(
      FontAwesomeIcons.solidCircleXmark,
      color: FColors.rejectedDark,
      size: 60,
    ),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5))),
    content: Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: const BorderRadius.all(Radius.circular(3))),
      child: TextField(
        controller: txtRejectRemarkController,
        keyboardType: TextInputType.multiline,
        maxLines: 4,
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(0),
            border: InputBorder.none,
            hintText: 'Enter Remark'),
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 40,
                padding: const EdgeInsets.only(left: 16),
                child: ElevatedButton(
                  style: ButtonStyle(
                      padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      backgroundColor:
                          WidgetStateProperty.all<Color>(FColors.submitColor)),
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: FColors.textWhite),
                  ),
                  onPressed: () {
                    if (HelperFunctions.isNullorEmpty(
                        txtRejectRemarkController.text)) {
                      HelperFunctions.showAlert(
                          "Warning", "Please enter Remarks");
                      return;
                    } else if (txtRejectRemarkController.text.length > 500) {
                      HelperFunctions.showAlert("Warning",
                          "Max Limit for remark exceeded.Must not be greater than 500");
                      return;
                    }
                    Navigator.pop(context, "Submit");
                  },
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Container(
                height: 40,
                padding: const EdgeInsets.only(left: 8, right: 16),
                child: ElevatedButton(
                  style: ButtonStyle(
                      padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      backgroundColor:
                          WidgetStateProperty.all<Color>(FColors.rejectColor)),
                  child: const Text('Cancel',
                      style: TextStyle(color: FColors.textWhite)),
                  onPressed: () =>
                      {value = 'Cancel', Navigator.pop(context, value)},
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
