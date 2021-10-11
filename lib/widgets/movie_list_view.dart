import 'package:flutter/material.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/widgets/title_text_bold.dart';

import 'title_text.dart';

class MovieListView extends StatelessWidget {
  const MovieListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: marginMedium),
      width: movieListViewWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(marginSmall),
            child: Image.network(
              "https://images-na.ssl-images-amazon.com/images/I/81uiXKV9xYL.__AC_SX300_SY300_QL70_FMwebp_.jpg",
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: marginXSmall),
          const Center(
            child: TitleTextBold(
              "The Wolverine",
              textColor: Colors.black,
              textSize: textSmallX,
            ),
          ),
          const Center(
            child: TitleText(
              "Adventure/Sci-fi -3h 2m",
              textSize: textSmall,
              textColor: Colors.black26,
            ),
          ),
        ],
      ),
    );
  }
}
