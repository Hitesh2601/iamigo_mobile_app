import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class HelperFunctions {
  static void showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  static void showAlert(String title, String message) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  static void showCopyAlert(String title, String message) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: message));
                Navigator.of(context).pop();
                // copied successfully
              },
              child: const Text('Copy'),
            ),
          ],
        );
      },
    );
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

  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  // static Future<MaterialPageRoute> redirectURL() async {
  //   if (isNullorEmpty(GlobalVariables.redirectURL)) {
  //     final splitted = GlobalVariables.redirectURL.split('/');
  //     bool isPending = splitted[1] == "pending";
  //     if (splitted[0] == "FPN") {
  //       // iSACURl: FPN/pending/fpnNumber
  //       return MaterialPageRoute(
  //           builder: (context) => FpnDetailsScreen(
  //                 fpnNumber: splitted[1],
  //                 isButtonVisible: isPending,
  //                 callback: (val) => (() => val),
  //               ));
  //     } else if (splitted[0] == "iSAC") {
  //       // iSACURl: iSAC/pending/encRequestID/encFormID/ticketNumber
  //       return MaterialPageRoute(
  //           builder: (context) => ISACDetailsScreen(
  //                 encrequestID: splitted[2],
  //                 isButtonVisible: isPending,
  //                 formID: splitted[3],
  //                 ticketnumber: splitted[4],
  //               ));
  //     } else if (splitted[0] == "iCART") {
  //       // iCART: iCART/pending/software/profile/requestNo
  //       if (splitted[2] == "software") {
  //         return MaterialPageRoute(
  //             builder: (context) => SoftwareDetailsScreen(
  //                   requestNumber: splitted[4],
  //                   profile: splitted[3],
  //                   isButtonVisible: isPending,
  //                 ));
  //       }
  //       if (splitted[1] == "hardware") {
  //         return MaterialPageRoute(
  //             builder: (context) => HardwareDetailsScreen(
  //                   requestNumber: splitted[4],
  //                   profile: splitted[3],
  //                   isButtonVisible: isPending,
  //                 ));
  //       }
  //     } else {
  //       MaterialPageRoute(
  //         builder: (context) => const HomeScreen(),
  //       );
  //     }
  //   } else {
  //     MaterialPageRoute(
  //       builder: (context) => const HomeScreen(),
  //     );
  //   }
  // }

  static bool isNullorEmpty(String? text) {
    if (text == null) {
      return true;
    } else {
      return text.isEmpty;
    }
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  static String newLineText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}\n${text.substring(maxLength, text.length)}';
    }
  }

  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

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
}
