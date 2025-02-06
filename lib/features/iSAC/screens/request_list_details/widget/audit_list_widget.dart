// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, non_constant_identifier_names, prefer_const_literals_to_create_immutables, unnecessary_cast

import 'package:push_notification/common/widgets/label_value_widget.dart';
import 'package:push_notification/features/iSAC/models/isac_request_details_response.dart';
import 'package:push_notification/utility/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuditListWidget extends StatelessWidget {
  const AuditListWidget({
    super.key,
    required this.requestTicketMISDetailsList,
  });

  //final ISACRequestDetailsClass AuditDetails;
  final List<RequestTicketMISDetailsList> requestTicketMISDetailsList;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text("Audit Trail",
        //     textAlign: TextAlign.start,
        //     style: const TextStyle(
        //         fontWeight: FontWeight.w600,
        //         color: FColors.textPrimary,
        //         fontSize: 16)),
        ListView.builder(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          itemCount: requestTicketMISDetailsList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return AuditTrailView(
              requestTicketMISDetailsList: requestTicketMISDetailsList[index],
            );
          },
        ),
      ],
    );
  }
}

class AuditTrailView extends StatelessWidget {
  const AuditTrailView({super.key, required this.requestTicketMISDetailsList});

  final RequestTicketMISDetailsList requestTicketMISDetailsList;

  @override
  Widget build(BuildContext context) {
    //bool isSubmitted =
    //requestTicketMISDetailsList.statusDesc!.toLowerCase().contains("Submitted");
    bool isrejected = requestTicketMISDetailsList.statusDesc!
        .toLowerCase()
        .contains("rejected");
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizedBox(
        //   height: 20,
        // ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                  isrejected
                      ? FontAwesomeIcons.solidCircleXmark
                      : FontAwesomeIcons.solidCircleCheck,
                  size: 30,
                  color: isrejected
                      ? FColors.rejecttextpanelcolor
                      : FColors.approvetextpanelcolor),
              SizedBox(width: 10),
              Text(requestTicketMISDetailsList.statusDesc.toString(),
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: FColors.textPrimary,
                      fontSize: 16))
            ],
          ),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Container(
                height: 90,
                width: 2,
                color: FColors.textSecondary,
                padding: EdgeInsets.only(left: 15, right: 15),
              ),
            ),
            SizedBox(width: 12),
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 38,
                child: Card(
                    child: Column(
                  children: [
                    LabelValueWidget(
                      label: 'Action By',
                      value: requestTicketMISDetailsList.actionBy ?? "NA",
                      padding: const EdgeInsets.all(5),
                    ),
                    //const Divider(),
                    LabelValueWidget(
                      label: 'Action Date',
                      value: requestTicketMISDetailsList.actionAt ?? "NA",
                      padding: const EdgeInsets.all(5),
                    )
                  ],
                )),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
      ],
    );
  }
}
