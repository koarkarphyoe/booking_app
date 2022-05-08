import 'package:flutter/material.dart';
import 'package:student_app/resources/dimens.dart';

class TitleTextBold extends StatelessWidget {
  const TitleTextBold(this.welcomeText,
      {this.textColor = Colors.white, this.textSize = textRegular7X, Key? key})
      : super(key: key);
  final String welcomeText;
  final Color textColor;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      welcomeText,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w600,
        fontSize: textSize,
      ),
    );
  }
}
