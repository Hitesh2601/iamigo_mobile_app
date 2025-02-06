import 'package:push_notification/features/iApproval/models/fpn_request_details_response.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CostCenterListWidget extends StatelessWidget {
  const CostCenterListWidget({
    super.key,
    required this.costCenterDetails,
  });

  final List<CostCenterDetail> costCenterDetails;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10.0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: costCenterDetails.length,
      itemBuilder: (context, index) {
        return CostCenterDetailsView(
            costCenterDetail: costCenterDetails[index]);
      },
    );
  }
}

class CostCenterDetailsView extends StatelessWidget {
  const CostCenterDetailsView({super.key, required this.costCenterDetail});
  final CostCenterDetail costCenterDetail;

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Colors.grey, width: 0.5),
      children: [
        HelperFunctions.getFormattedRow(
            'Cost Center Code', costCenterDetail.costCenterCode!),
        HelperFunctions.getFormattedRow(
            'Cost Center Name', costCenterDetail.costCenterName!),
        HelperFunctions.getFormattedRow(
            'Cost Center Percentage', costCenterDetail.costCenterPercentage!),
      ],
    );
  }
}
