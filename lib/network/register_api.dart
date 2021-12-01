import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
import 'package:student_app/network/response/email_response.dart';
import 'package:student_app/network/response/movie_response.dart';
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
  Future<MovieResponse> getNowShowingMovie(
    @Query(statusKey) String status,
  );
}
