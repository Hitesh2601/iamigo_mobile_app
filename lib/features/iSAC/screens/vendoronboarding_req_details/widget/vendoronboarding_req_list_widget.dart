import 'package:push_notification/features/iSAC/models/vendor_req_details_response.dart';
import 'package:push_notification/features/iSAC/screens/vendoronboarding_req_details/widget/vendoronboarding_req_item_widget.dart';
import 'package:flutter/material.dart';

class VendorRequestListDetailsWidget extends StatelessWidget {
  const VendorRequestListDetailsWidget({super.key, required this.dataItem});
  final List<DetailData> dataItem;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: dataItem.length,
      itemBuilder: (context, index) {
        return VendorRequestListDetailsItemWidget(
          dataItem: dataItem[index],
        );
      },
    );
  }
}
