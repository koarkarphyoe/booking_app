import 'package:flutter/material.dart';
import 'package:student_app/resources/colors.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/widgets/confirm_button_view.dart';
import 'package:student_app/widgets/title_and_text_field.dart';
import 'package:student_app/widgets/title_text_bold.dart';

import '../data/model/data_models_impl.dart';
import '../resources/strings.dart';

class CreateNewCardPage extends StatefulWidget {
  const CreateNewCardPage({Key? key}) : super(key: key);

  @override
  State<CreateNewCardPage> createState() => _CreateNewCardPageState();
}

class _CreateNewCardPageState extends State<CreateNewCardPage> {
  final TextEditingController? cardNumberController = TextEditingController();
  final TextEditingController? cardHolderController = TextEditingController();
  final TextEditingController? expirationDateController =
      TextEditingController();
  final TextEditingController? cvcController = TextEditingController();
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
                  setState(() {
                    if (cardHolderController!.text.isEmpty &&
                        cardNumberController!.text.isEmpty &&
                        expirationDateController!.text.isEmpty &&
                        cvcController!.text.isEmpty) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              title: Text("Sorry!"),
                              content:
                                  Text("Please check and fill card information!"),
                            );
                          });
                    } else {
                      _createNewCard(
                          cardHolderController!.text,
                          cardNumberController!.text,
                          expirationDateController!.text,
                          cvcController!.text);
                    }
                  });
                },
                child: const CreateNewCard(),
              ),
              const SizedBox(
                height: marginMedium1X,
              ),
              ConfirmButtonView(
                chooseYourCard,
                () {
                  Navigator.pop(context);
                },
                isGhostButton: true,
                buttonBackgroundColor: primaryColor,
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

  void _createNewCard(String text, String text2, String text3, String text4) {
    DataModelsImpl mModel = DataModelsImpl();
    mModel.registerCardList(text, text2, text3, text4);
  }
}

class ExpirationDateAndCVC extends StatelessWidget {
  final TextEditingController? textControllerExpireDate;
  final TextEditingController? textEditingControllerCVC;
  const ExpirationDateAndCVC(
      this.textControllerExpireDate, this.textEditingControllerCVC);

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
