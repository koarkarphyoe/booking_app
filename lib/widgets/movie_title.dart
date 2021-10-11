import 'package:flutter/material.dart';
import 'package:student_app/resources/dimens.dart';

class MovieTitleText extends StatelessWidget {
  final String welcomeText;
  final Color textColor;
  final double textSize;
 const MovieTitleText(this.welcomeText,{this.textColor=Colors.black,this.textSize=14.0});

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
