import 'package:push_notification/features/user/screens/master/master_page_screen.dart';
import 'package:push_notification/utility/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget(
      {super.key,
      required this.title,
      required this.icon,
      required this.iconColor});

  final String title;
  final String icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 5, right: 5, bottom: 10),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if (icon == "home") {
                Get.to(const MasterPageScreen());
              } else {
                Get.back(result: "refresh");
              }
            },
            child: SizedBox(
              child: Padding(
                padding: icon == "home"
                    ? const EdgeInsets.only(left: 10.0)
                    : const EdgeInsets.only(left: 0),
                child: Icon(
                    icon == "home"
                        ? FontAwesomeIcons.bars
                        : FontAwesomeIcons.arrowLeft,
                    size: 33,
                    color: iconColor),
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: FColors.textWhite,
                        fontSize: 20,
                        fontWeight: FontWeight.w400)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
