import 'package:push_notification/features/iApproval/models/fpn_request_list_response.dart';
import 'package:push_notification/features/iApproval/screens/request_list/widget/fpn_request_item_widget.dart';
import 'package:push_notification/features/iSAC/screens/request_list/widget/isac_request_list_widget.dart';
import 'package:flutter/material.dart';

class RequestListWidget extends StatelessWidget {
  const RequestListWidget({
    super.key,
    required this.dataItem,
    required this.isButtonVisible,
    required this.requestType,
    required this.maincontext,
  });
  final bool isButtonVisible;
  final List<FPNData> dataItem;
  final String requestType;
  final BuildContext maincontext;

  @override
  Widget build(BuildContext context) {
    List<String> filteredRequestNo = dataItem.map((e) => e.fPNNumber!).toList();
    return ListView.builder(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: dataItem.length,
      itemBuilder: (context, index) {
        return AnimatedListItem(
          index: index,
          child: FPNRequestItemWidget(
              dataItem: dataItem[index],
              isButtonVisible: isButtonVisible,
              filteredRequestNo: filteredRequestNo,
              requestType: requestType,
              ctx: maincontext),
        );
      },
    );
  }
}
