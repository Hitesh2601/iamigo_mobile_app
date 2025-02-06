import 'package:push_notification/utility/constants/colors.dart';
import 'package:flutter/material.dart';

class BottomRightCurveCardWidget extends StatelessWidget {
  final double height;
  const BottomRightCurveCardWidget({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(80)),
      ),
      child: ClipPath(
        clipper: const ShapeBorderClipper(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(80)))),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: height,
          color: FColors.accent,
        ),
      ),
    );
  }
}
