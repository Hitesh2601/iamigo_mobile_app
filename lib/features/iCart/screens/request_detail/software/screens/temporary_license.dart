import 'package:push_notification/common/widgets/label_value_widget.dart';
import 'package:push_notification/features/iCart/models/icart_software_detail_response.dart';
import 'package:flutter/material.dart';

class TemporaryLicenseScreen extends StatelessWidget {
  const TemporaryLicenseScreen({super.key, required this.temporaryLicense});

  final TemporaryLicense temporaryLicense;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelValueWidget(
          label: 'Start Date',
          value: temporaryLicense.startDate ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'End Date',
          value: temporaryLicense.endDate ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
      ],
    );
  }
}
