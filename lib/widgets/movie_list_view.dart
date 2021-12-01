import 'package:flutter/material.dart';
import 'package:student_app/data/vos/data_vo.dart';
import 'package:student_app/network/api_constants.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/widgets/title_text_bold.dart';

import 'title_text.dart';

class MovieListView extends StatelessWidget {
  final DataVO? mMovie;
  const MovieListView(this.mMovie);

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
              "$moviePosterBaseUrl${mMovie?.posterPath.toString()}",
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
