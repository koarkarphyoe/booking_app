import 'package:flutter/material.dart';

class MovieTitleText extends StatelessWidget {
  final String welcomeText;
  final Color textColor;
  final double textSize;
  const MovieTitleText(this.welcomeText,
      {this.textColor = Colors.black, this.textSize = 14.0, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      welcomeText,
      style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: textSize),
    );
  }
}
