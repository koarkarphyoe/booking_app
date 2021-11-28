import 'package:flutter/material.dart';
import 'package:student_app/data/model/data_models.dart';
import 'package:student_app/data/model/data_models_impl.dart';
import 'package:student_app/page/home_page.dart';
import 'package:student_app/resources/colors.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/resources/strings.dart';
import 'package:student_app/widgets/confirm_button_view.dart';
import 'package:student_app/widgets/button_view_with_icon.dart';
import 'package:student_app/widgets/title_text.dart';
import 'package:student_app/widgets/title_text_bold.dart';
import 'package:student_app/widgets/title_and_text_field.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  DataModels userModels = DataModelsImpl();

  TextEditingController nameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();

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
                      LoginScreenView(
                          emailTextController: emailTextController,
                          passwordTextController: passwordTextController,
                          onTapButton: (String email, String password) =>
                              _loginToApiAndNavigateToHomePage(
                                  context, email, password)),
                      RegisterScreenView(
                          userNameTextController: nameTextController,
                          emailTextController: emailTextController,
                          passwordTextController: passwordTextController,
                          phoneNumberTextController: phoneTextController,
                          onTapButton: () {}),
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

  void _loginToApiAndNavigateToHomePage(
      BuildContext context, String email, String password) {
    userModels.postLoginWithEmail(email, password)?.then((value) {
      if (value.code== 400) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text("${value.message}"),
              );
            });
      } else {
        debugPrint("User ==> ${value.data}");
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomePage();
        }));
      }
    }).catchError((error) {
      print("${error.toString()}");
    });
  }
}

class RegisterScreenView extends StatelessWidget {
  final Function onTapButton;
  final TextEditingController userNameTextController;
  final TextEditingController emailTextController;
  final TextEditingController passwordTextController;
  final TextEditingController phoneNumberTextController;
  const RegisterScreenView(
      {required this.userNameTextController,
      required this.emailTextController,
      required this.passwordTextController,
      required this.phoneNumberTextController,
      required this.onTapButton});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: marginMedium1X),
          TitleAndTextFieldView(userNameTextField, userNameTextController),
          const SizedBox(height: marginMedium1X),
          TitleAndTextFieldView(emailText, emailTextController),
          const SizedBox(height: marginMedium1X),
          TitleAndTextFieldView(passwordText, passwordTextController),
          const SizedBox(height: marginMedium1X),
          TitleAndTextFieldView(
              phoneNumberTextField, phoneNumberTextController),
          const SizedBox(height: marginMedium1X),
          ButtonViewWithIcon(registerWithFacebookBtnText,
              Image.asset('assets/facebookIcon.png')),
          const SizedBox(height: marginMedium1X),
          ButtonViewWithIcon(
              registerWithGoogleBtnText, Image.asset('assets/googleIcon.png')),
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
          const SizedBox(
            height: marginMedium1X,
          ),
        ],
      ),
    );
  }
}

class LoginScreenView extends StatelessWidget {
  final Function(String email, String password) onTapButton;
  final TextEditingController emailTextController;
  final TextEditingController passwordTextController;
  const LoginScreenView(
      {required this.emailTextController,
      required this.passwordTextController,
      required this.onTapButton});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: marginMedium1X),
        TitleAndTextFieldView(emailText, emailTextController),
        const SizedBox(height: marginMedium1X),
        TitleAndTextFieldView(passwordText, passwordTextController),
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
            onTapButton(emailTextController.text, passwordTextController.text);
            // onTapButton(
            //   print("$emailTextController"),
            //   print("$passwordTextController"),
            // );
          },
          textColor: Colors.white,
          buttonBackgroundColor: primaryColor,
          textSize: 16,
        ),
        const SizedBox(height: marginMedium1X),
      ],
    );
  }
}
