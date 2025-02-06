import 'package:push_notification/features/iCart/models/icart_request_response.dart';
import 'package:push_notification/features/iCart/screens/request_list/hardware/hardware_request_item.dart';
import 'package:push_notification/features/iSAC/screens/request_list/widget/isac_request_list_widget.dart';
import 'package:flutter/material.dart';

class HardwareRequestListScreen extends StatelessWidget {
  const HardwareRequestListScreen(
      {super.key,
      required this.dataItem,
      required this.isPending,
      required this.profile,
      required this.requestType,
      required this.filteredRequestNo});

  final List<RequestListHardware> dataItem;
  final bool isPending;
  final String profile;
  final List<String>? filteredRequestNo;
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
          child: HardwareRequestItem(
              dataItem: dataItem[index],
              isPending: isPending,
              profile: profile,
              requestType: requestType,
              filteredRequestNo: filteredRequestNo),
        );
      },
    );
  }
}
