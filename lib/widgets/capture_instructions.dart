import 'package:flutter/material.dart';

///
/// Created by Auro on 24/09/23 at 3:23 AM
///

class CaptureInstructions extends StatelessWidget {
  const CaptureInstructions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Place your Head here",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
            ),
          ),
        ),
        const Spacer(),
        Container(
          height: 100,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          "Place your ID here",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
