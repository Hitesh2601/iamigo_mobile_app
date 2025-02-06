import 'package:push_notification/common/widgets/label_value_widget.dart';
import 'package:push_notification/features/iCart/models/icart_hardware_detail_response.dart';
import 'package:flutter/material.dart';

class RequestReasonView extends StatelessWidget {
  const RequestReasonView({
    super.key,
    required this.requestReason,
  });

  final RequestReason requestReason;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelValueWidget(
          label: 'Request Reason',
          value: requestReason.reqReason ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
      ],
    );
  }
}
