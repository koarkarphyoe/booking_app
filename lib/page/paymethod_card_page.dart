import 'package:flutter/material.dart';
import 'package:student_app/data/model/data_models_impl.dart';
import 'package:student_app/resources/colors.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/resources/strings.dart';
import 'package:student_app/widgets/confirm_button_view.dart';
import 'package:student_app/widgets/payment_card_view.dart';
import 'package:student_app/widgets/title_and_text_field.dart';
import 'package:student_app/widgets/title_text.dart';
import 'package:student_app/widgets/title_text_bold.dart';

class PaymentCardPage extends StatelessWidget {
  final subtotal;
  PaymentCardPage(this.subtotal, {Key? key}) : super(key: key);

  final TextEditingController textController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardHolderController = TextEditingController();
  final TextEditingController expirationDateController =
      TextEditingController();
  final TextEditingController cvcController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.chevron_left,
            size: 40,
            color: Colors.black,
          ),
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
                children: [
                  const TitleText(
                    paymentAmount,
                    textColor: paymentCardIconColor,
                    textSize: textRegular,
                  ),
                  const SizedBox(height: marginXSmall),
                  TitleTextBold("\$${subtotal.toString()}",
                      textColor: Colors.black, textSize: textRegular4X),
                  const SizedBox(height: marginMedium1X),
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
                  TitleAndTextFieldView(cardNumbarText, cardNumberController),
                  const SizedBox(
                    height: marginMedium1X,
                  ),
                  TitleAndTextFieldView(cardHolder, cardHolderController),
                  const SizedBox(
                    height: marginMedium1X,
                  ),
                  ExpirationDateAndCVC(expirationDateController, cvcController),
                  const SizedBox(
                    height: marginMedium1X,
                  ),
                  GestureDetector(
                    onTap: () {
                      _addNewCard(
                          cardHolderController.text,
                          cardNumberController.text,
                          expirationDateController.text,
                          cvcController.text);
                    },
                    child: const AddNewCard(),
                  ),
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

  void _addNewCard(String text, String text2, String text3, String text4) {
    DataModelsImpl mModel = DataModelsImpl();
    mModel.registerCardList(text, text2, text3, text4);
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
  final TextEditingController textControllerExpireDate;
  final TextEditingController textEditingControllerCVC;
  const ExpirationDateAndCVC(
      this.textControllerExpireDate, this.textEditingControllerCVC);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child:
              TitleAndTextFieldView(expirationDate, textControllerExpireDate),
        ),
        const SizedBox(width: marginMedium1X),
        Flexible(
          child: TitleAndTextFieldView(cVcText, textEditingControllerCVC),
        ),
      ],
    );
  }
}
