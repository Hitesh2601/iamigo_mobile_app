import 'package:push_notification/common/widgets/label_value_widget.dart';
import 'package:push_notification/features/iSAC/models/isac_request_details_response.dart';
import 'package:flutter/material.dart';

class RejectReasonView extends StatelessWidget {
  const RejectReasonView({
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
          label: 'Rejection Reason',
          value: infoDetails.ticketData?.reasonDesc ?? "NA",
          padding: const EdgeInsets.all(7),
        )
      ],
    );
  }
}
