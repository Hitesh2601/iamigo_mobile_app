import 'package:flutter/material.dart';

class CustomShapeWidget extends StatelessWidget {
  const CustomShapeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
      child: Transform.scale(
        scale: 1.26,
        child: RotationTransition(
          turns: const AlwaysStoppedAnimation(-8 / 360),
          child: Container(
            padding: const EdgeInsets.only(left: 0, right: 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(55.0),
              child: Container(
                color: Colors.white,
                height: 300,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
