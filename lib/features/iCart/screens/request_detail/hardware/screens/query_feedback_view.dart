import 'package:push_notification/features/iApproval/screens/request_detail/widget/table_widget.dart';
import 'package:push_notification/features/iCart/models/icart_hardware_detail_response.dart';
import 'package:flutter/material.dart';

class QueryFeedbackView extends StatelessWidget {
  const QueryFeedbackView({super.key, required this.queryFeedback});
  final List<QueryFeedback> queryFeedback;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 12),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: queryFeedback.length,
          itemBuilder: (context, index) {
            return QueryFeedbackItem(
              queryFeedback: queryFeedback[index],
            );
          },
        ),
      ],
    );
  }
}

class QueryFeedbackItem extends StatelessWidget {
  const QueryFeedbackItem({super.key, required this.queryFeedback});
  final QueryFeedback queryFeedback;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Column(
        children: [
          TableViewWidget(
            header: 'Request Number',
            headerValue: queryFeedback.requestNo ?? "NA",
          ),
          TableViewWidget(
            header: 'Status',
            headerValue: queryFeedback.status ?? "NA",
          ),
          TableViewWidget(
            header: 'Action By',
            headerValue: queryFeedback.actionBy ?? "NA",
          ),
          TableViewWidget(
            header: 'Action Date',
            headerValue: queryFeedback.actionDate ?? "NA",
          ),
          TableViewWidget(
            header: 'Query Feedback',
            headerValue: queryFeedback.hardwareQueryFeedback ?? "NA",
          ),
        ],
      ),
    );
  }
}
