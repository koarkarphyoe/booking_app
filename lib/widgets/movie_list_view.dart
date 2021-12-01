import 'package:flutter/material.dart';
import 'package:student_app/data/vos/data_vo.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/widgets/title_text_bold.dart';

import 'title_text.dart';

class MovieListView extends StatelessWidget {
  final DataVO? mMovie;
  const MovieListView(this.mMovie);

  @override
  Widget build(BuildContext context) {
    final String imageUrl = "${mMovie?.posterPath.toString()}";
    final String imageUrl2 =
        "https://images-na.ssl-images-amazon.com/images/I/81uiXKV9xYL.__AC_SX300_SY300_QL70_FMwebp_.jpg";

    final String imageUrl1 = (imageUrl != null) ? imageUrl : imageUrl2;

    return Container(
      margin: const EdgeInsets.only(right: marginMedium),
      width: movieListViewWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(marginSmall),
            child: Image.network(
              imageUrl1,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: marginXSmall),
          Center(
            child: TitleTextBold(
              mMovie!.originalTitle.toString(),
              textColor: Colors.black,
              textSize: textSmallX,
            ),
          ),
          Center(
            child: TitleText(
              mMovie!.genres.toString(),
              textSize: textSmall,
              textColor: Colors.black26,
            ),
          ),
        ],
      ),
    );
  }
}
