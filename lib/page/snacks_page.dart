import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app/bloc/snacks_bloc.dart';
import 'package:student_app/data/vos/snack_vo.dart';
import 'package:student_app/page/paymethod_card_page.dart';
import 'package:student_app/resources/colors.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/resources/strings.dart';
import 'package:student_app/widgets/combo_set_view.dart';
import 'package:student_app/widgets/confirm_button_view.dart';
import 'package:student_app/widgets/payment_method_title.dart';
import 'package:student_app/widgets/title_text.dart';
import 'package:student_app/widgets/title_text_bold.dart';

class SnacksPage extends StatelessWidget {
  final dynamic selectedSeatPrice;
  final dynamic selectedSeatName;
  final dynamic movieDetails;
  final dynamic time;
  final dynamic yMd;
  final dynamic cinemaId;
  final dynamic timeSlotsId;
  const SnacksPage(this.selectedSeatName, this.selectedSeatPrice,
      this.movieDetails, this.time, this.yMd, this.cinemaId, this.timeSlotsId,
      {Key? key})
      : super(key: key);

  get builder => null;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: SnacksBloc(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
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
          padding: const EdgeInsets.only(
            left: marginMedium,
            right: marginMedium,
            top: marginForChip,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Selector<SnacksBloc, List<SnackVO>?>(
                  selector: (BuildContext context, snackVO) =>
                      snackVO.snackList,
                  builder: (BuildContext context, snackList, Widget? child) {
                    return (snackList != null)
                        ? Column(
                            children: snackList
                                .map((e) => Selector<SnacksBloc, SnacksBloc>(
                                      shouldRebuild: (previous, next) => true,
                                      selector: (BuildContext context, bloc) =>
                                          bloc,
                                      builder: (BuildContext context, bloc,
                                          Widget? child) {
                                        return ComboSetView(e,
                                            (snackId, signName) {
                                          bloc.onTapSelectedSnackAndQty(
                                              e, snackId, signName);
                                        });
                                      },
                                    ))
                                .toList(),
                          )
                        : const Center(child: CircularProgressIndicator());
                  },
                ),
                const EnterPromoCodeView(),
                const SizedBox(
                  height: marginXSmall,
                ),
                const GetPromoCodeView(),
                const SizedBox(
                  height: marginMedium,
                ),
                Selector<SnacksBloc, double?>(
                  shouldRebuild: (previous, next) => true,
                  selector: (BuildContext context, subTotal) =>
                      subTotal.subtotal,
                  builder: (BuildContext context, subTotal, Widget? child) {
                    // print(subTotal.toString());
                    return SubTotalView("${selectedSeatPrice + subTotal}");
                  },
                ),
                const SizedBox(
                  height: marginMedium1X,
                ),
                const TitleTextBold(paymentMethodText,
                    textColor: Colors.black, textSize: textRegular3X),
                const SizedBox(
                  height: marginMedium,
                ),
                Selector<SnacksBloc, SnacksBloc>(
                  shouldRebuild: (previous, next) => true,
                  selector: (BuildContext context, bloc) => bloc,
                  builder: (BuildContext context, bloc, Widget? child) {
                    return (bloc.paymentMethodList != null)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: bloc.paymentMethodList!
                                .map(
                                  (e) => PaymentMethodTitle(
                                    e.name.toString(),
                                    e.description.toString(),
                                    const Icon(
                                      Icons.credit_card,
                                      color: paymentCardIconColor,
                                    ),
                                  ),
                                )
                                .toList(),
                          )
                        : const Center(child: CircularProgressIndicator());
                  },
                ),
                const SizedBox(
                  height: marginMedium1X,
                ),
                Consumer<SnacksBloc>(
                  builder: (BuildContext context, bloc, Widget? child) {
                    return ConfirmButtonView(
                      "Pay \$${bloc.subtotal! + selectedSeatPrice}",
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentCardPage(
                                bloc.subtotal! + selectedSeatPrice,
                                movieDetails,
                                time,
                                yMd,
                                cinemaId,
                                selectedSeatName,
                                bloc.finalSelectedSnackListResult,
                                timeSlotsId),
                          ),
                        );
                      },
                      buttonBackgroundColor: primaryColor,
                      isGhostButton: true,
                    );
                  },
                ),
                const SizedBox(
                  height: marginSmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SubTotalView extends StatelessWidget {
  final String totalAmount;
  const SubTotalView(
    this.totalAmount, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const TitleTextBold(
          subTotalText,
          textColor: subTotalColor,
          textSize: textRegular2X,
        ),
        TitleTextBold(
          "$totalAmount\$",
          textColor: subTotalColor,
          textSize: textRegular2X,
        ),
      ],
    );
  }
}

class GetPromoCodeView extends StatelessWidget {
  const GetPromoCodeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        TitleText(
          donotHavePromoCodeText,
          textColor: Colors.black38,
          textSize: textRegular,
        ),
        SizedBox(
          width: marginXSmall,
        ),
        TitleText(
          getItNowText,
          textColor: Colors.black,
          textSize: textRegular,
        ),
      ],
    );
  }
}

class EnterPromoCodeView extends StatelessWidget {
  const EnterPromoCodeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        hintText: enterPromoCodeText,
        hintStyle: TextStyle(
            fontSize: textRegular1X,
            color: Colors.black38,
            fontStyle: FontStyle.italic),
      ),
    );
  }
}
