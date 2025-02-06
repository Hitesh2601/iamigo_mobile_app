import 'package:push_notification/features/iCart/models/icart_request_response.dart';
import 'package:push_notification/features/iCart/screens/request_list/software/software_request_item.dart';
import 'package:push_notification/features/iSAC/screens/request_list/widget/isac_request_list_widget.dart';
import 'package:flutter/material.dart';

class SoftwareRequestListScreen extends StatelessWidget {
  const SoftwareRequestListScreen({
    super.key,
    required this.dataItem,
    required this.isPending,
    required this.profile,
    required this.filteredRequestNo,
    required this.requestType,
  });

  final bool isPending;
  final List<RequestListSoftware> dataItem;
  final List<String>? filteredRequestNo;
  final String profile;
  final String requestType;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: dataItem.length,
      itemBuilder: (context, index) {
        return AnimatedListItem(
          //delay: Duration(milliseconds: index * 100),
          index: index,
          child: SoftwareRequestItem(
              dataItem: dataItem[index],
              isPending: isPending,
              profile: profile,
              filteredRequestNo: filteredRequestNo,
              requestType: requestType),
        );
      },
    );
  }
}
