import 'package:flutter/material.dart';
import 'package:student_app/resources/colors.dart';
import 'package:student_app/resources/dimens.dart';

class TitleAndTextFieldView extends StatelessWidget {
  final String textTitle;
  const TitleAndTextFieldView(this.textTitle);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textTitle,
          style: const TextStyle(
              color: paymentCardIconColor, fontSize: textRegular1X),
        ),
        const TextField(
            decoration: InputDecoration(
              hintStyle: TextStyle(),
            ),
            style: TextStyle(color: Colors.black)),
      ],
    );
  }
}
