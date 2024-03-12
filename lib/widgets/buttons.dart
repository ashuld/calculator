// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class CalculatorButtons extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String buttonText;
  final buttonTapped;

  const CalculatorButtons(
      {super.key,
      required this.color,
      required this.textColor,
      required this.buttonText,
      this.buttonTapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black, width: 1.5)),
              child: Center(
                  child: Text(
                buttonText,
                style: TextStyle(color: textColor, fontSize: 20),
              )),
            )),
      ),
    );
  }
}
