import 'package:student_app/data/vos/card_vo.dart';
import 'package:student_app/data/vos/cinemas_vo.dart';
import 'package:student_app/data/vos/data_vo.dart';
import 'package:student_app/data/vos/date_vo.dart';
import 'package:student_app/data/vos/movie_details_vo.dart';
import 'package:student_app/data/vos/movie_seat_list_vo.dart';
import 'package:student_app/data/vos/payment_method_vo.dart';
import 'package:student_app/data/vos/snack_vo.dart';
import 'package:student_app/data/vos/timeslotdata_vo.dart';
import 'package:student_app/data/vos/user_vo.dart';
import 'package:student_app/network/requests/checkout_request.dart';
import 'package:student_app/network/response/check_out_response.dart';
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

  Future<UserVO>? postLoginWithEmail(
    String email,
    String password,
  );

  void getNowShowingMovie(String status);
  void getComingSoonMovie(String status);
  void getUserProfileData();
  Future<MovieDetailsVO?>? getMovieDetails(int movieId);
  Future<List<CinemasVO>?>? getCinemasList();
  Future<List<TimeSlotDataVO>?>? getCinemaNameAndTimeSlots(String? date);
  void logOut();
  bool isLogIn();
  Future<List<List<MovieSeatListVO>>?> getMovieSeat(
      int cinemaDayTimeslotId, String bookingDate);
  Future<List<SnackVO>>? getSnack();
  Future<List<PaymentMethodVO>?>? getPaymentList();
  Future<List<CardVO>?>? registerPaymentCard(
      String cardHolder, String cardNumber, String expireDate, String cvc);
  Future<CheckOutResponse>? postCheckOutRequest(
      Map<String, dynamic> checkoutRequest);
  Future<CheckOutResponse>? checkOut(CheckoutRequest checkoutRequest);


  //Database

  Future<UserVO>? getUserInfoFromDatabase();
  Future<String?>? getTokenFromDatabase();
  Future<List<DataVO>?>? getNowShowingMovieFromDatabase();
  Future<List<DataVO>?>? getComingSoonMovieFromDatabase();
  Future<DataVO>? getMovieFromDatabase(int movieId);
  Future<MovieDetailsVO?> getMovieDetailsFromDatabase(int movieId);
  void deleteTokenFromDatabase();
  void deleteUserInfoFromDatabase();

  //Other
  List<DateVO> getDates();
}
