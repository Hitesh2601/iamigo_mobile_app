import 'package:push_notification/features/iApproval/screens/request_detail/widget/table_widget.dart';
import 'package:push_notification/features/iCart/models/icart_hardware_detail_response.dart';
import 'package:flutter/material.dart';

class ApproverHistoryView extends StatelessWidget {
  const ApproverHistoryView({super.key, required this.approverHistory});
  final List<ApproverHistory> approverHistory;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 12),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: approverHistory.length,
          itemBuilder: (context, index) {
            return ApproverHistoryItem(
              approverHistory: approverHistory[index],
            );
          },
        ),
      ],
    );
  }
}

class ApproverHistoryItem extends StatelessWidget {
  const ApproverHistoryItem({super.key, required this.approverHistory});
  final ApproverHistory approverHistory;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Column(
        children: [
          TableViewWidget(
            header: 'Approver Role',
            headerValue: approverHistory.approverRole ?? "NA",
          ),
          TableViewWidget(
            header: 'Status',
            headerValue: approverHistory.status ?? "NA",
          ),
          TableViewWidget(
            header: 'Action By',
            headerValue: approverHistory.actionBy ?? "NA",
          ),
          TableViewWidget(
            header: 'Action By Name',
            headerValue: approverHistory.actionByName ?? "NA",
          ),
          TableViewWidget(
            header: 'Action Date',
            headerValue: approverHistory.actionDate ?? "NA",
          ),
          TableViewWidget(
            header: 'Remarks',
            headerValue: approverHistory.remarks ?? "NA",
          ),
        ],
      ),
    );
  }
}
