import 'package:student_app/data/vos/cinemas_vo.dart';
import 'package:student_app/data/vos/data_vo.dart';
import 'package:student_app/data/vos/timeslotdata_vo.dart';
import 'package:student_app/network/response/cinemas_response.dart';
import 'package:student_app/network/response/email_response.dart';
import 'package:student_app/network/response/movie_details_response.dart';
import 'package:student_app/network/response/movie_response.dart';

abstract class DataAgents {
  Future<EmailResponse>? postRegisterWithEmail(
      String name,
      String email,
      String password,
      String phone,
      String facebookAccessToken,
      String googleAccessToken);

  Future<EmailResponse>? postLoginWithEmail(String email, String password);

  Future<List<DataVO>?>? getNowShowingMovie(String status);
  Future<List<DataVO>?>? getComingSoonMovie(String status);
  Future<MovieDetailsResponse>? getMovieDetails(int movieId);
  Future<List<CinemasVO>?>? getCinemasList();
  Future<List<TimeSlotDataVO>?>? getCinemaTimeslots(String token,String date);
}
