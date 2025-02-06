import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SomthingWentWrongWidget extends StatelessWidget {
  const SomthingWentWrongWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            FontAwesomeIcons.circleExclamation,
            color: Colors.grey,
            size: 120,
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              'Oops! Something Went Wriong. ',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
