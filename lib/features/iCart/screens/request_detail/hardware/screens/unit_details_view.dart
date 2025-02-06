import 'package:push_notification/common/widgets/label_value_widget.dart';
import 'package:push_notification/features/iCart/models/icart_hardware_detail_response.dart';
import 'package:flutter/material.dart';

class UnitDetailsView extends StatelessWidget {
  const UnitDetailsView({
    super.key,
    required this.unitDetails,
  });

  final UnitDetails unitDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelValueWidget(
          label: 'Request Type',
          value: unitDetails.newReplace ?? "NA",
          padding: const EdgeInsets.all(5),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Product Type',
          value: unitDetails.productType ?? "NA",
          padding: const EdgeInsets.all(5),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Unit',
          value: unitDetails.unit ?? "NA",
          padding: const EdgeInsets.all(5),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Unit Specification',
          value: unitDetails.unitSpec ?? "NA",
          padding: const EdgeInsets.all(5),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Amount (Exclusive of Taxes)',
          value: unitDetails.unitAmount ?? "NA",
          padding: const EdgeInsets.all(5),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Unit Configuration',
          value: unitDetails.unitConfig ?? "NA",
          padding: const EdgeInsets.all(5),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Cost Code To Be Debited',
          value: unitDetails.costCodeDebited ?? "NA",
          padding: const EdgeInsets.all(5),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'LAN Port Required',
          value: unitDetails.lANPort ?? "NA",
          padding: const EdgeInsets.all(5),
        ),
      ],
    );
  }
}
