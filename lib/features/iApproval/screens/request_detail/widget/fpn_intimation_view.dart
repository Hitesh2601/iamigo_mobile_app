// ignore_for_file: prefer_const_constructors

import 'package:push_notification/features/iApproval/models/fpn_request_details_response.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class FPNIntimationWidget extends StatelessWidget {
  const FPNIntimationWidget({super.key, required this.fYIFPNDetails});
  final List<FYIFPNDetails> fYIFPNDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          padding: const EdgeInsets.all(10),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: fYIFPNDetails.length,
          itemBuilder: (context, index) {
            return FPNIntimationTableItemViewTableItemView(
              detail: fYIFPNDetails[index],
            );
          },
        ),
      ],
    );
  }
}

class FPNIntimationTableItemViewTableItemView extends StatelessWidget {
  const FPNIntimationTableItemViewTableItemView(
      {super.key, required this.detail});

  final FYIFPNDetails detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Table(
        border: TableBorder.all(color: Colors.grey, width: 0.5),
        children: [
          HelperFunctions.getFormattedRow('Employee Code', detail.empCode!),
          HelperFunctions.getFormattedRow('Employee Name', detail.empName!),
          HelperFunctions.getFormattedRow('Employee Email', detail.empEmail!),
        ],
      ),
    );
  }
}
