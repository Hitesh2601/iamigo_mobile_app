import 'package:push_notification/features/iApproval/screens/request_detail/widget/table_widget.dart';
import 'package:push_notification/features/iSAC/models/isac_request_details_response.dart';
import 'package:push_notification/features/iSAC/models/vendor_req_details_response.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class PropritorPartnerDetailsView extends StatelessWidget {
  const PropritorPartnerDetailsView(
      {super.key, required this.proprietorDetails});
  final List<ProprietorPANDetail> proprietorDetails;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: proprietorDetails.length,
      itemBuilder: (context, index) {
        return PropritorPartnerDetailsItemWidget(
            proprietorDetails: proprietorDetails[index]);
      },
    );
  }
}

class PropritorPartnerDetailsItemWidget extends StatelessWidget {
  const PropritorPartnerDetailsItemWidget(
      {super.key, required this.proprietorDetails});
  final ProprietorPANDetail proprietorDetails;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Table(
        border: TableBorder.all(color: Colors.grey, width: 0.5),
        children: [
          HelperFunctions.getFormattedRow('Name', proprietorDetails.Name ?? ""),
          HelperFunctions.getFormattedRow(
              'Residential Status', proprietorDetails.ResidentialStatus ?? ""),
          HelperFunctions.getFormattedRow(
              'Address', proprietorDetails.Address ?? ""),
          HelperFunctions.getFormattedRow('CIN', proprietorDetails.CIN ?? ""),
          HelperFunctions.getFormattedRow(
              'Contact Number', proprietorDetails.ContactNo ?? ""),
          HelperFunctions.getFormattedRow('DIN', proprietorDetails.DIN ?? ""),
          HelperFunctions.getFormattedRow('DOB', proprietorDetails.DOB ?? ""),
          HelperFunctions.getFormattedRow(
              'Email ID', proprietorDetails.EmailId ?? ""),
          HelperFunctions.getFormattedRow(
              'PAN Number', proprietorDetails.PANNumber ?? ""),
          HelperFunctions.getFormattedRow(
              'PAN Status', proprietorDetails.PANStatus ?? ""),
          HelperFunctions.getFormattedRow(
              'PAN Seeding Status', proprietorDetails.PANseedingStatus ?? ""),
          HelperFunctions.getFormattedRow(
              'Passport Number', proprietorDetails.PassportNumber ?? ""),
          HelperFunctions.getFormattedRow(
              'Name Status', proprietorDetails.PropNameStatus ?? ""),
          HelperFunctions.getFormattedRow(
              'DOB Status', proprietorDetails.PropPanDOBStatus ?? ""),
        ],
      ),
    );
  }
}
