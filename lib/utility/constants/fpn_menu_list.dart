import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FPNDetailMenus {
  static List<FPNMenuItem> fpnMenuList = [
    FPNMenuItem(
        name: 'Project', icon: FontAwesomeIcons.fileInvoice, isSelected: false),
    FPNMenuItem(
        name: 'Application', icon: FontAwesomeIcons.filePen, isSelected: false),
    FPNMenuItem(
        name: 'Budget',
        icon: FontAwesomeIcons.handHoldingDollar,
        isSelected: false),
    FPNMenuItem(
        name: 'Additional',
        icon: FontAwesomeIcons.fileCirclePlus,
        isSelected: false),
    FPNMenuItem(name: 'TCO', icon: FontAwesomeIcons.filePen, isSelected: false),
    FPNMenuItem(
        name: 'Cost Center',
        icon: FontAwesomeIcons.sackDollar,
        isSelected: false),
    FPNMenuItem(
        name: 'Process Attachment',
        icon: FontAwesomeIcons.paperclip,
        isSelected: false),
    FPNMenuItem(
        name: 'FPN Intimation',
        icon: FontAwesomeIcons.circleInfo,
        isSelected: false),
    FPNMenuItem(
        name: 'Benefit', icon: FontAwesomeIcons.award, isSelected: false),
    FPNMenuItem(
        name: 'Case Approval',
        icon: FontAwesomeIcons.fileCircleCheck,
        isSelected: false),
    FPNMenuItem(
        name: 'Fincon Sendback',
        icon: FontAwesomeIcons.shareFromSquare,
        isSelected: false),
    FPNMenuItem(
        name: 'Feedback',
        icon: FontAwesomeIcons.solidCommentDots,
        isSelected: false),
    FPNMenuItem(
        name: 'Audit Trail',
        icon: FontAwesomeIcons.listCheck,
        isSelected: false)
  ];
}

class FPNMenuItem {
  final String name;
  final IconData icon;
  final bool isSelected;
  FPNMenuItem(
      {required this.name, required this.icon, required this.isSelected});
}

class FPNMasterMenu {
  static List<FPNMenuItem> fpnMenuList = [
    FPNMenuItem(name: 'Home', icon: FontAwesomeIcons.house, isSelected: false),
    FPNMenuItem(
        name: 'Dashboard',
        icon: FontAwesomeIcons.solidChartBar,
        isSelected: false),
    FPNMenuItem(
        name: 'Pending For Approval',
        icon: FontAwesomeIcons.userClock,
        isSelected: false),
    FPNMenuItem(
        name: 'Sign Out', icon: FontAwesomeIcons.powerOff, isSelected: false),
  ];
}
