import 'package:student_app/data/vos/data_vo.dart';
import 'package:student_app/data/vos/movie_details_vo.dart';
import 'package:student_app/data/vos/user_vo.dart';
import 'package:student_app/network/response/email_response.dart';

abstract class DataModels {
  // Network

  Future<EmailResponse>? postRegisterWithEmail(
      String name,
      String email,
      String password,
      String phone,
      String facebookAccessToken,
      String googleAccessToken);

  Future<EmailResponse>? postLoginWithEmail(
    String email,
    String password,
  );

  Future<List<DataVO>?>? getNowShowingMovie(String status);
  Future<List<DataVO>?>? getComingSoonMovie(String status);
  Future<MovieDetailsVO?>? getMovieDetails(int movieId);

  //Database

  Future<UserVO>? getUserInfoFromDatabase();
  Future<String>? getTokenFromDatabase();
  Future<String>? getProfileImageFromDatabase();
  Future<List<DataVO>?>? getNowShowingMovieFromDatabase();
  Future<List<DataVO>?>? getComingSoonMovieFromDatabase();
  Future<DataVO>? getMovieFromDatabase(int movieId);
}
