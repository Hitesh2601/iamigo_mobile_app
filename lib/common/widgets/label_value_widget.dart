import 'package:push_notification/utility/constants/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LabelValueWidget extends StatelessWidget {
  LabelValueWidget(
      {super.key,
      required this.label,
      required this.value,
      this.padding = const EdgeInsets.only(bottom: 8)});

  final String label;
  final String value;
  EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                  color: FColors.listHeaderText, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(value),
          )
        ],
      ),
    );
  }
}
