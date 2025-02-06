import 'package:push_notification/features/iApproval/screens/request_detail/widget/table_widget.dart';
import 'package:push_notification/features/iCart/models/icart_hardware_detail_response.dart';
import 'package:push_notification/features/iSAC/models/vendor_req_details_response.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class VendorHDFCContactListView extends StatelessWidget {
  const VendorHDFCContactListView(
      {super.key, required this.vendorHDFCContactList});
  final List<VendorHDFCContactList> vendorHDFCContactList;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 12),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: vendorHDFCContactList.length,
          itemBuilder: (context, index) {
            return VendorHDFCContactListItem(
              vendorHDFCContactList: vendorHDFCContactList[index],
            );
          },
        ),
      ],
    );
  }
}

class VendorHDFCContactListItem extends StatelessWidget {
  const VendorHDFCContactListItem(
      {super.key, required this.vendorHDFCContactList});
  final VendorHDFCContactList vendorHDFCContactList;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Table(
        border: TableBorder.all(color: Colors.grey, width: 0.5),
        children: [
          HelperFunctions.getFormattedRow(
              'Email ID', vendorHDFCContactList.EmailID ?? ""),
          HelperFunctions.getFormattedRow(
              'Staff ADID', vendorHDFCContactList.StaffADid ?? ""),
          HelperFunctions.getFormattedRow(
              'Staff Name', vendorHDFCContactList.StaffName ?? ""),
          HelperFunctions.getFormattedRow(
              'Staff Phone', vendorHDFCContactList.StaffPhone ?? ""),
        ],
      ),
    );
  }
}
