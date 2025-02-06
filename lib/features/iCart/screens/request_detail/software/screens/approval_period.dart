import 'package:push_notification/common/widgets/label_value_widget.dart';
import 'package:push_notification/features/iCart/models/icart_software_detail_response.dart';
import 'package:flutter/material.dart';

class ApprovalPeriodScreen extends StatelessWidget {
  const ApprovalPeriodScreen({super.key, required this.softwareApproverPeriod});

  final SoftwareApproverPeriod softwareApproverPeriod;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelValueWidget(
          label: 'Approved For Days',
          value: softwareApproverPeriod.approvedForDays ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'User Inputted Days',
          value: softwareApproverPeriod.userInputtedDays ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Start Date',
          value: softwareApproverPeriod.startDate ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'End Date',
          value: softwareApproverPeriod.endDate ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
      ],
    );
  }
}
