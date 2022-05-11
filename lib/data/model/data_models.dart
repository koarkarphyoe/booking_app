import 'package:student_app/data/vos/card_vo.dart';
import 'package:student_app/data/vos/cinemas_vo.dart';
import 'package:student_app/data/vos/data_vo.dart';
import 'package:student_app/data/vos/date_vo.dart';
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

  void getNowShowingMovie();
  void getComingSoonMovie();
  void getMovieDetails(int movieId);
  Future<List<CinemasVO>?>? getCinemasList();
  // Future<List<TimeSlotDataVO>> getCinemaNameAndTimeSlots(String? date);//Before migrate to Reactive Programming
  void getCinemaNameAndTimeSlots(
      String? date); //After migrate to Reactive Programming
  void logOut();
  bool isLogIn();
  Future<List<List<MovieSeatListVO>>?> getMovieSeat(
      int cinemaDayTimeslotId, String bookingDate);
  // Future<List<SnackVO>>? getSnack(); //Before migrate Reactive Programming
  void getSnack(); //After migrate Reactive Programming
  void getPaymentList();
  Future<List<CardVO>?>? registerCardList(
      String cardHolder, String cardNumber, String expireDate, String cvc);
  Future<CheckOutResponse>? postCheckOutRequest(
      Map<String, dynamic> checkoutRequest);
  Future<CheckOutResponse>? checkOut(CheckoutRequest checkoutRequest);

  //Database
  Stream<UserVO?>?
      getUserInfoFromDatabase(); //in this case no need to apply Reactive Programming(Stream)
  Stream<String?>?
      getTokenFromDatabase(); //in this case no need to apply Reactive Programming(Stream)
  Stream<List<DataVO>?>? getNowShowingMovieFromDatabase();
  Stream<List<DataVO>?>? getComingSoonMovieFromDatabase();
  Stream<DataVO?> getMovieDetailsFromDatabase(int movieId);
  Stream<List<TimeSlotDataVO>> getCinemasListFromDatabase(String date);
  Stream<List<SnackVO>> getSnackListFromDatabase();
  Stream<List<PaymentMethodVO>> getPaymentListFromDatabase();

  //Other
  List<DateVO> getDates();
  void deleteTokenFromDatabase();
  void deleteUserInfoFromDatabase();
}
