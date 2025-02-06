import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ICartDetailMenus {
  static List<DetailMenuItem> icartMenuList = [
    DetailMenuItem(
        name: 'Request Information',
        icon: FontAwesomeIcons.fileInvoice,
        isSelected: false),
    DetailMenuItem(
        name: 'Employee Information',
        icon: FontAwesomeIcons.userTie,
        isSelected: false),
    DetailMenuItem(
        name: 'Unit Details', icon: FontAwesomeIcons.gear, isSelected: false),
    DetailMenuItem(
        name: 'Delivery Details',
        icon: FontAwesomeIcons.solidMap,
        isSelected: false),
    DetailMenuItem(
        name: 'Existing Asset Details',
        icon: FontAwesomeIcons.receipt,
        isSelected: false),
    DetailMenuItem(
        name: 'Request Reason',
        icon: FontAwesomeIcons.circleQuestion,
        isSelected: false),
    DetailMenuItem(
        name: 'Query Feedback', icon: FontAwesomeIcons.info, isSelected: false),
    DetailMenuItem(
        name: 'Approver Details',
        icon: FontAwesomeIcons.userCheck,
        isSelected: false),
    DetailMenuItem(
        name: 'Approver History',
        icon: FontAwesomeIcons.listCheck,
        isSelected: false),
    DetailMenuItem(
        name: 'PO, Insurance & Installation',
        icon: FontAwesomeIcons.handHoldingDollar,
        isSelected: false),
    DetailMenuItem(
        name: 'Invoicing Payment & FAR',
        icon: FontAwesomeIcons.fileInvoiceDollar,
        isSelected: false),
  ];

  static List<DetailMenuItem> icartSoftwareMenuList = [
    DetailMenuItem(
        name: 'Request Information',
        icon: FontAwesomeIcons.fileInvoice,
        isSelected: false),
    DetailMenuItem(
        name: 'Employee Information',
        icon: FontAwesomeIcons.userTie,
        isSelected: false),
    DetailMenuItem(
        name: 'Software Details',
        icon: FontAwesomeIcons.gear,
        isSelected: false),
    DetailMenuItem(
        name: 'Asset Details',
        icon: FontAwesomeIcons.receipt,
        isSelected: false),
    DetailMenuItem(
        name: 'Extension Request',
        icon: FontAwesomeIcons.fileCircleCheck,
        isSelected: false),
    DetailMenuItem(
        name: 'Request Details',
        icon: FontAwesomeIcons.fileCircleCheck,
        isSelected: false),
    DetailMenuItem(
        name: 'Query Feedback', icon: FontAwesomeIcons.info, isSelected: false),
    DetailMenuItem(
        name: 'Approval Period',
        icon: FontAwesomeIcons.solidMap,
        isSelected: false),
    DetailMenuItem(
        name: 'Approver Details',
        icon: FontAwesomeIcons.userCheck,
        isSelected: false),
    DetailMenuItem(
        name: 'Approver History',
        icon: FontAwesomeIcons.listCheck,
        isSelected: false),
    DetailMenuItem(
        name: 'Temporary License',
        icon: FontAwesomeIcons.handHoldingDollar,
        isSelected: false),
  ];
}

class DetailMenuItem {
  final String name;
  final IconData icon;
  final bool isSelected;
  DetailMenuItem(
      {required this.name, required this.icon, required this.isSelected});
}

class ICartMasterMenu {
  static List<DetailMenuItem> fpnMenuList = [
    DetailMenuItem(
        name: 'Home', icon: FontAwesomeIcons.house, isSelected: false),
    DetailMenuItem(
        name: 'Dashboard',
        icon: FontAwesomeIcons.solidChartBar,
        isSelected: false),
    DetailMenuItem(
        name: 'Pending For Approval',
        icon: FontAwesomeIcons.userClock,
        isSelected: false),
    DetailMenuItem(
        name: 'Sign Out', icon: FontAwesomeIcons.powerOff, isSelected: false),
  ];
}
