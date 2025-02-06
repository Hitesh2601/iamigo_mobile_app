import 'package:push_notification/utility/constants/colors.dart';
import 'package:flutter/material.dart';

class TableViewWidget extends StatelessWidget {
  final String header, headerValue;
  const TableViewWidget(
      {super.key, required this.header, required this.headerValue});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 36,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.5),
                color: FColors.light),
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                header,
                style: const TextStyle(
                    color: FColors.listHeaderText, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 36,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.5),
            ),
            child: Text(headerValue),
          ),
        ),
      ],
    );
  }
}
