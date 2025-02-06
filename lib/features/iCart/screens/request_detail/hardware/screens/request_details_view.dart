import 'package:push_notification/common/widgets/label_value_widget.dart';
import 'package:push_notification/features/iCart/models/icart_hardware_detail_response.dart';
import 'package:flutter/material.dart';

class RequestDetailsView extends StatelessWidget {
  const RequestDetailsView({
    super.key,
    required this.requestInfo,
  });

  final RequestInfo requestInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelValueWidget(
          label: 'Request Type',
          value: requestInfo.requestType ?? "NA",
          padding: const EdgeInsets.all(5),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Request For',
          value: requestInfo.requestFor ?? "NA",
          padding: const EdgeInsets.all(5),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'User Type',
          value: requestInfo.userType ?? "NA",
          padding: const EdgeInsets.all(5),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'New / Existing',
          value: requestInfo.newExisting ?? "NA",
          padding: const EdgeInsets.all(5),
        ),
      ],
    );
  }
}
