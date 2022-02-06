// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:student_app/data/vos/movie_seat_vo.dart';
import 'package:student_app/dummy/dummy_data.dart';
import 'package:student_app/itemsview/movie_seat_item_view.dart';
import 'package:student_app/resources/colors.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/widgets/title_text.dart';
import 'package:student_app/widgets/title_text_bold.dart';

class MovieSeatsPage extends StatefulWidget {
  final movieDetails;
  final cinemaName;
  final date;
  final time;
  const MovieSeatsPage(this.movieDetails, this.cinemaName, this.date, this.time,
      {Key? key})
      : super(key: key);

  @override
  State<MovieSeatsPage> createState() => _MovieSeatsPageState();
}

class _MovieSeatsPageState extends State<MovieSeatsPage> {
  @override
  Widget build(BuildContext context) {
    final List<MovieSeatVO> _movieSeats = dummyMovieSeats;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.chevron_left,
            size: paymentPageBackButtonIconSize,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          children: [
            MovieNameTimeAndCinemaSectionView(widget.movieDetails,
                widget.cinemaName, widget.date, widget.time),
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
  final String? movieName;
  final String? cinemaName;
  final String? date;
  final String? time;
  const MovieNameTimeAndCinemaSectionView(
    this.movieName,
    this.cinemaName,
    this.date,
    this.time, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: TitleTextBold(
            movieName!,
            textColor: Colors.black,
            textSize: textRegular4X,
          ),
        ),
        const SizedBox(
          height: marginXSmall,
        ),
        TitleText(
          cinemaName!,
          textColor: paymentCardIconColor,
          textSize: textRegular1X,
        ),
        const SizedBox(
          height: marginXSmall,
        ),
        TitleText(
          "$date , $time",
          textColor: Colors.black,
          textSize: textRegular1X,
        ),
      ],
    );
  }
}
