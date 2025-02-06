// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:push_notification/features/iCart/models/icart_hardware_detail_response.dart';
import 'package:flutter/material.dart';

class ChecklistValidationScreen extends StatelessWidget {
  const ChecklistValidationScreen({
    super.key,
    required this.checklistValidations,
  });

  final ChecklistValidations checklistValidations;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey.shade300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 12, bottom: 12),
                        child: Text(
                          "FM Checklist",
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                questionAnswerWidget(
                    "A) ",
                    "There is no asset provided as replacement against the same asset code and serial number in the past.",
                    '${checklistValidations.assetReplace}'),
                questionAnswerWidget(
                    "B) ",
                    "FM Call-id specified by user pertains to the asset code/serial number mentioned by the user.",
                    '${checklistValidations.userMentionedID}'),
                questionAnswerWidget(
                    "C) ",
                    "There is no replacement provided against the same FM call-id in the past.",
                    '${checklistValidations.sameCallID}'),
              ],
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey.shade300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 12, bottom: 12),
                        child: Text(
                          "Asset Detail Verification",
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                questionAnswerWidget(
                    "A) ",
                    "Is Availability of asset in Free pool matching the configuration Raised by user.",
                    '${checklistValidations.freePool}'),
              ],
            ),
          ),
        )
      ],
    );
  }

  Padding questionAnswerWidget(
    String quetionNumber,
    String quetion,
    String answer,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                quetionNumber,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Flexible(
                child: Text(
                  quetion,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 4, 0, 8),
            child: Text(
              answer == "NotApplicable" ? "Not Applicable" : answer,
              style: TextStyle(
                  color: Colors.grey.shade600, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
