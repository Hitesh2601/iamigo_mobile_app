// ignore_for_file: file_names

import 'package:push_notification/utility/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ISACDetailMenus {
  static List<ISACMenuItem> isacMenuList = [
    ISACMenuItem(
        name: 'Information', icon: FontAwesomeIcons.info, isSelected: false),
    ISACMenuItem(
        name: 'Requestor Info', icon: FontAwesomeIcons.user, isSelected: false),
    ISACMenuItem(
        name: 'Audit Trail',
        icon: FontAwesomeIcons.listCheck,
        isSelected: false)
  ];
}

class ISACMenuItem {
  final String name;
  final IconData icon;
  final bool isSelected;
  ISACMenuItem(
      {required this.name, required this.icon, required this.isSelected});
}

class ISACMasterMenu {
  static List<ISACMenuItem> fpnMenuList = [
    ISACMenuItem(name: 'Home', icon: FontAwesomeIcons.house, isSelected: false),
    ISACMenuItem(
        name: 'Dashboard',
        icon: FontAwesomeIcons.solidChartBar,
        isSelected: false),
    ISACMenuItem(
        name: 'Pending For Approval',
        icon: FontAwesomeIcons.userClock,
        isSelected: false),
    ISACMenuItem(
        name: 'Sign Out', icon: FontAwesomeIcons.powerOff, isSelected: false),
  ];
}

class BorderedLabelIconWidget extends StatelessWidget {
  final IconData icon;
  final String name;
  final double height;
  final double width;
  final bool isSelected;

  const BorderedLabelIconWidget(
      {super.key,
      required this.icon,
      required this.name,
      this.height = 50,
      this.width = 80,
      this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  border: Border.all(color: FColors.light),
                  borderRadius: BorderRadius.circular(70),
                  color: isSelected ? FColors.textHeader : FColors.light,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[400]!,
                        blurRadius: 3.0,
                        blurStyle: BlurStyle.normal),
                  ]),
              child: Icon(
                icon,
                size: name == "More" || name == "Less" ? 50 : 20,
                color: isSelected ? FColors.light : FColors.textHeader,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                name,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ),
          ]),
    );
  }
}
