import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app/bloc/cards_bloc.dart';
import 'package:student_app/page/create_new_card_page.dart';
import 'package:student_app/page/ticket_view_page.dart';
import 'package:student_app/resources/colors.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/resources/strings.dart';
import 'package:student_app/widgets/confirm_button_view.dart';
import 'package:student_app/widgets/payment_card_view.dart';
import 'package:student_app/widgets/title_text.dart';
import 'package:student_app/widgets/title_text_bold.dart';

class PaymentCardPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: CardsBloc(),
        child: Scaffold(
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
                      TitleTextBold("\$${subtotal.toString()}",
                          textColor: Colors.black, textSize: textRegular4X),
                      const SizedBox(height: marginMedium1X),
                    ],
                  ),
                ),
                Selector<CardsBloc, CardsBloc>(
                    shouldRebuild: (previous, next) => true,
                    selector: (BuildContext context, bloc) => bloc,
                    builder: (BuildContext context, bloc, Widget? child) {
                      return (bloc.cardList != null)
                          ? CarouselSlider(
                              items: bloc.cardList
                                  ?.map(
                                    (e) => CardView(e, (cardId) {
                                      if (e.id == cardId) {
                                        bloc.selectedCard = e;
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
                          : const Center(child: CircularProgressIndicator());
                    }),
                const SizedBox(
                  height: paymentPageBackButtonIconSize,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateNewCardPage(),
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
                  child: Selector<CardsBloc, CardsBloc>(
                    selector: (BuildContext context, bloc) => bloc,
                    builder: (BuildContext context, bloc, Widget? child) {
                      return ConfirmButtonView(
                        comfirmBtnText,
                        () {
                          bloc.onTapCreateCheckOutVOForApiRequest(
                              time,
                              timeSlotsId,
                              movieDetails.id,
                              selectedSeatName,
                              finalSelectedSnackListResult);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                    builder: (context) =>
                                        TicketViewPage(bloc.checkoutRequest)));
                        
                        },
                        isGhostButton: true,
                        buttonBackgroundColor: primaryColor,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
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
        TitleTextBold(addNewCard,
            textColor: addIconInPaymentCardColor, textSize: textRegular1X),
      ],
    );
  }
}
