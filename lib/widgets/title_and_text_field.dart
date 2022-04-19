import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_app/resources/colors.dart';
import 'package:student_app/resources/dimens.dart';

class TitleAndTextFieldView extends StatelessWidget {
  final String textTitle;
  final TextEditingController? textController;
  final bool obScureText;
  final bool isLengthLimit;
  const TitleAndTextFieldView(this.textTitle, this.textController,
      {this.obScureText = false, this.isLengthLimit = false, Key? key})
      : super(key: key);

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
            obscureText: obScureText,
            controller: textController,
            inputFormatters:
                (isLengthLimit) ? [LengthLimitingTextInputFormatter(19)] : null,
            decoration: const InputDecoration(
              hintStyle: TextStyle(),
            ),
            style: const TextStyle(color: Colors.black)),
      ],
    );
  }
}
