import 'package:student_app/data/vos/data_vo.dart';
import 'package:student_app/data/vos/user_vo.dart';
import 'package:student_app/network/api_constants.dart';
import 'package:student_app/network/register_api.dart';
import 'package:dio/dio.dart';
import 'package:student_app/network/response/email_response.dart';
import 'package:student_app/network/response/movie_response.dart';

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
  Future<List<DataVO>?>? getNowShowingMovie(String status) {
    return rApi
        ?.getMovies(statusValue1) //for NowShowing api
        .asStream()
        .map((event) => event.data)
        .first;
  }

  @override
  Future<List<DataVO>?>? getComingSoonMovie(String status) {
    return rApi
        ?.getMovies(statusValue2) //for ComingSoon api
        .asStream()
        .map((event) => event.data)
        .first;
  }
}
