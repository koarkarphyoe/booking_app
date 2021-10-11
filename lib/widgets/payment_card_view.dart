import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:student_app/resources/colors.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/resources/strings.dart';
import 'package:student_app/widgets/title_text.dart';
import 'package:student_app/widgets/title_text_bold.dart';

class PaymentCardView extends StatelessWidget {
  const PaymentCardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(carouselBorderCircularRadius),
            gradient: const LinearGradient(
                colors: [paymentCardTopLeftColor, paymentCardButtonRightColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft),
          ),
          child: Padding(
            padding: const EdgeInsets.all(marginMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                CardName(),
                SizedBox(
                  height: marginMedium1XX,
                ),
                CardNumber(),
                Spacer(),
                CardHolderAndExpireText(),
                NameAndDateText(),
              ],
            ),
          ),
        ),
      ],
      options: CarouselOptions(
        height: carouselOptionHeight,
        enlargeCenterPage: true,
      ),
    );
  }
}

class NameAndDateText extends StatelessWidget {
  const NameAndDateText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        TitleText(
          "Lily johnson",
          textSize: textRegular,
        ),
        Spacer(),
        TitleText(
          "08/21",
          textSize: textRegular,
        )
      ],
    );
  }
}

class CardHolderAndExpireText extends StatelessWidget {
  const CardHolderAndExpireText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        TitleText(
          cardHolderLarge,
          textColor: Colors.white54,
          textSize: textRegular,
        ),
        Spacer(),
        TitleText(
          expireText,
          textColor: Colors.white54,
          textSize: textRegular,
        )
      ],
    );
  }
}

class CardNumber extends StatelessWidget {
  const CardNumber({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: TitleText(
        "****     ****     ****     8014",
        textSize: textRegular3X,
      ),
    );
  }
}

class CardName extends StatelessWidget {
  const CardName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        TitleTextBold("VISA", textSize: textRegular2X),
        Spacer(),
        Icon(
          Icons.more_horiz,
          color: Colors.white,
          size: 30,
        ),
      ],
    );
  }
}
