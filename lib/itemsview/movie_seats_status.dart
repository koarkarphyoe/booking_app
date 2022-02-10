import 'package:flutter/material.dart';

import '../resources/dimens.dart';

class MovieSeatsStatusView extends StatelessWidget {
  const MovieSeatsStatusView(
    this.iconColor,
    this.text, {
    Key? key,
  }) : super(key: key);
  final Color iconColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          CircleAvatar(backgroundColor: iconColor, radius: 10),
          const SizedBox(
            width: marginXXSmall,
          ),
          Text(
            text,
            style: const TextStyle(color: Colors.black54, fontSize: 12),
          )
        ],
      ),
    );
  }
}