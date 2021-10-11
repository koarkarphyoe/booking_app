import 'package:flutter/material.dart';
import 'package:student_app/resources/colors.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/widgets/title_text.dart';

class PaymentMethodTitle extends StatelessWidget {
  const PaymentMethodTitle(this.titleText, this.cardNameText, this.cardIcon,
      {Key? key})
      : super(key: key);
  final String titleText;
  final String cardNameText;
  final Icon cardIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // ignore: prefer_const_constructors
        cardIcon,
        const SizedBox(
          width: marginMedium1X,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleText(
              titleText,
              textColor: Colors.black,
              textSize: textRegular1X,
            ),
            TitleText(
              cardNameText,
              textColor: paymentCardIconColor,
              textSize: textRegular,
            )
          ],
        ),
      ],
    );
  }
}
