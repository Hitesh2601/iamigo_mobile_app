import 'package:push_notification/features/iApproval/models/fpn_request_details_response.dart';
import 'package:push_notification/features/iApproval/providers/fpn_request_detail_provider.dart';
import 'package:push_notification/utility/constants/colors.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:push_notification/utility/constants/sizes.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class FinconSentbackWidget extends StatelessWidget {
  const FinconSentbackWidget({
    super.key,
    required this.sendbackDetails,
    required this.fpnNumber,
    required this.totalBudgetAmount,
    required this.isFincon,
  });

  final SendbackDetails sendbackDetails;
  final String fpnNumber;
  final String totalBudgetAmount;
  final bool isFincon;
  @override
  Widget build(BuildContext context) {
    TextEditingController finconAmountController = TextEditingController();
    TextEditingController userAmountController = TextEditingController();
    TextEditingController ogAmountController = TextEditingController();
    finconAmountController.text = sendbackDetails.finconSendbackAmt ?? "0.00";
    userAmountController.text = sendbackDetails.userSendbackAmt ?? "0.00";
    ogAmountController.text = sendbackDetails.originalFPNAmt ?? "0.00";

    return Column(
      children: [
        Form(
            child: Padding(
          padding: const EdgeInsets.all(FSizes.md),
          child: Column(
            children: [
              TextFormField(
                controller: ogAmountController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.start,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Original FPN Amount',
                  fillColor: Colors.white,
                  alignLabelWithHint: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.red),
                  ),
                ),
              ),
              const SizedBox(
                height: FSizes.spaceBtwInputfields,
              ),
              TextFormField(
                  controller: finconAmountController,
                  readOnly: !(isFincon && sendbackDetails.allowsendback!),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Fincon Sendback Amount (including Contigency)',
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Colors.grey), //<-- SEE HERE
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.red),
                    ),
                    focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                  )),
              const SizedBox(
                height: FSizes.spaceBtwInputfields,
              ),
              TextFormField(
                controller: userAmountController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.start,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'User Sendback Amount',
                  fillColor: Colors.white,
                  alignLabelWithHint: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        )),
        Visibility(
          visible: isFincon && sendbackDetails.allowsendback!,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 10),
                child: ElevatedButton(
                  style: ButtonStyle(
                      padding:
                          const WidgetStatePropertyAll(EdgeInsets.all(8.0)),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.black54)),
                  child: const Text(
                    'Sendback',
                    style: TextStyle(color: FColors.textWhite),
                  ),
                  onPressed: () async {
                    if (!HelperFunctions.isNullorEmpty(
                        finconAmountController.text)) {
                      if (finconAmountController.text == "0.00" ||
                          finconAmountController.text == "0") {
                        HelperFunctions.showAlert(
                            "Warning", "Please enter Fincon Amount");
                        return;
                      } else {
                        double finAmount = double.parse(
                            finconAmountController.text.replaceAll(",", ""));
                        double totalBudget = double.parse(
                            ogAmountController.text.replaceAll(",", ""));
                        if (finAmount > totalBudget) {
                          HelperFunctions.showAlert("Warning",
                              "Fincon Amount should be less than total Budget amount");
                          return;
                        }
                      }
                    } else {
                      HelperFunctions.showAlert(
                          "Warning", "Please enter Fincon Amount");
                      return;
                    }
                    TextEditingController txtSendbackRemarkController =
                        TextEditingController();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => popupSendbackAlert(
                          context, txtSendbackRemarkController),
                    ).then((value) async {
                      try {
                        if (value == 'Submit') {
                          context.loaderOverlay.show();
                          await context
                              .read<FPNDetailProvider>()
                              .fpnSendbackRequest({
                            "UserId": GlobalVariables.userName,
                            "FpnNo": fpnNumber,
                            "RevisedAmt":
                                finconAmountController.text.replaceAll(",", ""),
                            "SendbackRemark": txtSendbackRemarkController.text,
                          }).then((value) async {
                            context.loaderOverlay.hide();
                            if (value.returnStatus == 2) {
                              await HelperFunctions.showAsyncAlert("Success",
                                  '$fpnNumber has been sendback successfully.');
                              Get.back(result: "refresh");
                            } else if ((value.returnStatus == 1) ||
                                (value.returnStatus == 4)) {
                              HelperFunctions.showAlert(
                                  "AMIGO", value.responseMessage!);
                            } else {
                              HelperFunctions.showAlert(
                                  "Error", "Oops! Something went wrong");
                            }
                          });
                        } else {}
                      } catch (e) {
                      } finally {
                        if (context.loaderOverlay.visible) {
                          context.loaderOverlay.hide();
                        }
                      }
                    });
                    // Get.back(result: "refresh");
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget popupSendbackAlert(
    BuildContext context, TextEditingController txtSendbackRemarkController) {
  String value;

  return AlertDialog(
    title: const Text(
      'Sendback Remark',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
    ),
    titlePadding: const EdgeInsets.all(0),
    contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
    buttonPadding: const EdgeInsets.all(0),
    icon: const Icon(
      FontAwesomeIcons.solidShareFromSquare,
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
        controller: txtSendbackRemarkController,
        keyboardType: TextInputType.multiline,
        maxLines: 4,
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(0),
            border: InputBorder.none,
            hintText: 'Enter Sendback Remark'),
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
                    if (HelperFunctions.isNullorEmpty(
                        txtSendbackRemarkController.text)) {
                      HelperFunctions.showAlert(
                          "Warning", "Please enter Remarks");
                      return;
                    } else if (txtSendbackRemarkController.text.length > 500) {
                      HelperFunctions.showAlert("Warning",
                          "Max Limit for Sendback remark exceeded.Must not be greater than 500");
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
