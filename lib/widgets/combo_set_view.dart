import 'package:flutter/material.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/resources/strings.dart';
import 'package:student_app/widgets/title_text.dart';

class ComboSetView extends StatelessWidget {
  const ComboSetView(
    this.comboTitle,
    this.comboValue,
    this.comboType,
    this.comboCounterValue, {
    Key? key,
  }) : super(key: key);
  final String comboTitle;
  final String comboValue;
  final String comboType;
  final int comboCounterValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            TitleText(
              comboTitle,
              textColor: Colors.black,
              textSize: textRegular1X,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: marginMedium1XX),
              child: TitleText(
                comboValue,
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
                comboType,
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
                  child: const Center(
                    child: TitleText(
                      minusSignInComboSet,
                      textColor: Colors.black,
                      textSize: textRegular5X,
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
                      comboCounterValue.toString(),
                      textColor: Colors.black38,
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
                  child: const Center(
                    child: TitleText(
                      plusSignInComboSet,
                      textColor: Colors.black,
                      textSize: textRegular2X,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
