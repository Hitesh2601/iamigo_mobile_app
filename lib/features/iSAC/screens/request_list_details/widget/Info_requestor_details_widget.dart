// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:push_notification/common/widgets/label_value_widget.dart';
import 'package:push_notification/features/iSAC/models/isac_request_details_response.dart';

class RequestorInfoDetailsView extends StatelessWidget {
  const RequestorInfoDetailsView({
    super.key,
    required this.infoDetails,
  });

  final ISACRequestDetailsClass infoDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelValueWidget(
          label: 'Emp Code',
          value: infoDetails.ticketData?.identityStoreMaster?.empCode ?? "NA",
          padding: const EdgeInsets.all(7),
        ),
        // const Divider(),
        LabelValueWidget(
          label: 'Emp Name',
          value: infoDetails.ticketData?.identityStoreMaster?.empName ?? "NA",
          padding: const EdgeInsets.all(7),
        ),
        // const Divider(),
        LabelValueWidget(
          label: 'Department',
          value: infoDetails.ticketData?.identityStoreMaster?.costCenterName ??
              "NA",
          padding: const EdgeInsets.all(7),
        ),
        //const Divider(),
        LabelValueWidget(
          label: 'Cost Code',
          value: infoDetails.ticketData?.identityStoreMaster?.costCode ?? "NA",
          padding: const EdgeInsets.all(7),
        ),
        // const Divider(),
        LabelValueWidget(
          label: 'Email ID',
          value: infoDetails.ticketData?.identityStoreMaster?.emailId ?? "NA",
          padding: const EdgeInsets.all(7),
        ),
        // const Divider(),
        LabelValueWidget(
          label: 'Company Type',
          value: infoDetails.ticketData?.identityStoreMaster?.companyName
                  .toString() ??
              "NA",
          padding: const EdgeInsets.all(7),
        ),
        //const Divider(),
        LabelValueWidget(
          label: 'Branch Code',
          value:
              infoDetails.ticketData?.identityStoreMaster?.branchCode ?? "NA",
          padding: const EdgeInsets.all(7),
        ),
        // const Divider(),
        LabelValueWidget(
          label: 'Branch Name',
          value:
              infoDetails.ticketData?.identityStoreMaster?.branchName ?? "NA",
          padding: const EdgeInsets.all(7),
        ),
        //const Divider(),
        LabelValueWidget(
          label: 'Line Manager',
          value:
              infoDetails.ticketData?.identityStoreMaster?.supervisorEmpCode ??
                  "NA",
          padding: const EdgeInsets.all(7),
        ),
        //const Divider(),
        LabelValueWidget(
          label: 'App ID',
          value: infoDetails
                  .ticketData?.identityStoreMaster?.empActiveDirectoryID ??
              "NA",
          padding: const EdgeInsets.all(7),
        ),
      ],
    );
  }
}
