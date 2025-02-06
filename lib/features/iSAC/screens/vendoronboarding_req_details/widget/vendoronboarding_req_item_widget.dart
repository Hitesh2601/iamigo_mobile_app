import 'package:push_notification/common/widgets/label_value_widget.dart';
import 'package:push_notification/features/iSAC/models/vendor_req_details_response.dart';
import 'package:flutter/material.dart';

class VendorRequestListDetailsItemWidget extends StatelessWidget {
  const VendorRequestListDetailsItemWidget({super.key, required this.dataItem});
  final DetailData dataItem;

  @override
  Widget build(BuildContext context) {
    //TextEditingController txtApproveRemarkController = TextEditingController();
    //TextEditingController txtRejectRemarkController = TextEditingController();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelValueWidget(
            label: dataItem.key ?? "",
            value: dataItem.value ?? "",
            padding: const EdgeInsets.all(7)),
        //const Divider(),
      ],
    );
  }
}
