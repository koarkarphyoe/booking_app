import 'package:student_app/data/vos/card_vo.dart';
import 'package:student_app/data/vos/cinemas_vo.dart';
import 'package:student_app/data/vos/data_vo.dart';
import 'package:student_app/data/vos/movie_seat_list_vo.dart';
import 'package:student_app/data/vos/payment_method_vo.dart';
import 'package:student_app/data/vos/snack_vo.dart';
import 'package:student_app/data/vos/timeslotdata_vo.dart';
import 'package:student_app/network/requests/checkout_request.dart';
import 'package:student_app/network/response/check_out_response.dart';
import 'package:student_app/network/response/email_response.dart';
import 'package:student_app/network/response/movie_details_response.dart';

abstract class DataAgents {
  Future<EmailResponse>? postRegisterWithEmail(
      String name,
      String email,
      String password,
      String phone,
      String facebookAccessToken,
      String googleAccessToken);

  Future<EmailResponse>? postLoginWithEmail(String email, String password);

  Future<List<DataVO>?>? getNowShowingMovie();
  Future<List<DataVO>?>? getComingSoonMovie();
  Future<MovieDetailsResponse?>? getMovieDetails(int movieId);
  Future<List<CinemasVO>?>? getCinemasList();
  Future<List<TimeSlotDataVO>?>? getCinemaNameAndTimeSlots(
      String token, String? date);

  Future<List<List<MovieSeatListVO>>?>? getMovieSeat(
      String token, int cinemaDayTimeslotId, String bookingDate);

  Future<List<SnackVO>>? getSnackList(String token);

  Future<List<PaymentMethodVO>?>? getPaymentMethodList(String token);

  Future<List<CardVO>?>? registerCardList(String token, String cardHolder,
      String cardNumber, String expireDate, String cvc);

  Future<CheckOutResponse>? postCheckOut(
      String token, Map<String,dynamic> json);

       Future<CheckOutResponse>? checkOut(
      String token, CheckoutRequest checkoutRequest);
      

}
