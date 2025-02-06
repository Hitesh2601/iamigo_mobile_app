import 'package:push_notification/common/widgets/label_value_widget.dart';
import 'package:push_notification/features/iApproval/models/fpn_request_details_response.dart';
import 'package:push_notification/features/iApproval/providers/fpn_request_detail_provider.dart';
import 'package:push_notification/features/iApproval/providers/fpn_request_list_provider.dart';
import 'package:push_notification/utility/constants/colors.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CaseDetailsWidget extends StatelessWidget {
  const CaseDetailsWidget({super.key, required this.caseDetails});

  final CaseDetails caseDetails;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 0.5),
                    color: FColors.light,
                  ),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          LabelValueWidget(
                            label: 'Is Ariba Sourcing',
                            value: caseDetails.ariba!,
                            padding: const EdgeInsets.all(10),
                          ),
                        ],
                      ),
                      Consumer<FPNDetailProvider>(
                        builder: (context, value, child) => Visibility(
                          visible: value.isRFPVisible &&
                              !HelperFunctions.isNullorEmpty(
                                  caseDetails.autionRefNo),
                          child: Column(
                            children: [
                              const Divider(),
                              LabelValueWidget(
                                label: 'RFP/eAuction Ref No',
                                value: caseDetails.autionRefNo!,
                                padding: const EdgeInsets.all(10),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Consumer<FPNDetailProvider>(
                        builder: (context, value, child) => Visibility(
                          visible: value.isValidJustificationVisible &&
                              !HelperFunctions.isNullorEmpty(
                                  caseDetails.validJustification),
                          child: Column(
                            children: [
                              const Divider(),
                              LabelValueWidget(
                                label: 'Valid Justification',
                                value: caseDetails.validJustification!,
                                padding: const EdgeInsets.all(10),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Consumer<FPNDetailProvider>(
                        builder: (context, value, child) => Visibility(
                          visible: value.isJustificationVisible &&
                              !HelperFunctions.isNullorEmpty(
                                  caseDetails.justification),
                          child: Column(
                            children: [
                              const Divider(),
                              LabelValueWidget(
                                label: 'Justification',
                                value: caseDetails.justification!,
                                padding: const EdgeInsets.all(10),
                              ),
                            ],
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
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 0.5),
                    color: FColors.light,
                  ),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          LabelValueWidget(
                            label: 'Is it P/NSI type of Changes?',
                            value: caseDetails.pnsiChange!,
                            padding: const EdgeInsets.all(10),
                          ),
                        ],
                      ),
                      Consumer<FPNDetailProvider>(
                        builder: (context, value, child) => Visibility(
                          visible: value.isCabChangesVisible &&
                              !HelperFunctions.isNullorEmpty(
                                  caseDetails.cabChangesApproved),
                          child: Column(
                            children: [
                              const Divider(),
                              LabelValueWidget(
                                label: 'Cab Changes Approved',
                                value: caseDetails.cabChangesApproved!,
                                padding: const EdgeInsets.all(10),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Consumer<FPNDetailProvider>(
                        builder: (context, value, child) => Visibility(
                          visible: value.isRefNoVisible &&
                              !HelperFunctions.isNullorEmpty(caseDetails.refNo),
                          child: Column(
                            children: [
                              const Divider(),
                              LabelValueWidget(
                                label: 'Valid Reference Number',
                                value: caseDetails.refNo!,
                                padding: const EdgeInsets.all(10),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Consumer<FPNDetailProvider>(
                        builder: (context, value, child) => Visibility(
                          visible: value.isTentativeDateVisible &&
                              !HelperFunctions.isNullorEmpty(
                                  caseDetails.tentativeDate),
                          child: Column(
                            children: [
                              const Divider(),
                              LabelValueWidget(
                                label: 'Tentative Date For Approval',
                                value: caseDetails.tentativeDate!,
                                padding: const EdgeInsets.all(10),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 0.5),
                    color: FColors.light,
                  ),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          LabelValueWidget(
                            label: 'Supplementary/Additional FPN',
                            value: caseDetails.supplementaryFpn!,
                            padding: const EdgeInsets.all(10),
                          ),
                        ],
                      ),
                      Consumer<FPNDetailProvider>(
                        builder: (context, value, child) => Visibility(
                          visible: value.isAdditionalFPNVisible &&
                              !HelperFunctions.isNullorEmpty(
                                  caseDetails.specifyChangeInScope),
                          child: Column(
                            children: [
                              const Divider(),
                              LabelValueWidget(
                                label: 'Specify change in scope',
                                value: caseDetails.specifyChangeInScope!,
                                padding: const EdgeInsets.all(10),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Consumer<FPNDetailProvider>(
                        builder: (context, value, child) => Visibility(
                          visible: value.isSupplementaryFPNVisible &&
                              !HelperFunctions.isNullorEmpty(
                                  caseDetails.parentFpnNo),
                          child: Column(
                            children: [
                              const Divider(),
                              LabelValueWidget(
                                label: 'Parent FPN No',
                                value: caseDetails.parentFpnNo!,
                                padding: const EdgeInsets.all(10),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Consumer<FPNDetailProvider>(
                        builder: (context, value, child) => Visibility(
                          visible: value.isSupplementaryFPNVisible &&
                              !HelperFunctions.isNullorEmpty(
                                  caseDetails.parentFpnProjectName),
                          child: Column(
                            children: [
                              const Divider(),
                              LabelValueWidget(
                                label: 'Project Name',
                                value: caseDetails.parentFpnProjectName!,
                                padding: const EdgeInsets.all(10),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Consumer<FPNDetailProvider>(
                        builder: (context, value, child) => Visibility(
                          visible: value.isSupplementaryFPNVisible &&
                              !HelperFunctions.isNumberNullorZero(
                                  caseDetails.parentFpnAmount),
                          child: Column(
                            children: [
                              const Divider(),
                              LabelValueWidget(
                                label: 'Parent FPN Amount',
                                value: caseDetails.parentFpnAmount!,
                                padding: const EdgeInsets.all(10),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Consumer<FPNDetailProvider>(
                        builder: (context, value, child) => Visibility(
                          visible: value.isSupplementaryFPNVisible &&
                              !HelperFunctions.isNumberNullorZero(
                                  caseDetails.parentFpnAmtUtilized),
                          child: Column(
                            children: [
                              const Divider(),
                              LabelValueWidget(
                                label: 'Parent FPN Amt Utilized',
                                value: caseDetails.parentFpnAmtUtilized!,
                                padding: const EdgeInsets.all(10),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
