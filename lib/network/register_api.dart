import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
import 'package:student_app/network/requests/checkout_request.dart';
import 'package:student_app/network/response/card_list_response.dart';
import 'package:student_app/network/response/check_out_response.dart';
import 'package:student_app/network/response/cinemas_response.dart';
import 'package:student_app/network/response/day_timeslots_response.dart';
import 'package:student_app/network/response/email_response.dart';
import 'package:student_app/network/response/movie_details_response.dart';
import 'package:student_app/network/response/movie_response.dart';
import 'package:student_app/network/response/movie_seats_response.dart';
import 'package:student_app/network/response/payment_method_response.dart';
import 'package:student_app/network/response/snack_list_response.dart';
import 'api_constants.dart';
part 'register_api.g.dart';

//call to network api

@RestApi(baseUrl: baseUrl)
abstract class RegisterApi {
  factory RegisterApi(Dio dio) = _RegisterApi;

  @POST(registerWithEmailEndPoint)
  @FormUrlEncoded()
  Future<EmailResponse> postRegisterWithEmail(
    @Field(nameParam) String name,
    @Field(emailParam) String email,
    @Field(passwordParam) String password,
    @Field(phoneParam) String phone,
    @Field(googleAccessTokenParam) String googleAccessToken,
    @Field(facebookAccessTokenParam) String facebookAccessToken,
  );

  @POST(loginWithEmailEndPoint)
  @FormUrlEncoded()
  Future<EmailResponse> postLoginWithEmail(
    @Field(emailParam) String email,
    @Field(passwordParam) String password,
  );

  @GET(getNowShowingMovieEndPoint)
  Future<MovieResponse> getMovies(
    @Query(statusKey) String status,
  );

  @GET("$getMovieDetailsEndPoint/{movie_id}")
  Future<MovieDetailsResponse> getMovieDetails(
    @Path("movie_id") String movieId,
  );

  @GET(getCinemasListEndPoint)
  Future<CinemasResponse> getCinemasList();

  @GET(getCinemaDayTimeSlotEndPoint)
  Future<DayTimeslotsResponse> getCinemaNameAndTimeSlots(
    @Header(authorization) String token,
    @Query(date) String date,
  );

  @GET(getMovieSeatEndPoint)
  Future<MovieSeatsResponse> getMovieSeats(
    @Header(authorization) String token,
    @Query(cinemaDayTimeSlotId) String cinemadaytimeSlotId,
    @Query(bookingDate) String bookingdate,
  );

  @GET(getSnackListEndPoint)
  Future<SnackListResponse> getSnackList(@Header(authorization) String token);

  @GET(getPaymentMethodListEndPoint)
  Future<PaymentMethodResponse> getPaymentList(
    @Header(authorization) String token,
  );

  @POST(getCartListEndPoint)
  Future<CardListResponse> registerCardList(
    @Header(authorization) String token,
    @Field(cardHolder) String cardHolder, //can use with @Query()
    @Field(cardNumber) String cardNumber, //can use with @Query()
    @Field(expirationDate) String expirationDate, //can use with @Query()
    @Field(cvc) String cvc, //can use with @Query()
  );

  //Method 1
  @POST(getCheckOutEndPoint)
  Future<CheckOutResponse> postCheckOutRequest(
    @Header(authorization) String token,
    @Body() Map<String, dynamic> json,
  );

  //Method 2
  @POST(getCheckOutEndPoint)
  Future<CheckOutResponse> checkOut(
    @Header(authorization) String token,
    @Body() CheckoutRequest checkoutRequest,
  );
}
