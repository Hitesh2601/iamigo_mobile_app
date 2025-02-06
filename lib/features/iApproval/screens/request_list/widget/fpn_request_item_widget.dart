import 'package:push_notification/common/widgets/bottom_right_curve_card.dart';
import 'package:push_notification/common/widgets/label_value_widget.dart';
import 'package:push_notification/features/iApproval/models/fpn_request_list_response.dart';
import 'package:push_notification/features/iApproval/providers/fpn_feedback_provider.dart';
import 'package:push_notification/features/iApproval/providers/fpn_request_detail_provider.dart';
import 'package:push_notification/features/iApproval/providers/fpn_request_list_provider.dart';
import 'package:push_notification/features/iApproval/screens/feedback/fpn_feedback_widget.dart';
import 'package:push_notification/features/iApproval/screens/request_detail/fpn_details_screen.dart';
import 'package:push_notification/utility/constants/colors.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class FPNRequestItemWidget extends StatelessWidget {
  const FPNRequestItemWidget({
    super.key,
    required this.dataItem,
    required this.isButtonVisible,
    required this.filteredRequestNo,
    required this.requestType,
    required this.ctx,
  });
  final FPNData dataItem;
  final bool isButtonVisible;
  final List<String>? filteredRequestNo;
  final String requestType;
  final BuildContext ctx;

  @override
  Widget build(BuildContext context) {
    var requestApproveJson = <String, String>{
      'UserId': GlobalVariables.userName,
      'FpnNo': '',
      'Remark': '',
      'FinConAnalystRemark': ''
    };
    var requestRejectJson = <String, String>{
      'UserId': GlobalVariables.userName,
      'FpnNo': '',
      'Remark': '',
      'FinConAnalystRemark': ''
    };
    TextEditingController txtApproveRemarkController = TextEditingController();
    TextEditingController txtRejectRemarkController = TextEditingController();
    return Stack(
      children: [
        const BottomRightCurveCardWidget(
          height: 250,
        ),
        InkWell(
          onTap: () async {
            await Get.to(ChangeNotifierProvider<FPNDetailProvider>(
              create: (_) => FPNDetailProvider(),
              child: FpnDetailsScreen(
                  fpnNumber: '${dataItem.fPNNumber}',
                  isButtonVisible: isButtonVisible,
                  filteredRequestNo: filteredRequestNo),
            ));
            await ctx.read<FPNRequestListProvider>().getRequestListData({
              "UserId": GlobalVariables.userName,
              "RequestType": requestType
            });
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
              height: 250,
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
                            '${dataItem.fPNNumber}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: FColors.listHeaderText,
                                fontSize: 17),
                          ),
                        ),
                        Visibility(
                          visible: isButtonVisible,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                color: Colors.white,
                                padding: EdgeInsets.zero,
                                iconSize: 30,
                                icon: const Icon(
                                    FontAwesomeIcons.solidCircleCheck,
                                    color: FColors.approvedDark),
                                onPressed: () => {
                                  ///Json Create here
                                  requestApproveJson['FpnNo'] =
                                      dataItem.fPNNumber.toString(),
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
                                          .read<FPNRequestListProvider>()
                                          .fpnApproveRequest(requestApproveJson)
                                          .then((value) async {
                                        context.loaderOverlay.hide();
                                        if (value.returnStatus == 2) {
                                          await HelperFunctions.showAsyncAlert(
                                              "Success",
                                              '${dataItem.fPNNumber} has been approved successfully.');
                                          await Provider.of<
                                                      FPNRequestListProvider>(
                                                  context,
                                                  listen: false)
                                              .getRequestListData({
                                            "UserId": GlobalVariables.userName,
                                            "RequestType": requestType
                                          });
                                        }
                                      });
                                    } else {}
                                  })
                                },
                              ),
                              IconButton(
                                color: Colors.white,
                                padding: EdgeInsets.zero,
                                iconSize: 30,
                                icon: const Icon(
                                    FontAwesomeIcons.solidCircleXmark,
                                    color: FColors.rejectedDark),
                                onPressed: () => {
                                  ///Json Create here
                                  requestRejectJson['FpnNo'] =
                                      dataItem.fPNNumber.toString(),
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        popupRejectAlert(
                                            context, txtRejectRemarkController),
                                  ).then((value) {
                                    if (value == 'Submit') {
                                      /// To Show Loader
                                      requestRejectJson['Remark'] =
                                          txtRejectRemarkController.text;
                                      context.loaderOverlay.show();
                                      context
                                          .read<FPNRequestListProvider>()
                                          .fpnRejectRequest(requestRejectJson)
                                          .then((value) async {
                                        context.loaderOverlay.hide();
                                        if (value.returnStatus == 2) {
                                          await HelperFunctions.showAsyncAlert(
                                              "Success",
                                              '${dataItem.fPNNumber} has been rejected successfully.');
                                          await Provider.of<
                                                      FPNRequestListProvider>(
                                                  context,
                                                  listen: false)
                                              .getRequestListData({
                                            "UserId": GlobalVariables.userName,
                                            "RequestType": requestType
                                          });
                                        }
                                      });
                                    } else {}
                                  })
                                },
                              ),
                              IconButton(
                                color: Colors.white,
                                padding: EdgeInsets.zero,
                                iconSize: 30,
                                icon: const Icon(
                                    FontAwesomeIcons.solidCommentDots,
                                    color: FColors.feedbackDark),
                                onPressed: () async {
                                  await Get.to(ChangeNotifierProvider<
                                          FPNFeedbackProvider>(
                                      create: (_) => FPNFeedbackProvider(),
                                      child: FPNFeedbackWidget(
                                        fpnNumber: '${dataItem.fPNNumber}',
                                      )));
                                  await Provider.of<FPNRequestListProvider>(
                                          context,
                                          listen: false)
                                      .getRequestListData({
                                    "UserId": GlobalVariables.userName,
                                    "RequestType": requestType
                                  });
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                        height: isButtonVisible ? 0.5 : 10,
                        width: double.infinity),
                    LabelValueWidget(
                        label: 'Project Name',
                        value: HelperFunctions.truncateText(
                            dataItem.projectName.toString(), 21)),
                    LabelValueWidget(
                        label: 'Project Description',
                        value: HelperFunctions.truncateText(
                            dataItem.projectDescription.toString(), 21)),
                    LabelValueWidget(
                        label: 'FPN Category',
                        value: dataItem.fPNCategory.toString()),
                    LabelValueWidget(
                        label: 'FPN Sub Category',
                        value: HelperFunctions.truncateText(
                            dataItem.fPNSubCategory.toString(), 21)),
                    LabelValueWidget(
                        label: 'FPN Amount',
                        value: '₹ ${dataItem.fPNAmount.toString()}'),
                    LabelValueWidget(
                        label: 'Cash Flow Amount',
                        value: '₹ ${dataItem.cashFlowAmount.toString()}'),
                    LabelValueWidget(
                        label: 'Non Cash Flow Amount',
                        value: '₹ ${dataItem.nonCashFlowAmount.toString()}'),
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

Widget popupApproveAlert(
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
      color: FColors.approvedDark,
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
                  onPressed: () =>
                      {value = 'Submit', Navigator.pop(context, value)},
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

Widget popupRejectAlert(
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
                  onPressed: () =>
                      {value = 'Submit', Navigator.pop(context, value)},
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
