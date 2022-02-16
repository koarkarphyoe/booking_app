import 'package:flutter/material.dart';
import 'package:student_app/data/vos/card_vo.dart';
import 'package:student_app/resources/colors.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/resources/strings.dart';
import 'package:student_app/widgets/title_text.dart';
import 'package:student_app/widgets/title_text_bold.dart';

class CardView extends StatelessWidget {
  final CardVO? card;
  final Function(int? cardId) selectedCard;
  const CardView(this.card, this.selectedCard, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        selectedCard(card!.id);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(carouselBorderCircularRadius),
          gradient: const LinearGradient(
              colors: [paymentCardTopLeftColor, paymentCardButtonRightColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft),
        ),
        child: Padding(
          padding: const EdgeInsets.all(marginSmall),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardName(card!.cardType.toString()),
              const SizedBox(
                height: marginMedium1XX,
              ),
              CardNumber(card!.cardNumber.toString()),
              const Spacer(),
              const CardHolderAndExpireText(),
              NameAndDateText(
                  card!.cardHolder.toString(), card!.expirationDate.toString()),
            ],
          ),
        ),
      ),
    );
  }
}

class NameAndDateText extends StatelessWidget {
  final String cardHolder;
  final String expireDate;
  const NameAndDateText(
    this.cardHolder,
    this.expireDate, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TitleText(
          cardHolder,
          textSize: textRegular,
        ),
        const Spacer(),
        TitleText(
          expireDate,
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
  final String cardNumber;
  const CardNumber(
    this.cardNumber, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TitleText(
        cardNumber,
        textSize: textRegular3X,
      ),
    );
  }
}

class CardName extends StatelessWidget {
  final String cardType;
  const CardName(
    this.cardType, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TitleTextBold(cardType, textSize: textRegular2X),
        const Spacer(),
        const Icon(
          Icons.more_horiz,
          color: Colors.white,
          size: 30,
        ),
      ],
    );
  }
}
