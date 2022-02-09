// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:student_app/data/vos/movie_seat_list_vo.dart';

class MovieSeatItemView extends StatelessWidget {
  const MovieSeatItemView(this.mMovieSeat);
  // final MovieSeatVO mMovieSeatVO;
  final MovieSeatListVO? mMovieSeat;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: const BoxDecoration(
        // color: _getSeatColor(mMovieSeatVO),
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Center(
        child: Text(
          mMovieSeat!.seatName.toString(),
          style: const TextStyle(fontSize: 5, fontWeight: FontWeight.bold),
        ),
      ),
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
