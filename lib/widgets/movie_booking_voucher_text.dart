import 'package:flutter/material.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/widgets/title_text.dart';

class MovieBookingVoucherView extends StatelessWidget {
  const MovieBookingVoucherView(
    this.titleText,
    this.valueText, {
    Key? key,
  }) : super(key: key);
  final String titleText;
  final String valueText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TitleText(
          titleText,
          textColor: Colors.black38,
          textSize: textRegular,
        ),
        const Spacer(),
        // ignore: prefer_const_constructors
        TitleText(
          valueText,
          textColor: Colors.black,
          textSize: textRegular,
        )
      ],
    );
  }
}
