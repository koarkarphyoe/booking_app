import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:student_app/data/vos/card_vo.dart';
import 'package:student_app/data/vos/movie_details_vo.dart';
import 'package:student_app/page/create_new_card_page.dart';
import 'package:student_app/resources/colors.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/resources/strings.dart';
import 'package:student_app/widgets/confirm_button_view.dart';
import 'package:student_app/widgets/payment_card_view.dart';
import 'package:student_app/widgets/title_text.dart';
import 'package:student_app/widgets/title_text_bold.dart';

import '../data/model/data_models_impl.dart';

class PaymentCardPage extends StatefulWidget {
  final subtotal;
  const PaymentCardPage(this.subtotal, {Key? key}) : super(key: key);

  @override
  State<PaymentCardPage> createState() => _PaymentCardPageState();
}

class _PaymentCardPageState extends State<PaymentCardPage> {
  DataModelsImpl mDataModel = DataModelsImpl();

  List<CardVO>? cardList;
  CardVO? selectedCard;

  @override
  void initState() {
    super.initState();

    mDataModel.getUserInfoFromDatabase()?.then((value) {
      setState(() {
        cardList = value.cards;
        selectedCard = cardList?.first;
      });
    });
  }

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
                  TitleTextBold("\$${widget.subtotal.toString()}",
                      textColor: Colors.black, textSize: textRegular4X),
                  const SizedBox(height: marginMedium1X),
                ],
              ),
            ),
            (cardList != null)
                ? CarouselSlider(
                    items: cardList
                        ?.map(
                          (e) => CardView(e, (cardId) {
                            if (e.id == cardId) {
                              selectedCard = e;
                              print(selectedCard!.id.toString());
                            }
                          }),
                        )
                        .toList(),
                    options: CarouselOptions(
                      height: carouselOptionHeight,
                      enlargeCenterPage: true,
                    ),
                  )
                : const Center(child: CircularProgressIndicator()),
            const SizedBox(
              height: paymentPageBackButtonIconSize,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateNewCardPage(),
                    ));
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: marginMedium),
                child: AddNewCard(),
              ),
            ),
            const SizedBox(
              height: carouselOptionHeight,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: marginMedium),
              child: ConfirmButtonView(
                comfirmBtnText,
                () {
                  print(selectedCard?.id.toString());
                  print(widget.subtotal.toString());
                },
                isGhostButton: true,
                buttonBackgroundColor: primaryColor,
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
