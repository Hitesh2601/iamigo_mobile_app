import 'package:push_notification/common/widgets/label_value_widget.dart';
import 'package:push_notification/features/iCart/models/icart_software_detail_response.dart';
import 'package:flutter/material.dart';

class ApproverDetailsView extends StatelessWidget {
  const ApproverDetailsView({
    super.key,
    required this.approverDetail,
  });

  final SoftwareApproverDetail approverDetail;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelValueWidget(
          label: 'Line Manager',
          value: approverDetail.lineManager ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Approver',
          value: approverDetail.approver ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
      ],
    );
  }
}
