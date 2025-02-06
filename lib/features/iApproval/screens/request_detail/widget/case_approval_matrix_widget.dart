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

class CaseApprovalMatrixWidget extends StatelessWidget {
  const CaseApprovalMatrixWidget({
    super.key,
    required this.caseApprovalMatrix,
    required this.fpnNumber,
    required this.totalBudgetAmount,
  });

  final String fpnNumber;
  final String totalBudgetAmount;

  final CaseApprovalMatrix caseApprovalMatrix;

  @override
  Widget build(BuildContext context) {
    Approved? recommended;
    Approved? reviewed;
    Approved? approved;
    Approved? concurred;
    FinconApproved? finconAnalyst;
    FinconApproved? finconApprover;
    FinconApproved? finconApprover2;
    FinconApproved? finconApprover3;
    FinconApproved? mdApprover;

    if (caseApprovalMatrix.recommended != null) {
      recommended = caseApprovalMatrix.recommended!;
    }
    if (caseApprovalMatrix.reviewed != null) {
      reviewed = caseApprovalMatrix.reviewed!;
    }
    if (caseApprovalMatrix.approved != null) {
      approved = caseApprovalMatrix.approved!;
    }
    if (caseApprovalMatrix.concurred != null) {
      concurred = caseApprovalMatrix.concurred!;
    }
    if (caseApprovalMatrix.finconAnalyst != null) {
      finconAnalyst = caseApprovalMatrix.finconAnalyst!;
    }
    if (caseApprovalMatrix.finconApprover != null) {
      finconApprover = caseApprovalMatrix.finconApprover!;
    }
    if (caseApprovalMatrix.finconApprover2 != null) {
      finconApprover2 = caseApprovalMatrix.finconApprover2!;
    }
    if (caseApprovalMatrix.finconApprover3 != null) {
      finconApprover3 = caseApprovalMatrix.finconApprover3!;
    }
    if (caseApprovalMatrix.mdApprover != null) {
      mdApprover = caseApprovalMatrix.mdApprover!;
    }
    return Container(
      color: FColors.accent,
      child: Column(
        children: [
          if (recommended != null)
            CaseApproverMatrixItems(
              header: 'Recommended By',
              matrix: recommended,
            ),
          if (reviewed != null)
            CaseApproverMatrixItems(
              header: 'Reviewed By',
              matrix: reviewed,
            ),
          if (concurred != null)
            CaseApproverMatrixItems(
              header: 'Concurred By',
              matrix: concurred,
            ),
          if (approved != null)
            CaseApproverMatrixItems(
              header: 'Approved By',
              matrix: approved,
            ),
          if (finconAnalyst != null)
            SingleLevelApproverMatrixItems(
              header: 'Fincon Analyst',
              matrix: finconAnalyst,
            ),
          if (finconApprover != null)
            FinconCaseApproverMatrixItems(
                header: 'Fincon Approver',
                matrix1: finconApprover,
                matrix2: finconApprover2,
                matrix3: finconApprover3,
                finconAmt: caseApprovalMatrix.finconAmt,
                finconOldAmt: caseApprovalMatrix.finconOldAmt,
                totalBudgetAmount: totalBudgetAmount,
                fpnNumber: fpnNumber),
          if (mdApprover != null)
            SingleLevelApproverMatrixItems(
              header: 'MD Approver',
              matrix: mdApprover,
            ),
        ],
      ),
    );
  }
}

class FinconCaseApproverMatrixItems extends StatelessWidget {
  const FinconCaseApproverMatrixItems(
      {super.key,
      required this.header,
      required this.matrix1,
      required this.matrix2,
      required this.matrix3,
      required this.finconAmt,
      required this.finconOldAmt,
      required this.totalBudgetAmount,
      required this.fpnNumber});
  final String header;
  final FinconApproved matrix1;
  final FinconApproved? matrix2;
  final FinconApproved? matrix3;
  final String? finconAmt;
  final String? finconOldAmt;
  final String? totalBudgetAmount;
  final String fpnNumber;
  @override
  Widget build(BuildContext context) {
    TextEditingController newAmountController = TextEditingController();
    TextEditingController oldAmountController = TextEditingController();
    bool isOldAmoutVisible = false;
    bool isSendbackVisible = false;
    Color color = Colors.grey;
    // newAmountController.text = (HelperFunctions.isNullorEmpty(finconAmt))
    //     ? newAmountController.text = "0.00"
    //     : newAmountController.text = finconAmt!;
    newAmountController.text = "0.00";
    if (!HelperFunctions.isNullorEmpty(finconOldAmt)) {
      oldAmountController.text = finconOldAmt!;
      isOldAmoutVisible = true;
    }
    if (HelperFunctions.eqaulIgnoreCase(
        GlobalVariables.userName, matrix1.level1![0].code)) {
      if (Status.PENDING == matrix1.level1![0].status ||
          Status.APPROVED == matrix1.level1![0].status) {
        if (newAmountController.text == "0.00") {
          isSendbackVisible = true;
          color = Colors.white;
        }
      }
    }
    if (matrix2 != null) {
      if (HelperFunctions.eqaulIgnoreCase(
          GlobalVariables.userName, matrix2!.level1![0].code)) {
        if (Status.PENDING == matrix2!.level1![0].status ||
            Status.APPROVED == matrix2!.level1![0].status) {
          if (newAmountController.text == "0.00") {
            isSendbackVisible = true;
          }
        }
      }
    }
    if (matrix3 != null) {
      if (HelperFunctions.eqaulIgnoreCase(
          GlobalVariables.userName, matrix3!.level1![0].code)) {
        if (Status.PENDING == matrix3!.level1![0].status ||
            Status.APPROVED == matrix3!.level1![0].status) {
          if (newAmountController.text == "0.00") {
            isSendbackVisible = true;
          }
        }
      }
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 0.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 30,
              color: Colors.blue.shade800,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      header,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const LevelHeaderWidget(
              levelName: "Fincon Approver 1",
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 10, 15, 0),
              child: SizedBox(
                height: 30,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  '${matrix1.level1?[0].code}-${matrix1.level1?[0].name}',
                  style: TextStyle(
                      color: convert('${matrix1.level1![0].matrixColor}')),
                ),
              ),
            ),
            matrix2 != null
                ? const LevelHeaderWidget(
                    levelName: "Fincon Approver 2",
                  )
                : const SizedBox(
                    height: 0,
                  ),
            matrix2 != null
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(25, 10, 15, 0),
                    child: SizedBox(
                      height: 30,
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        '${matrix2!.level1?[0].code}-${matrix2!.level1?[0].name}',
                        style: TextStyle(
                            color:
                                convert('${matrix2!.level1![0].matrixColor}')),
                      ),
                    ),
                  )
                : const SizedBox(
                    height: 0,
                  ),
            matrix3 != null
                ? const LevelHeaderWidget(
                    levelName: "Fincon Approver 3",
                  )
                : const SizedBox(
                    height: 0,
                  ),
            matrix3 != null
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(25, 10, 15, 0),
                    child: SizedBox(
                      height: 30,
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        '${matrix3!.level1?[0].code}-${matrix3!.level1?[0].name}',
                        style: TextStyle(
                            color:
                                convert('${matrix3!.level1![0].matrixColor}')),
                      ),
                    ),
                  )
                : const SizedBox(
                    height: 0,
                  ),
          ],
        ),
      ),
    );
  }
}

class SingleLevelApproverMatrixItems extends StatelessWidget {
  const SingleLevelApproverMatrixItems(
      {super.key, required this.header, required this.matrix});
  final String header;
  final FinconApproved matrix;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 0.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 30,
              color: Colors.blue.shade800,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      header,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: SizedBox(
                  height: 30,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              '${matrix.level1?[0].code}-${matrix.level1?[0].name}',
                              style: TextStyle(
                                  color: convert(
                                      '${matrix.level1![0].matrixColor}')),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CaseApproverMatrixItems extends StatelessWidget {
  const CaseApproverMatrixItems(
      {super.key, required this.header, required this.matrix});
  final String header;
  final Approved matrix;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 0.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 30,
              color: Colors.blue.shade800,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      header,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            matrix.level1 != null
                ? CaseApprovalLevelWidget(
                    subHeaderValue:
                        '${matrix.level1?[0].code}-${matrix.level1?[0].name}',
                    colorValue: '${matrix.level1![0].matrixColor}',
                    levelName: "Level 1",
                  )
                : const SizedBox(
                    height: 0,
                  ),
            matrix.level2 != null
                ? CaseApprovalLevelWidget(
                    subHeaderValue:
                        '${matrix.level2?[0].code}-${matrix.level2?[0].name}',
                    colorValue: '${matrix.level2![0].matrixColor}',
                    levelName: "Level 2",
                  )
                : const SizedBox(
                    height: 0,
                  ),
            matrix.level3 != null
                ? CaseApprovalLevelWidget(
                    subHeaderValue:
                        '${matrix.level3?[0].code}-${matrix.level3?[0].name}',
                    colorValue: '${matrix.level3![0].matrixColor}',
                    levelName: "Level 3",
                  )
                : const SizedBox(
                    height: 0,
                  ),
            matrix.level4 != null
                ? CaseApprovalLevelWidget(
                    subHeaderValue:
                        '${matrix.level4?[0].code}-${matrix.level4?[0].name}',
                    colorValue: '${matrix.level4![0].matrixColor}',
                    levelName: "Level 4",
                  )
                : const SizedBox(
                    height: 0,
                  ),
            matrix.level5 != null
                ? CaseApprovalLevelWidget(
                    subHeaderValue:
                        '${matrix.level5?[0].code}-${matrix.level5?[0].name}',
                    colorValue: '${matrix.level5![0].matrixColor}',
                    levelName: "Level 5",
                  )
                : const SizedBox(
                    height: 0,
                  ),
          ],
        ),
      ),
    );
  }
}

class LevelHeaderWidget extends StatelessWidget {
  const LevelHeaderWidget({super.key, required this.levelName});
  final String levelName;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Container(
        height: 30,
        width: MediaQuery.of(context).size.width,
        color: Colors.blue.shade100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                levelName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CaseApprovalLevelWidget extends StatelessWidget {
  const CaseApprovalLevelWidget({
    super.key,
    required this.levelName,
    required this.subHeaderValue,
    required this.colorValue,
  });

  final String levelName;
  final String subHeaderValue;
  final String colorValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LevelHeaderWidget(
          levelName: levelName,
        ),
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: SizedBox(
              height: 30,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          subHeaderValue,
                          style: TextStyle(color: convert(colorValue)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Color convert(String colorCode) {
  Color value = const Color.fromARGB(255, 5, 5, 5);

  switch (colorCode.toLowerCase()) {
    case 'black':
      value = const Color.fromARGB(255, 5, 5, 5);
      break;
    case 'blue':
      value = const Color.fromARGB(255, 5, 10, 168);
      break;
    case 'red':
      value = const Color.fromARGB(255, 252, 17, 5);
      break;
    case 'green':
      value = const Color.fromARGB(255, 27, 168, 5);
      break;
  }
  return value;
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
