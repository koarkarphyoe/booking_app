// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:student_app/resources/dimens.dart';

class ConfirmButtonView extends StatelessWidget {
  final String buttonText;
  final Color textColor;
  final bool isGhostButton;
  final Color buttonBackgroundColor;
  final double textSize;
  final Color borderColor;
  final Function onTapButton;
  const ConfirmButtonView(this.buttonText, this.onTapButton,
      {this.textColor = Colors.white,
      this.buttonBackgroundColor = Colors.transparent,
      this.textSize = textRegular3X,
      this.borderColor = Colors.white,
      this.isGhostButton = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapButton();
      },
      child: Container(
        alignment: Alignment.center,
        height: welcomeScreenGetStartedHeight,
        decoration: BoxDecoration(
          color: buttonBackgroundColor,
          borderRadius:
              BorderRadius.circular(welcomeScreenGetStartedHeightWidth),
          border:
              (isGhostButton) ? Border.all(color: borderColor, width: 1) : null,
        ),
        child: Text(
          buttonText,
          style: TextStyle(
              color: textColor,
              fontSize: textSize,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
