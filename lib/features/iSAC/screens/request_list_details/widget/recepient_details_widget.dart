import 'package:flutter/material.dart';
import 'package:push_notification/common/widgets/label_value_widget.dart';
import 'package:push_notification/features/iSAC/models/isac_request_details_response.dart';

class RecepientDetailsView extends StatelessWidget {
  const RecepientDetailsView({
    super.key,
    required this.infoDetails,
  });

  final ISACRequestDetailsClass infoDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelValueWidget(
          label: 'Company',
          value: infoDetails.ticketData?.vendorCompany ?? "NA",
          padding: const EdgeInsets.all(7),
        ),
        // const Divider(),
        LabelValueWidget(
          label: 'Staff',
          value: infoDetails.ticketData?.vendorCode ?? "NA",
          padding: const EdgeInsets.all(7),
        ),
        // const Divider(),
        LabelValueWidget(
          label: 'VBMS Code',
          value: infoDetails.ticketData?.vBMSCode ?? "NA",
          padding: const EdgeInsets.all(7),
        ),
        // const Divider(),
        LabelValueWidget(
          label: 'Staff Code',
          value: infoDetails.ticketData?.staffCode ?? "NA",
          padding: const EdgeInsets.all(7),
        ),
      ],
    );
  }
}
