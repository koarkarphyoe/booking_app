import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_app/resources/colors.dart';
import 'package:student_app/resources/dimens.dart';

class TitleAndTextFieldView extends StatelessWidget {
  final String textTitle;
  final TextEditingController? textController;
  const TitleAndTextFieldView(this.textTitle, this.textController);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textTitle,
          style: const TextStyle(
              color: paymentCardIconColor, fontSize: textRegular1X),
        ),
        TextField(
            controller: textController,
            inputFormatters: [LengthLimitingTextInputFormatter(19)],
            decoration: const InputDecoration(
              hintStyle: TextStyle(),
            ),
            style: const TextStyle(color: Colors.black)),
      ],
    );
  }
}
