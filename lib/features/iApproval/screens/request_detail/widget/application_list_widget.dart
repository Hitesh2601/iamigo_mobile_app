// ignore_for_file: prefer_const_constructors

import 'package:push_notification/features/iApproval/models/fpn_request_details_response.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class ApplicationListWidget extends StatelessWidget {
  const ApplicationListWidget(
      {super.key, required this.detailList, required this.totalAmount});
  final List<DetailList> detailList;
  final String totalAmount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          padding: const EdgeInsets.all(10),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: detailList.length,
          itemBuilder: (context, index) {
            return ApplicationDetailsTableItemView(
              detailList: detailList[index],
            );
          },
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                'Total Amount :',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              Text(totalAmount, style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        )
      ],
    );
  }
}

class ApplicationDetailsTableItemView extends StatelessWidget {
  const ApplicationDetailsTableItemView({super.key, required this.detailList});

  final DetailList detailList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Table(
        border: TableBorder.all(color: Colors.grey, width: 0.5),
        children: [
          HelperFunctions.getFormattedRow(
              'Application Name', detailList.appName!),
          HelperFunctions.getFormattedRow(
              'Vender Name', detailList.vendorName!),
          HelperFunctions.getFormattedRow(
              'BTG/BSG Technology Application Owner', detailList.appOwnerName!),
          HelperFunctions.getFormattedRow(
              'Business FH Name', detailList.businessFhName!),
          HelperFunctions.getFormattedRow(
              'Project Execution Owner', detailList.executionOwnerName!),
          HelperFunctions.getFormattedRow(
              'Vender Resource Count', detailList.count!),
          HelperFunctions.getFormattedRow('Amount', detailList.amount),
          HelperFunctions.getFormattedRow(
              'Project Manager Name', detailList.projectManager!),
        ],
      ),
    );
  }
}
