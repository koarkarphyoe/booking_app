import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:student_app/data/vos/card_vo.dart';
import 'package:student_app/data/vos/voucher_vo.dart';
import 'package:student_app/network/requests/checkout_request.dart';
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
  final movieDetails;
  final time;
  final yMd;
  final cinemaId;
  final selectedSeatName;
  final finalSelectedSnackListResult;

  const PaymentCardPage(this.subtotal, this.movieDetails, this.time, this.yMd,
      this.cinemaId, this.selectedSeatName, this.finalSelectedSnackListResult,
      {Key? key})
      : super(key: key);

  @override
  State<PaymentCardPage> createState() => _PaymentCardPageState();
}

class _PaymentCardPageState extends State<PaymentCardPage> {
  DataModelsImpl mDataModel = DataModelsImpl();

  List<CardVO>? cardList;
  CardVO? selectedCard;

  CheckoutRequest checkoutRequest = CheckoutRequest();

  String? encodedJson;

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
                              // print(selectedCard!.id.toString());
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
                  setState(() {
                    // String? bookingDateAndTime = "${widget.time} ${widget.yMd}";
                    checkoutRequest.cardId = selectedCard?.id;
                    checkoutRequest.bookingDate = widget.time;
                    checkoutRequest.cinemaDayTimeslotId = widget.cinemaId;
                    checkoutRequest.movieId = widget.movieDetails.id;
                    checkoutRequest.seatNumber =
                        widget.selectedSeatName.toString();
                    checkoutRequest.snacks =
                        widget.finalSelectedSnackListResult;

                     encodedJson = jsonEncode(checkoutRequest);

                    print(encodedJson);
                  });
                  // print(selectedCard?.id.toString());
                  // print(widget.subtotal.toString());
                  // print(widget.movieDetails.id.toString());
                  // print(widget.time.toString());
                  // print(widget.yMd.toString());
                  // print(widget.cinemaId.toString());
                  // print(widget.selectedSeatName.toString());
                  // print(widget.finalSelectedSnackListResult.toString());
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
