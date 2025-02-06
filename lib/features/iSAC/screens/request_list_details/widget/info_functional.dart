import 'package:push_notification/common/widgets/label_value_widget.dart';
import 'package:push_notification/features/iSAC/models/isac_request_details_response.dart';
import 'package:flutter/material.dart';

class InfoFUNCTIONALView extends StatelessWidget {
  const InfoFUNCTIONALView({
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
          label: 'Current Approver',
          value: infoDetails.ticketData?.currentApprover ?? "NA",
          padding: const EdgeInsets.all(7),
        ),
        // const Divider(),
        LabelValueWidget(
          label: 'Approver Band',
          value: infoDetails.ticketData?.bandName ?? "NA",
          padding: const EdgeInsets.all(7),
        ),
      ],
    );
  }
}
