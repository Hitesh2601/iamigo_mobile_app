import 'package:flutter/material.dart';

class NoDataFountWidget extends StatelessWidget {
  const NoDataFountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/dnf.jpg'),
          const SizedBox(
            height: 15,
          ),
          const Center(
            child: Text(
              'No Records Found',
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
