// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:student_app/data/vos/movie_seat_vo.dart';

class MovieSeatItemView extends StatelessWidget {
  const MovieSeatItemView(this.mMovieSeatVO);
  final MovieSeatVO mMovieSeatVO;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: const BoxDecoration(
        // color: _getSeatColor(mMovieSeatVO),
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Center(child: Text(mMovieSeatVO.title)),
    );
  }

  // Color _getSeatColor(MovieSeatVO movieSeat) {
  //   if (movieSeat.isMovieSeatTaken()) {
  //     return movieSeatTakenColor;
  //   } else if (movieSeat.isMovieSeatAvailable()) {
  //     return movieSeatAvailableColor;
  //   } else {
  //     return Colors.white;
  //   }
  // }
}
