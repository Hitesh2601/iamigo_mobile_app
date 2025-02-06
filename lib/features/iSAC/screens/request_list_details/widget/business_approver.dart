import 'package:push_notification/common/widgets/label_value_widget.dart';
import 'package:push_notification/features/iSAC/models/isac_request_details_response.dart';
import 'package:flutter/material.dart';

class BusinessApproverView extends StatelessWidget {
  const BusinessApproverView({
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
          label: 'Business Approver',
          value: infoDetails.ticketData?.businessApproverName ?? "NA",
          padding: const EdgeInsets.all(7),
        )
      ],
    );
  }
}
