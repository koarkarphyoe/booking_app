import 'package:student_app/utils/constants.dart';

class MovieSeatVO {
  String type;
  String title;
  MovieSeatVO({required this.type, required this.title});

  bool isMovieSeatAvailable() {
    return type == seatTypeAvailabel;
  }

  bool isMovieSeatTaken() {
    return type == seatTypeTaken;
  }

  bool isMovieSeatRowTitle() {
    return type == seatTypeText;
  }
}
