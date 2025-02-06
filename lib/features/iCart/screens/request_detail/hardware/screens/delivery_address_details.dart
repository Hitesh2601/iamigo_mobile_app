import 'package:push_notification/common/widgets/label_value_widget.dart';
import 'package:push_notification/features/iCart/models/icart_hardware_detail_response.dart';
import 'package:flutter/material.dart';

class DeliveryDetailsView extends StatelessWidget {
  const DeliveryDetailsView({
    super.key,
    required this.deliveryDetails,
  });

  final DeliveryDetails deliveryDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelValueWidget(
          label: 'Deliver Branch Code',
          value: deliveryDetails.deliverBranchCode ?? "NA",
          padding: const EdgeInsets.all(5),
        ),
        LabelValueWidget(
          label: 'Branch Name',
          value: deliveryDetails.deliverBranchName ?? "NA",
          padding: const EdgeInsets.all(5),
        ),
        LabelValueWidget(
          label: 'Building Value',
          value: deliveryDetails.buildingValue ?? "NA",
          padding: const EdgeInsets.all(5),
        ),
        LabelValueWidget(
          label: 'Floor No.',
          value: deliveryDetails.floorNo ?? "NA",
          padding: const EdgeInsets.all(5),
        ),
        LabelValueWidget(
          label: 'Delivery Address',
          value: deliveryDetails.deliverAddress ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
        LabelValueWidget(
          label: 'Contact Employee Code',
          value: deliveryDetails.contactEmpCode ?? "NA",
          padding: const EdgeInsets.all(5),
        ),
        LabelValueWidget(
          label: 'Contact Employee Name',
          value: deliveryDetails.contactEmpName ?? "NA",
          padding: const EdgeInsets.all(5),
        ),
        LabelValueWidget(
          label: 'Contact Number',
          value: deliveryDetails.contactNum ?? "NA",
          padding: const EdgeInsets.all(5),
        ),
      ],
    );
  }
}
