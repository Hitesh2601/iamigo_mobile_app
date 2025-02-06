import 'dart:ffi';
import 'dart:io';

import 'package:push_notification/utility/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:unique_identifier/unique_identifier.dart';

class HelperFunctions {
  static void showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  static void showAlert(String title, String message) {
    Get.dialog(AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('Ok'),
        ),
      ],
    ));
  }

  static Future<void> showAsyncAlert(String title, String message) async {
    await Get.dialog(AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('Ok'),
        ),
      ],
    ));
  }

  static Future<void> showExitAlert(String title, String message) async {
    await Get.dialog(AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => {exit(0)},
          child: const Text('Exit'),
        ),
      ],
    ));
  }

  static void showCopyAlert(String title, String message) {
    Get.dialog(AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () async => {
            await Clipboard.setData(ClipboardData(text: message)),
            Get.back()
          },
          child: const Text('Copy'),
        ),
      ],
    ));
  }

  static Future<String> confirmAlert(String title, String message) async =>
      showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          String value;
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => {value = 'Yes', Navigator.pop(context, value)},
                child: const Text('Yes'),
              ),
              TextButton(
                onPressed: () => {value = 'No', Navigator.pop(context, value)},
                child: const Text('No'),
              ),
            ],
          );
        },
      ).then((value) {
        return value;
      });

  static Future<bool?> showExitDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Exit App"),
          content: Text("Are you sure you want to exit?"),
          actions: [
            TextButton(
              onPressed: () => {exit(0)},
              child: const Text('Exit'),
            ),
          ],
        );
      },
    );
  }

  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  static int getNumber(int? value) {
    if (value == null) {
      return 0;
    } else {
      return value;
    }
  }

  static String truncateText(String text, int maxLength) {
    text = text.replaceAll("\n", " ");
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength - 3)}...';
    }
  }

  static String newLineText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}\n${text.substring(maxLength, text.length)}';
    }
  }

  static Future<String> getUniqueIdentifier() async {
    String identifier = "a72a7f4c-26d6-43bb-8830-75fb56a6a458";
    try {
      var iden = await UniqueIdentifier.serial;
      if (!isNullorEmpty(iden)) {
        identifier = iden!;
      }
    } on PlatformException {
      identifier = "a72a7f4c-26d6-43bb-8830-75fb56a6a458";
    }
    return identifier;
  }

  // static Future<bool> isRootOrJailbroken() async {
  //   if (Platform.isAndroid) {
  //     final isNotTrust = await JailbreakRootDetection.instance.isNotTrust;
  //     final isJailBroken = await JailbreakRootDetection.instance.isJailBroken;
  //     final isRealDevice = await JailbreakRootDetection.instance.isRealDevice;
  //     final isOnExternalStorage =
  //         await JailbreakRootDetection.instance.isOnExternalStorage;
  //     // final checkForIssues =
  //     //     await JailbreakRootDetection.instance.checkForIssues;
  //     final isDevMode = await JailbreakRootDetection.instance.isDevMode;
  //     return isNotTrust ||
  //         isJailBroken ||
  //         isRealDevice ||
  //         isOnExternalStorage ||
  //         isDevMode;
  //   } else if (Platform.isIOS) {
  //     final isNotTrust = await JailbreakRootDetection.instance.isNotTrust;
  //     final isJailBroken = await JailbreakRootDetection.instance.isJailBroken;
  //     final isRealDevice = await JailbreakRootDetection.instance.isRealDevice;
  //     // final checkForIssues =
  //     //     await JailbreakRootDetection.instance.checkForIssues;

  //     final bundleId =
  //         'com.hdfcbank.iha.Amigo'; // Ex: final bundleId = 'com.w3conext.jailbreakRootDetectionExample'
  //     final isTampered =
  //         await JailbreakRootDetection.instance.isTampered(bundleId);
  //     return isNotTrust || isJailBroken || isRealDevice || isTampered;
  //   } else {
  //     return false;
  //   }
  // }

  // static Size screenSize() {
  //   return MediaQuery.of(Get.context!).size;
  // }

  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  static String getFormattedDate(DateTime? date,
      {String format = 'dd MMM yyyy'}) {
    date ??= DateTime.now();
    return DateFormat(format).format(date);
  }

  static String getStringToFormattedDate(String value,
      {String format = 'dd MMM yyyy'}) {
    var date = DateTime.parse(value);
    return DateFormat(format).format(date);
  }

  static bool isNullorEmpty(String? text) {
    if (text == null) {
      return true;
    } else {
      return text.isEmpty;
    }
  }

  static bool isNumberNullorZero(String? text) {
    if (text == null) {
      return true;
    } else {
      var res = text.isEmpty;
      if (res) {
        return res;
      } else {
        return (text == "0.00");
      }
    }
  }

  static bool eqaulIgnoreCase(String? text1, String? text2) {
    if (text1 == null || text2 == null) {
      return false;
    } else {
      return text1.toLowerCase() == text2.toLowerCase();
    }
  }

  static String separateNumberByComma(String? text) {
    var formatter = NumberFormat('#,##,000.00');
    if (HelperFunctions.isNullorEmpty(text) || text == "0.00") {
      return "0.00";
    } else {
      String digit = text!.split(".")[0];
      int length = digit.length;
      if (length <= 3) {
        return text;
      } else {
        return formatter.format(double.parse(text));
      }
    }
  }

  static TableRow getFormattedRow(String label, String value) {
    return TableRow(children: [
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.intrinsicHeight,
        child: Container(
          color: FColors.light,
          padding: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              label,
              style: const TextStyle(
                  color: FColors.listHeaderText, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8),
        child: Text(value),
      ),
    ]);
  }

  static Future<String> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
}
