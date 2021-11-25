// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:student_app/data/vos/movie_seat_vo.dart';
import 'package:student_app/dummy/dummy_data.dart';
import 'package:student_app/itemsview/movie_seat_item_view.dart';
import 'package:student_app/resources/colors.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/widgets/title_text.dart';
import 'package:student_app/widgets/title_text_bold.dart';

class MovieSeatsPage extends StatelessWidget {
  const MovieSeatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<MovieSeatVO> _movieSeats = dummyMovieSeats;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(
          Icons.chevron_left,
          size: paymentPageBackButtonIconSize,
          color: Colors.black,
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          children: [
            // ignore: prefer_const_constructors
            MovieNameTimeAndCinemaSectionView(),
            const SizedBox(height: marginMedium1X),
            MovieSeatsSectionView(movieSeats: _movieSeats),
          ],
        ),
      ),
    );
  }
}

class MovieSeatsSectionView extends StatelessWidget {
  const MovieSeatsSectionView({
    Key? key,
    required List<MovieSeatVO> movieSeats,
  })  : _movieSeats = movieSeats,
        super(key: key);

  final List<MovieSeatVO> _movieSeats;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: _movieSeats.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: marginSmall),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 10, childAspectRatio: 1),
      itemBuilder: (context, index) {
        return MovieSeatItemView(_movieSeats[index]);
      },
    );
  }
}

class MovieNameTimeAndCinemaSectionView extends StatelessWidget {
  const MovieNameTimeAndCinemaSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        TitleTextBold(
          "Detectiver Pikachu",
          textColor: Colors.black,
          textSize: textRegular4X,
        ),
        SizedBox(
          height: marginXSmall,
        ),
        TitleText(
          "Galaxy Cinema - Golden City",
          textColor: paymentCardIconColor,
          textSize: textRegular1X,
        ),
        SizedBox(
          height: marginXSmall,
        ),
        TitleText(
          "Wednesday, 10 May, 07:00 PM",
          textColor: Colors.black,
          textSize: textRegular1X,
        ),
      ],
    );
  }
}
