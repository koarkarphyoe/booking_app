import 'package:flutter/material.dart';
import 'package:student_app/page/welcome_page.dart';
import 'package:student_app/resources/colors.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/resources/strings.dart';
import 'package:student_app/widgets/confirm_button_view.dart';
import 'package:student_app/widgets/title_text.dart';
import 'package:student_app/widgets/title_text_bold.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: primaryColor,
        child: Padding(
          padding: const EdgeInsets.only(
              left: marginMedium, right: marginMedium, bottom: marginMedium1X),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const WelcomeImageAndTextView(),
              const SizedBox(height: marginMediumXXLarge),
              ConfirmButtonView(welcomePageGetStarted, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WelcomePage(),
                  ),
                );
              }, isGhostButton: true),
            ],
          ),
        ),
      ),
    );
  }
}

class WelcomeImageAndTextView extends StatelessWidget {
  const WelcomeImageAndTextView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/welcomeScreenImage.png'),
        const SizedBox(height: marginMediumLarge),
        const TitleTextBold(welcome),
        const SizedBox(height: marginXSmall),
        const TitleText(
          helloWelcomeToGalaxyApp,
          textColor: Colors.white70,
        ),
      ],
    );
  }
}
