import 'package:push_notification/utility/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget loaderScreen(BuildContext context, String message) {
  return Opacity(
    opacity: 1,
    child: AlertDialog(
      content: Container(
        padding: const EdgeInsets.all(10),
        height: 130,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 25),
              child: LoadingAnimationWidget.discreteCircle(
                color: FColors.textHeader,
                secondRingColor: FColors.textHeader,
                thirdRingColor: const Color(0xFFEA3799),
                size: 50,
              ),
            ),
            Text(
              message,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    ),
  );
}
