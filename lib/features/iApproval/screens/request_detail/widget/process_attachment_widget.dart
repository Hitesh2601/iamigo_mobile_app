import 'package:push_notification/common/widgets/label_value_widget.dart';
import 'package:push_notification/features/iApproval/models/fpn_request_details_response.dart';
import 'package:flutter/material.dart';

class ProcessAttachmentWidget extends StatelessWidget {
  const ProcessAttachmentWidget(
      {super.key, required this.processAttachmentDetails});

  final ProcessAttachmentDetails processAttachmentDetails;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LabelValueWidget(
          label: 'Current',
          value: processAttachmentDetails.current!,
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'New',
          value: processAttachmentDetails.processAttachmentDetailsNew!,
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Competition',
          value: processAttachmentDetails.competition!,
          padding: const EdgeInsets.all(10),
        ),
      ],
    );
  }
}
