import 'package:flutter/material.dart';
import 'package:student_app/resources/colors.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/resources/strings.dart';
import 'package:student_app/widgets/combo_set_view.dart';
import 'package:student_app/widgets/confirm_button_view.dart';
import 'package:student_app/widgets/payment_method_title.dart';
import 'package:student_app/widgets/title_text.dart';
import 'package:student_app/widgets/title_text_bold.dart';

class PaymentMethodPage extends StatelessWidget {
  const PaymentMethodPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: marginMedium,
          right: marginMedium,
          top: marginMedium2X,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ChevronBackButtonView(),
              const SizedBox(
                height: marginMedium,
              ),
              const ComboSetView(comboSetMText, "15\$",
                  "Combo size M 22oz.Coke(XI) and medium popcorn (X1)", 0),
              const SizedBox(
                height: marginMedium1X,
              ),
              const ComboSetView(comboSetLText, "18\$",
                  "Combo size M 32oz.Coke(XI) and medium popcorn (X1)", 0),
              const SizedBox(
                height: marginMedium1X,
              ),
              const ComboSetView(comboFor2Text, "20\$",
                  "Combo size 2 32oz.Coke(X2) and medium popcorn (X1)", 1),
              const SizedBox(
                height: marginMediumX,
              ),
              const EnterPromoCodeView(),
              const SizedBox(
                height: marginXSmall,
              ),
              const GetPromoCodeView(),
              const SizedBox(
                height: marginMedium,
              ),
              const SubTotalView(),
              const SizedBox(
                height: marginMedium1X,
              ),
              const TitleTextBold(paymentMethodText,
                  textColor: Colors.black, textSize: textRegular3X),
              const SizedBox(
                height: marginMedium,
              ),
              const PaymentMethodTitle(
                creditCardText,
                visaMasterJCBText,
                Icon(
                  Icons.card_membership,
                  color: paymentCardIconColor,
                ),
              ),
              const SizedBox(
                height: marginSmall,
              ),
              const PaymentMethodTitle(
                internetBankingATMText,
                visaMasterJCBText,
                Icon(
                  Icons.credit_card,
                  color: paymentCardIconColor,
                ),
              ),
              const SizedBox(
                height: marginSmall,
              ),
              const PaymentMethodTitle(
                eWalletText,
                payPalText,
                Icon(
                  Icons.login_outlined,
                  color: paymentCardIconColor,
                ),
              ),
              const SizedBox(
                height: marginMedium1X,
              ),
              ConfirmButtonView(
                "Pay \$40.00",
                () {},
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
}

class SubTotalView extends StatelessWidget {
  const SubTotalView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        TitleTextBold(
          subTotalText,
          textColor: subTotalColor,
          textSize: textRegular2X,
        ),
        TitleTextBold(
          "40\$",
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

class ChevronBackButtonView extends StatelessWidget {
  const ChevronBackButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.chevron_left,
      size: paymentPageBackButtonIconSize,
      color: Colors.black,
    );
  }
}
