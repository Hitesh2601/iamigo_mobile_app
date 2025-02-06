import 'package:push_notification/common/widgets/label_value_widget.dart';
import 'package:push_notification/features/iCart/models/icart_software_detail_response.dart';
import 'package:flutter/material.dart';

class SoftwareRequestDetailsView extends StatelessWidget {
  const SoftwareRequestDetailsView({super.key, required this.requestInfo});

  final SoftRequestDetails requestInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelValueWidget(
          label: 'Request Justification',
          value: requestInfo.justification ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Contact Emp Code',
          value: requestInfo.empCode ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Contact Emp Name',
          value: requestInfo.empName ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Mobile Number',
          value: requestInfo.mobileNo ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
      ],
    );
  }
}
