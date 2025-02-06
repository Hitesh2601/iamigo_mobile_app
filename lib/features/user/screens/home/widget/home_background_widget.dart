import 'package:flutter/material.dart';

class HomeBackgroundWidget extends StatelessWidget {
  const HomeBackgroundWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg.png'), fit: BoxFit.fill)),
        )
      ],
    );
  }
}
