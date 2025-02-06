import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BackgrounScreenWidget extends StatelessWidget {
  double height;
  BackgrounScreenWidget({super.key, this.height = 370});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(0),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/screen_bg.png'),
                  fit: BoxFit.fill)),
          child: SizedBox(
            height: height,
            width: MediaQuery.of(context).size.width,
          ),
        )
      ],
    );
  }
}
