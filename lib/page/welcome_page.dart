import 'package:flutter/material.dart';
import 'package:student_app/resources/colors.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/resources/strings.dart';
import 'package:student_app/widgets/confirm_button_view.dart';
import 'package:student_app/widgets/button_view_with_icon.dart';
import 'package:student_app/widgets/title_text.dart';
import 'package:student_app/widgets/title_text_bold.dart';
import 'package:student_app/widgets/title_and_text_field.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<String> textList = [loginText, registerText];
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 150,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: const [
            TitleTextBold(welcome, textColor: Colors.black),
            TitleText(
              loginSingInScreenGreetingText,
              textColor: Colors.black38,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: marginMedium),
        child: SingleChildScrollView(
          child: DefaultTabController(
            length: textList.length,
            child: Column(
              children: [
                TabBar(
                  indicatorWeight: 4,
                  indicatorColor: primaryColor,
                  labelColor: primaryColor,
                  unselectedLabelColor: Colors.black,
                  tabs: textList
                      .map((text) => Tab(
                            child: Text(text),
                          ))
                      .toList(),
                  //[
                  // Tab(
                  //   child: Text(
                  //     "Login",
                  //     style: TextStyle(color: Colors.black, fontSize: 20),
                  //   ),
                  // ),
                  // Tab(
                  //   child: Text(
                  //     "Register",
                  //     style: TextStyle(color: Colors.black, fontSize: 20),
                  //   ),
                  // ),
                  //]
                ),
                SizedBox(
                  height: tabBarViewSizedBoxHeight,
                  child: TabBarView(
                    children: [
                      LoginScreenView(() {}),
                      RegisterScreenView(() {}),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterScreenView extends StatelessWidget {
  final Function onTapButton;
  const RegisterScreenView(
    this.onTapButton, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: marginMedium1X),
        const TitleAndTextFieldView(userNameTextField),
        const SizedBox(height: marginMedium1X),
        const TitleAndTextFieldView(passwordText),
        const SizedBox(height: marginMedium1X),
        const TitleAndTextFieldView(phoneNumberTextField),
        const SizedBox(height: marginMedium1X),
        ConfirmButtonView(
          createAccountBtnText,
          () {
            onTapButton();
          },
          textColor: Colors.white,
          buttonBackgroundColor: primaryColor,
          textSize: 16,
        ),
      ],
    );
  }
}

class LoginScreenView extends StatelessWidget {
  final Function onTapButton;
  const LoginScreenView(
    this.onTapButton, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: marginMedium1X),
        const TitleAndTextFieldView(emailText),
        const SizedBox(height: marginMedium1X),
        const TitleAndTextFieldView(passwordText),
        const SizedBox(height: marginMedium1X),
        const Align(
          alignment: Alignment.centerRight,
          child: TitleText(
            fortgotPasswordText,
            textColor: Colors.black38,
          ),
        ),
        const SizedBox(height: marginMedium1X),
        ButtonViewWithIcon(
          signInWithFacebookBtnText,
          Image.asset('assets/facebookIcon.png'),
        ),
        const SizedBox(height: marginMedium1X),
        ButtonViewWithIcon(
          signInWithGoogleBtnText,
          Image.asset('assets/googleIcon.png'),
        ),
        const SizedBox(height: marginMedium1X),
        ConfirmButtonView(
          comfirmBtnText,
          () {
            onTapButton();
          },
          textColor: Colors.white,
          buttonBackgroundColor: primaryColor,
          textSize: 16,
        ),
      ],
    );
  }
}
