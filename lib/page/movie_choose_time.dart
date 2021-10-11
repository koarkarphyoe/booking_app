import 'package:flutter/material.dart';
import 'package:student_app/resources/colors.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/widgets/confirm_button_view.dart';
import 'package:student_app/widgets/title_text.dart';
import 'package:student_app/widgets/title_text_bold.dart';

class MovieChooseTime extends StatelessWidget {
  const MovieChooseTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        leading: const Icon(
          Icons.chevron_left,
          size: paymentPageBackButtonIconSize,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MovieDateChooseSectionView(),
                SizedBox(height: marginMedium1X),
                ChooseItemGridSectionView(),
                ChooseItemGridSectionView(),
                ChooseItemGridSectionView(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: marginMedium, vertical: marginMedium2X),
                  child: ConfirmButtonView(
                    "Next",
                    () {},
                    isGhostButton: true,
                    buttonBackgroundColor: primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChooseItemGridSectionView extends StatelessWidget {
  const ChooseItemGridSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(
              horizontal: marginSmall, vertical: marginSmall),
          child: TitleTextBold(
            "Available in",
            textColor: Colors.black,
            textSize: textRegular1X,
          ),
        ),
        GridView.builder(
          itemCount: 6,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2,
          ),
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(
                  top: marginMedium, left: marginMedium, right: marginMedium),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(child: Text("2D")),
            );
          },
        ),
      ],
    );
  }
}

class MovieDateChooseSectionView extends StatelessWidget {
  const MovieDateChooseSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      height: movieDateChooseContainerHeight,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: marginMedium),
        separatorBuilder: (context, index) {
          return const SizedBox(width: marginMedium);
        },
        scrollDirection: Axis.horizontal,
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: const [
              TitleText(
                "Wed",
                textSize: textRegular,
              ),
              SizedBox(
                height: marginMedium,
              ),
              TitleText(
                "10",
                textSize: textRegular,
              ),
            ],
          );
        },
      ),
    );
  }
}
