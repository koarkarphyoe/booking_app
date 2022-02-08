import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
import 'package:student_app/network/response/cinemas_response.dart';
import 'package:student_app/network/response/day_timeslots_response.dart';
import 'package:student_app/network/response/email_response.dart';
import 'package:student_app/network/response/movie_details_response.dart';
import 'package:student_app/network/response/movie_response.dart';
import 'package:student_app/network/response/movie_seats_response.dart';
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
    @Header("Authorization") String token,
    @Query(date) String date,
  );

  @GET(getMovieSeatEndPoint)
  Future<MovieSeatsResponse> getMovieSeats(
    @Header("Authorization") String token,
    @Query(cinemaDayTimeSlotId) String cinemadaytimeSlotId,
    @Query(bookingDate) String bookingdate,
  );
}
