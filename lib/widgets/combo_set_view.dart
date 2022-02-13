import 'package:flutter/material.dart';
import 'package:student_app/data/vos/snack_vo.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/resources/strings.dart';
import 'package:student_app/widgets/title_text.dart';

class ComboSetView extends StatelessWidget {
  const ComboSetView(
    this.snackTitle,
    this.onTapSign, {
    Key? key,
  }) : super(key: key);
  final SnackVO? snackTitle;
  final Function(int? snackId, String? signName) onTapSign;
  // final Function(int? snackId) onTapPlus; for method 1
  // final Function(int? snackid) onTapMinus; for method 1

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            TitleText(
              snackTitle!.name.toString(),
              textColor: Colors.black,
              textSize: textRegular1X,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: marginMedium1XX),
              child: TitleText(
                "${snackTitle!.price.toString()}\$",
                textColor: Colors.black,
                textSize: textRegular1X,
              ),
            ),
          ],
        ),
        const SizedBox(height: marginSmall),
        Row(
          children: [
            Expanded(
              child: TitleText(
                snackTitle!.description.toString(),
                textColor: Colors.black38,
                textSize: textRegular,
              ),
            ),
            Row(
              children: [
                Container(
                  height: comboSetButtonHeight,
                  width: comboSetButtonHeight,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(comboSetButtonCirclularRadius),
                      bottomLeft:
                          Radius.circular(comboSetButtonCirclularRadius),
                    ),
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        // onTapMinus(snackTitle!.id);for method 1
                        onTapSign(snackTitle!.id,minusSignInComboSet);
                      },
                      child: const TitleText(
                        minusSignInComboSet,
                        textColor: Colors.black,
                        textSize: textRegular5X,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: comboSetButtonHeight,
                  width: comboSetButtonHeight,
                  decoration: const BoxDecoration(
                    border: Border(
                        left: BorderSide(color: Colors.transparent),
                        right: BorderSide(color: Colors.transparent),
                        top: BorderSide(color: Colors.black38, width: 1),
                        bottom: BorderSide(color: Colors.black38, width: 1)),
                  ),
                  child: Center(
                    child: TitleText(
                      snackTitle!.quantity.toString(),
                      textColor: (snackTitle?.quantity == 0)
                          ? Colors.black38
                          : Colors.black,
                      textSize: textRegular2X,
                    ),
                  ),
                ),
                Container(
                  height: comboSetButtonHeight,
                  width: comboSetButtonHeight,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(comboSetButtonCirclularRadius),
                      bottomRight:
                          Radius.circular(comboSetButtonCirclularRadius),
                    ),
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        onTapSign(snackTitle!.id,plusSignInComboSet);
                        // onTapPlus(snackTitle!.id);for method 1
                      },
                      child: const TitleText(
                        plusSignInComboSet,
                        textColor: Colors.black,
                        textSize: textRegular2X,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: marginMedium1X,
        ),
      ],
    );
  }
}
