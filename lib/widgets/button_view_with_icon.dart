import 'package:flutter/material.dart';
import 'package:student_app/resources/dimens.dart';

class ButtonViewWithIcon extends StatelessWidget {
  final String textTitle;
  final Image logoImage;
  const ButtonViewWithIcon(this.textTitle, this.logoImage);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: welcomeScreenGetStartedHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(welcomeScreenGetStartedHeightWidth),
        border: Border.all(color: Colors.black38),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: marginMedium1X),
        child: Row(
          children: [
            logoImage,
            const SizedBox(
              width: marginMedium,
            ),
            Center(
              child: Text(
                textTitle,
                style: const TextStyle(
                    color: Colors.black38, fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
