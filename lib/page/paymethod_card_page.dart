
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:student_app/data/vos/card_vo.dart';
import 'package:student_app/data/vos/movie_vo.dart';
import 'package:student_app/data/vos/voucher_vo.dart';
import 'package:student_app/general_functions.dart';
import 'package:student_app/network/requests/checkout_request.dart';
import 'package:student_app/network/response/check_out_response.dart';
import 'package:student_app/page/create_new_card_page.dart';
import 'package:student_app/page/ticket_view_page.dart';
import 'package:student_app/resources/colors.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/resources/strings.dart';
import 'package:student_app/widgets/confirm_button_view.dart';
import 'package:student_app/widgets/payment_card_view.dart';
import 'package:student_app/widgets/title_text.dart';
import 'package:student_app/widgets/title_text_bold.dart';
import '../data/model/data_models_impl.dart';

class PaymentCardPage extends StatefulWidget {
  final dynamic subtotal;
  final dynamic movieDetails;
  final dynamic time;
  final dynamic yMd;
  final dynamic cinemaId;
  final dynamic selectedSeatName;
  final dynamic finalSelectedSnackListResult;
  final dynamic timeSlotsId;

  const PaymentCardPage(
      this.subtotal,
      this.movieDetails,
      this.time,
      this.yMd,
      this.cinemaId,
      this.selectedSeatName,
      this.finalSelectedSnackListResult,
      this.timeSlotsId,
      {Key? key})
      : super(key: key);

  @override
  State<PaymentCardPage> createState() => _PaymentCardPageState();
}

class _PaymentCardPageState extends State<PaymentCardPage> {
  DataModelsImpl mDataModel = DataModelsImpl();
  CheckoutRequest checkoutRequest = CheckoutRequest();

  List<CardVO>? cardList = [];
  CardVO? selectedCard;
  CheckOutResponse? checkOutResponse;
  VoucherVO? voucher;
  MovieVO? mMovie;
  int? movieId;

  //Change the require variable to Json for CheckOut api request
  // CheckoutRequest checkoutRequest = CheckoutRequest(); // changed to Modal class
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
    _createCheckOutVOForApiRequest();
  }

  void _createNewCard(String text, String text2, String text3, String text4) {
    DataModelsImpl mModel = DataModelsImpl();
    mModel.registerPaymentCard(text, text2, text3, text4)?.then((value) {
      setState(() {
        cardList = value;
      });
    });
  }

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
                      builder: (context) => CreateNewCardPage(_createNewCard),
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
                    _createCheckOutVOForApiRequest();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TicketViewPage(checkoutRequest)));
                  });
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

  void _createCheckOutVOForApiRequest() {
    checkoutRequest.cardId = selectedCard?.id;
    checkoutRequest.bookingDate = Functions().formatDate(widget.time);
    checkoutRequest.cinemaDayTimeslotId = widget.timeSlotsId;
    checkoutRequest.movieId = widget.movieDetails.id;
    checkoutRequest.seatNumber = widget.selectedSeatName.toString();
    checkoutRequest.snacks = widget.finalSelectedSnackListResult;
    // This step is to confirm Json object is working or not in Postman
    // encodedJson = jsonEncode(checkoutRequest);
    // print(encodedJson);
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
