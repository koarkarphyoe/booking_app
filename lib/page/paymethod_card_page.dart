import 'package:flutter/material.dart';
import 'package:student_app/resources/colors.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/resources/strings.dart';
import 'package:student_app/widgets/confirm_button_view.dart';
import 'package:student_app/widgets/payment_card_view.dart';
import 'package:student_app/widgets/title_and_text_field.dart';
import 'package:student_app/widgets/title_text.dart';
import 'package:student_app/widgets/title_text_bold.dart';

class PaymentCardPage extends StatelessWidget {
  const PaymentCardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(
          Icons.chevron_left,
          size: 40,
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: marginMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  TitleText(
                    paymentAmount,
                    textColor: paymentCardIconColor,
                    textSize: textRegular,
                  ),
                  SizedBox(height: marginXSmall),
                  TitleTextBold("\$926.21",
                      textColor: Colors.black, textSize: textRegular4X),
                  SizedBox(height: marginMedium1X),
                ],
              ),
            ),
            const PaymentCardView(),
            const SizedBox(
              height: marginMedium1X,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: marginMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleAndTextFieldView(cardNumbarText),
                  const SizedBox(
                    height: marginMedium1X,
                  ),
                  const TitleAndTextFieldView(cardHolder),
                  const SizedBox(
                    height: marginMedium1X,
                  ),
                  const ExpirationDateAndCVC(),
                  const SizedBox(
                    height: marginMedium1X,
                  ),
                  const AddNewCard(),
                  const SizedBox(
                    height: marginMedium1X,
                  ),
                  ConfirmButtonView(
                    comfirmBtnText,
                    () {},
                    isGhostButton: true,
                    buttonBackgroundColor: primaryColor,
                  ),
                  const SizedBox(
                    height: marginMedium1X,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddNewCard extends StatelessWidget {
  const AddNewCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(
          Icons.add_circle,
          color: addIconInPaymentCardColor,
          size: addIconInPaymentCard,
        ),
        SizedBox(
          width: marginSmall,
        ),
        TitleTextBold("Add new card",
            textColor: addIconInPaymentCardColor, textSize: textRegular1X),
      ],
    );
  }
}

class ExpirationDateAndCVC extends StatelessWidget {
  const ExpirationDateAndCVC({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: TitleAndTextFieldView(expirationDate),
        ),
        SizedBox(width: marginMedium1X),
        Flexible(
          child: TitleAndTextFieldView(cVcText),
        ),
      ],
    );
  }
}
