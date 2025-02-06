import 'package:push_notification/common/widgets/label_value_widget.dart';
import 'package:push_notification/features/iSAC/models/isac_request_details_response.dart';
import 'package:flutter/material.dart';

class InfoDetailsView extends StatelessWidget {
  const InfoDetailsView({
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
        Visibility(
          visible: ((infoDetails.ticketData?.requestTypeValue != null) &&
              (infoDetails.ticketData!.requestTypeValue!.isNotEmpty)),
          child: LabelValueWidget(
            label: 'Type Of Activity',
            value: infoDetails.ticketData?.requestTypeValue ?? "",
            padding: const EdgeInsets.all(7),
          ),
        ),
        //const Divider(),
        Visibility(
          visible: ((infoDetails.ticketData?.application != null) &&
              (infoDetails.ticketData!.application!.isNotEmpty)),
          child: LabelValueWidget(
            label: 'Application',
            value: infoDetails.ticketData?.application ?? "",
            padding: const EdgeInsets.all(7),
          ),
        ),
        //const Divider(),
        Visibility(
          visible: ((infoDetails.ticketData?.systemTemplate != null) &&
              (infoDetails.ticketData!.systemTemplate!.isNotEmpty)),
          child: LabelValueWidget(
            label: 'Template Name',
            value: infoDetails.ticketData?.systemTemplate ?? "",
            padding: const EdgeInsets.all(7),
          ),
        ),
        //const Divider(),
        Visibility(
          visible: ((infoDetails.ticketData?.genericIDOwnerEmpCode != null) &&
              (infoDetails.ticketData!.genericIDOwnerEmpCode!.isNotEmpty)),
          child: LabelValueWidget(
            label: "Owner's Employee Code",
            value: infoDetails.ticketData?.genericIDOwnerEmpName ?? "",
            padding: const EdgeInsets.all(7),
          ),
        ),
      ],
    );
  }
}
