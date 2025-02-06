import 'package:push_notification/features/iApproval/models/fpn_request_details_response.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class BudgetDetailsWidget extends StatelessWidget {
  const BudgetDetailsWidget(
      {super.key,
      required this.budgetDetails,
      required this.totalBudgetAmount});

  final List<BudgetDetail> budgetDetails;
  final String totalBudgetAmount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          padding: const EdgeInsets.all(10),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: budgetDetails.length,
          itemBuilder: (context, index) {
            return BudgetDetailsTableView(budgetDetail: budgetDetails[index]);
          },
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                'Total Budget Amount :',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              Text(
                totalBudgetAmount,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class BudgetDetailsTableView extends StatelessWidget {
  const BudgetDetailsTableView({super.key, required this.budgetDetail});
  final BudgetDetail budgetDetail;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Table(
        border: TableBorder.all(color: Colors.grey, width: 0.5),
        children: [
          HelperFunctions.getFormattedRow('Type', budgetDetail.type!),
          HelperFunctions.getFormattedRow('Serial No', budgetDetail.serialNo!),
          HelperFunctions.getFormattedRow(
              'Description', budgetDetail.desciption!),
          HelperFunctions.getFormattedRow('Value', budgetDetail.value!),
          HelperFunctions.getFormattedRow(
              'Utilized Amount', budgetDetail.utilizedAmt!),
          HelperFunctions.getFormattedRow(
              'Available Amount', budgetDetail.availableAmt!),
          HelperFunctions.getFormattedRow(
              'Requested Amount', budgetDetail.requestedAmt!),
        ],
      ),
    );
  }
}
