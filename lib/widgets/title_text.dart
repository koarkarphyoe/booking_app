import 'package:flutter/material.dart';
import 'package:student_app/resources/dimens.dart';

class TitleText extends StatelessWidget {
  final String greetingText;
  final Color textColor;
  final double textSize;
  const TitleText(this.greetingText,
      {this.textColor = Colors.white, this.textSize = textRegular1X});

  @override
  Widget build(BuildContext context) {
    return Text(
      greetingText,
      style: TextStyle(
        color: textColor,
        fontSize: textSize,
      ),
    );
  }
}
