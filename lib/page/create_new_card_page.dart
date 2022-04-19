import 'package:flutter/material.dart';
import 'package:student_app/resources/colors.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/widgets/title_and_text_field.dart';
import 'package:student_app/widgets/title_text_bold.dart';

import '../resources/strings.dart';

class CreateNewCardPage extends StatelessWidget {
  final Function(String, String, String, String) createNewCard;

  CreateNewCardPage(this.createNewCard, {Key? key}) : super(key: key);

  final TextEditingController? cardNumberController = TextEditingController();
  final TextEditingController? cardHolderController = TextEditingController();
  final TextEditingController? expirationDateController =
      TextEditingController();
  final TextEditingController? cvcController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.chevron_left,
            size: paymentPageBackButtonIconSize,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: marginMedium),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleAndTextFieldView(
                cardNumbarText,
                cardNumberController,
                isLengthLimit: true,
              ),
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
              InkWell(
                onTap: () {
                  createNewCard(
                      cardHolderController!.text,
                      cardNumberController!.text,
                      expirationDateController!.text,
                      cvcController!.text);
                  Navigator.pop(context);
                },
                child: const CreateNewCard(),
              ),
              const SizedBox(
                height: marginMedium1X,
              ),
              const SizedBox(
                height: marginMedium1X,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExpirationDateAndCVC extends StatelessWidget {
  final TextEditingController? textControllerExpireDate;
  final TextEditingController? textEditingControllerCVC;
  const ExpirationDateAndCVC(
      this.textControllerExpireDate, this.textEditingControllerCVC,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child:
              TitleAndTextFieldView(expirationDate, textControllerExpireDate!),
        ),
        const SizedBox(width: marginMedium1X),
        Flexible(
          child: TitleAndTextFieldView(cVcText, textEditingControllerCVC!),
        ),
      ],
    );
  }
}

class CreateNewCard extends StatelessWidget {
  const CreateNewCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(
          Icons.create,
          color: addIconInPaymentCardColor,
          size: addIconInPaymentCard,
        ),
        SizedBox(
          width: marginSmall,
        ),
        TitleTextBold(createNewCard,
            textColor: addIconInPaymentCardColor, textSize: textRegular1X),
      ],
    );
  }
}
