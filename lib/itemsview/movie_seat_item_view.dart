// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:student_app/data/vos/movie_seat_list_vo.dart';
import 'package:student_app/utils/constants.dart';

import '../resources/colors.dart';

class MovieSeatItemView extends StatelessWidget {
  const MovieSeatItemView(this.mMovieSeat, this.selectedSeat);
  // final MovieSeatVO mMovieSeatVO;
  final MovieSeatListVO? mMovieSeat;
  final Function(String? seatName) selectedSeat;

  @override
  Widget build(BuildContext context) {

     Color _getSeatColor(MovieSeatListVO movieSeat) {
      if(movieSeat.type == "available" && movieSeat.isSelected){
        return movieSeatTakenColor;
      } else if(movieSeat.type == "available" && movieSeat.isSelected == false){
        return movieSeatAvailableColor;
      } else if(movieSeat.type == "taken") {
        return movieSeatTakenColor;
      } else {
        return movieSeatReservedColor;
      }
    }
    return GestureDetector(
      onTap: () {
        selectedSeat(mMovieSeat!.seatName);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          color: _getSeatColor(mMovieSeat!),
          // color: (mMovieSeat!.isSelected)
          //     ? movieSeatTakenColor
          //     : movieSeatAvailableColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Center(
          child: Text(
            mMovieSeat!.seatName.toString(),
            style: TextStyle(
                fontSize: 5,
                fontWeight: FontWeight.bold,
                color: (mMovieSeat!.isSelected) ? Colors.white : Colors.black),
          ),
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
