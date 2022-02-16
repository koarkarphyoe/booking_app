import 'package:flutter/material.dart';
import 'package:student_app/data/model/data_models_impl.dart';
import 'package:student_app/data/vos/payment_method_vo.dart';
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

class PaymentMethodPage extends StatefulWidget {
  final selectedSeatPrice;
  final selectedSeatName;
  final movieDetails;
  final time;
  final yMd;
  final cinemaId;
  const PaymentMethodPage(this.selectedSeatName, this.selectedSeatPrice,
      this.movieDetails, this.time, this.yMd, this.cinemaId,
      {Key? key})
      : super(key: key);

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  DataModelsImpl mDataModel = DataModelsImpl();

  List<SnackVO>? snackList;
  List<SnackVO>? selectedSnackList = [];
  List<PaymentMethodVO>? paymentMethodList;
  double? subtotal;

  @override
  void initState() {
    super.initState();
    subtotal = widget.selectedSeatPrice;
    mDataModel.getSnack()?.then((value) {
      setState(() {
        snackList = value;
      });
    });

    mDataModel.getPaymentList()?.then((value) {
      setState(() {
        paymentMethodList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              (snackList != null)
                  ? Column(
                      children: snackList!
                          .map((e) => ComboSetView(e, (snackId, signName) {
                                    setState(() {
                                      if (e.id == snackId) {
                                        if (signName == "+") {
                                          e.quantity = e.quantity! + 1;
                                          // subtotal is very important
                                          subtotal =
                                              (subtotal! + e.price!.toDouble());
                                          selectedSnackList?.add(e);
                                          print(selectedSnackList!
                                              .map((e) => {e.id, e.quantity})
                                              .toList());
                                        } else if (signName == "-" &&
                                            e.quantity! > 0) {
                                          e.quantity = e.quantity! - 1;
                                          subtotal =
                                              (subtotal! - e.price!.toDouble());
                                          // selectedSnackList?.removeWhere((e)=>e.id==snackId);
                                          selectedSnackList?.remove(e);
                                          print(selectedSnackList!
                                              .map((e) => {e.id, e.quantity})
                                              .toString());
                                        } else if (e.quantity == 0) {
                                          e.quantity = 0;
                                        }
                                      }
                                    });
                                  })
                              //Method 1 for Snack Choose
                              // (e) => ComboSetView(
                              //     e,
                              //     (snackId) => _onTapPlus(snackId),
                              //     (snackId) => _onTapMinus(snackId)),
                              )
                          .toList(),
                    )
                  : const Center(child: CircularProgressIndicator()),

              // const ComboSetView(comboSetMText, "15\$",
              //     "Combo size M 22oz.Coke(XI) and medium popcorn (X1)", 0),
              // const SizedBox(
              //   height: marginMedium1X,
              // ),
              // const ComboSetView(comboSetLText, "18\$",
              //     "Combo size M 32oz.Coke(XI) and medium popcorn (X1)", 0),
              // const SizedBox(
              //   height: marginMedium1X,
              // ),
              // const ComboSetView(comboFor2Text, "20\$",
              //     "Combo size 2 32oz.Coke(X2) and medium popcorn (X1)", 1),

              const EnterPromoCodeView(),
              const SizedBox(
                height: marginXSmall,
              ),
              const GetPromoCodeView(),
              const SizedBox(
                height: marginMedium,
              ),
              SubTotalView(subtotal.toString()),
              const SizedBox(
                height: marginMedium1X,
              ),
              const TitleTextBold(paymentMethodText,
                  textColor: Colors.black, textSize: textRegular3X),
              const SizedBox(
                height: marginMedium,
              ),
              (paymentMethodList != null)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: paymentMethodList!
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
                  : const Center(child: CircularProgressIndicator()),
              // const PaymentMethodTitle(
              //   creditCardText,
              //   visaMasterJCBText,
              //   Icon(
              //     Icons.card_membership,
              //     color: paymentCardIconColor,
              //   ),
              // ),
              // const SizedBox(
              //   height: marginSmall,
              // ),
              // const PaymentMethodTitle(
              //   internetBankingATMText,
              //   visaMasterJCBText,
              //   Icon(
              //     Icons.credit_card,
              //     color: paymentCardIconColor,
              //   ),
              // ),
              // const SizedBox(
              //   height: marginSmall,
              // ),
              // const PaymentMethodTitle(
              //   eWalletText,
              //   payPalText,
              //   Icon(
              //     Icons.login_outlined,
              //     color: paymentCardIconColor,
              //   ),
              // ),
              const SizedBox(
                height: marginMedium1X,
              ),
              ConfirmButtonView(
                "Pay \$$subtotal",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentCardPage(
                          subtotal,
                          widget.movieDetails,
                          widget.time,
                          widget.yMd,
                          widget.cinemaId,
                          widget.selectedSeatName),
                    ),
                  );
                },
                buttonBackgroundColor: primaryColor,
                isGhostButton: true,
              ),
              const SizedBox(
                height: marginSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

//Method 1 for Snack choose
//   _onTapPlus(int? snackId) {
//     setState(() {
//       snackList?.map((e) {
//         if (e.id == snackId) {
//           e.quantity = e.quantity! + 1;
//           e.totalCharges = ((e.quantity)! * (e.price)!.toDouble());
//           subtotal = (subtotal! + e.price!.toDouble());
//         }
//       }).toList();
//     });
//   }
//   _onTapMinus(int? snackId) {
//     setState(() {
//       snackList?.map((e) {
//         if (e.id == snackId) {
//           e.quantity = e.quantity! - 1;
//           e.totalCharges = ((e.quantity)! * (e.price)!.toDouble());
//           subtotal = (subtotal! - e.price!.toDouble());
//         }
//       }).toList();
//     });
//   }
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
