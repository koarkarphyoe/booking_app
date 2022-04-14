import 'package:student_app/data/vos/card_vo.dart';
import 'package:student_app/data/vos/cinemas_vo.dart';
import 'package:student_app/data/vos/movie_vo.dart';
import 'package:student_app/data/vos/movie_seat_list_vo.dart';
import 'package:student_app/data/vos/payment_method_vo.dart';
import 'package:student_app/data/vos/snack_vo.dart';
import 'package:student_app/data/vos/timeslotdata_vo.dart';
import 'package:student_app/data/vos/user_vo.dart';
import 'package:student_app/network/api_constants.dart';
import 'package:student_app/network/register_api.dart';
import 'package:dio/dio.dart';
import 'package:student_app/network/response/check_out_response.dart';
import 'package:student_app/network/requests/checkout_request.dart';
import 'package:student_app/network/response/email_response.dart';
import 'package:student_app/network/response/movie_details_response.dart';
import 'package:student_app/network/response/movie_seats_response.dart';
import 'package:student_app/network/response/snack_list_response.dart';

import 'data_agents.dart';

class DataAgentsImpl extends DataAgents {
  RegisterApi? rApi;

  static final DataAgentsImpl _singleton = DataAgentsImpl._internal();

  factory DataAgentsImpl() {
    return _singleton;
  }

  DataAgentsImpl._internal() {
    final dio = Dio();
    //BaseOptions can be found in api's Headers
    dio.options = BaseOptions(headers: {"Accept": "application/json"});
    rApi = RegisterApi(dio);
  }

  @override
  Future<EmailResponse>? postRegisterWithEmail(
      String name,
      String email,
      String password,
      String phone,
      String facebookAccessToken,
      String googleAccessToken) {
    return rApi
        ?.postRegisterWithEmail(name, email, password, phone, googleAccessToken,
            facebookAccessToken)
        .asStream()
        .map((response) => response)
        .first;
  }

  @override
  Future<EmailResponse>? postLoginWithEmail(String email, String password) {
    return rApi
        ?.postLoginWithEmail(email, password)
        .asStream()
        .map((event) => event)
        .first;
  }

  @override
  Future<UserVO>? getUserProfileData(String token) {
    return rApi
        ?.getUserProfileData(token)
        .asStream()
        .map((event) => event)
        .first;
  }

  @override
  Future<List<MovieVO>?>? getNowShowingMovie(String status) {
    return rApi
        ?.getMovies(statusValue1) //for NowShowing api
        .asStream()
        .map((event) => event.data)
        .first;
  }

  @override
  Future<List<MovieVO>?>? getComingSoonMovie(String status) {
    return rApi
        ?.getMovies(statusValue2) //for ComingSoon api
        .asStream()
        .map((event) => event.data)
        .first;
  }

  @override
  Future<MovieVO?>? getMovieDetails(int movieId) {
    return rApi
        ?.getMovieDetails(movieId.toString())
        .asStream()
        .map((event) => event.data)
        .first;
  }

  @override
  Future<List<CinemasVO>?>? getCinemasList() {
    return rApi?.getCinemasList().asStream().map((event) => event.data).first;
  }

  @override
  Future<List<TimeSlotDataVO>?>? getCinemaNameAndTimeSlots(
      String token, String? date) {
    return rApi
        ?.getCinemaNameAndTimeSlots(token, date!)
        .asStream()
        .map((event) => event.data)
        .first;
  }

  @override
  Future<List<List<MovieSeatListVO>>?>? getMovieSeat(
      String token, int cinemaDayTimeslotId, String bookingDate) {
    return rApi
        ?.getMovieSeats(token, cinemaDayTimeslotId.toString(), bookingDate)
        .asStream()
        .map((event) => event.data)
        .first;
  }

  @override
  Future<List<SnackVO>>? getSnackList(String token) {
    return rApi
        ?.getSnackList(token)
        .asStream()
        .map((event) => event.snackList)
        .first;
  }

  @override
  Future<List<PaymentMethodVO>?>? getPaymentMethodList(String token) {
    return rApi
        ?.getPaymentList(token)
        .asStream()
        .map((event) => event.data)
        .first;
  }

  @override
  Future<List<CardVO>?>? registerPaymentCard(String token, String cardHolder,
      String cardNumber, String expireDate, String cvc) {
    return rApi
        ?.registerPaymentCard(
            token, cardNumber, cardHolder, expireDate, cvc.toString())
        .asStream()
        .map((event) => event.data)
        .first;
  }

  @override
  Future<CheckOutResponse>? postCheckOut(
      String token, Map<String, dynamic> json) {
    return rApi
        ?.postCheckOutRequest(token, json)
        .asStream()
        .map((event) => event)
        .first;
  }

  @override
  Future<CheckOutResponse>? checkOut(
      String token, CheckoutRequest checkoutRequest) {
    return rApi
        ?.checkOut(token, checkoutRequest)
        .asStream()
        .map((event) => event)
        .first;
  }
}
