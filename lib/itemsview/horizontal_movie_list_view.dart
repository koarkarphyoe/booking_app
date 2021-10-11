import 'package:flutter/material.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/resources/strings.dart';
import 'package:student_app/widgets/movie_list_view.dart';
import 'package:student_app/widgets/title_text_bold.dart';
class HorizontalMovieListView extends StatelessWidget {
  final String titleText;
  const HorizontalMovieListView(this.titleText,{
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
         Padding(
          padding: const EdgeInsets.only(left: marginMedium),
          child: TitleTextBold(
            titleText,
            textColor: Colors.black,textSize: textRegular3X,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: movieListViewHeight,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: marginMedium),
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return const MovieListView();
            },
          ),
        ),
      ],
    );
  }
}