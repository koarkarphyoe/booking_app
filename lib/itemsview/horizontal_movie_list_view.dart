import 'package:flutter/material.dart';
import 'package:student_app/data/vos/movie_vo.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/widgets/movie_view.dart';
import 'package:student_app/widgets/title_text_bold.dart';

class HorizontalMovieListView extends StatelessWidget {
  final List<MovieVO>? mMovie;
  final String titleText;
  final Function(int) onTapMovie;

  const HorizontalMovieListView(this.titleText, this.mMovie, this.onTapMovie,
      {Key? key})
      : super(key: key);

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
            textColor: Colors.black,
            textSize: textRegular3X,
          ),
        ),
        const SizedBox(height: marginMedium),
        (mMovie!=null)?
        SizedBox(
          height: movieListViewHeight,
          child: 
               ListView.builder(
                  padding: const EdgeInsets.only(left: marginMedium),
                  scrollDirection: Axis.horizontal,
                  itemCount: mMovie?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return MovieView(mMovie?[index], (movieId) {
                      onTapMovie(movieId);
                    });
                  },
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ],
    );
  }
}
