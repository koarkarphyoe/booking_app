import 'package:intl/intl.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:student_app/data/model/data_models.dart';
import 'package:student_app/data/vos/card_vo.dart';
import 'package:student_app/data/vos/cinemas_vo.dart';
import 'package:student_app/data/vos/movie_vo.dart';
import 'package:student_app/data/vos/date_vo.dart';
import 'package:student_app/data/vos/movie_seat_list_vo.dart';
import 'package:student_app/data/vos/payment_method_vo.dart';
import 'package:student_app/data/vos/snack_vo.dart';
import 'package:student_app/data/vos/timeslotdata_vo.dart';
import 'package:student_app/data/vos/user_vo.dart';
import 'package:student_app/network/api_constants.dart';
import 'package:student_app/network/data_agents/data_agents.dart';
import 'package:student_app/network/data_agents/data_agents_impl.dart';
import 'package:student_app/network/response/check_out_response.dart';
import 'package:student_app/network/response/email_response.dart';
import 'package:student_app/persistence/daos/movie_dao.dart';
import 'package:student_app/persistence/daos/token_dao.dart';
import 'package:student_app/persistence/daos/user_dao.dart';

import '../../network/requests/checkout_request.dart';

class DataModelsImpl extends DataModels {
  DataAgents mDataAgent = DataAgentsImpl();

  static final DataModelsImpl _singleton = DataModelsImpl._internal();

  factory DataModelsImpl() {
    return _singleton;
  }

  DataModelsImpl._internal();

  UserDao userDao = UserDao();
  TokenDao tokenDao = TokenDao();
  MovieDao movieDao = MovieDao();

  @override
  Future<EmailResponse>? postRegisterWithEmail(
      String name,
      String email,
      String password,
      String phone,
      String facebookAccessToken,
      String googleAccessToken) {
    return mDataAgent.postRegisterWithEmail(
        name, email, password, phone, facebookAccessToken, googleAccessToken);
  }

  @override
  Future<UserVO>? postLoginWithEmail(String email, String password) {
    return mDataAgent.postLoginWithEmail(email, password)?.then((value) async {
      userDao.saveUserInfo(value.data);
      //save token to Database(Hive)
      tokenDao.saveToken(value.token);
      return Future.value(value.data);
    });
  }

  @override
  void getNowShowingMovie(String status) {
    mDataAgent.getNowShowingMovie(status)?.then((value) async {
      List<MovieVO> nowShowingMovie = value!.map((e) {
        e.isCurrentMovie = true;
        e.isComingSoonMovie = false;
        return e;
      }).toList();
      movieDao.saveAllMovie(nowShowingMovie);
      // return Future.value(value);
    });
  }

  @override
  void getComingSoonMovie(String status) {
    mDataAgent.getComingSoonMovie(status)?.then((value) async {
      List<MovieVO> comingSoonMovie = value!.map((e) {
        e.isComingSoonMovie = true;
        e.isCurrentMovie = false;
        return e;
      }).toList();
      movieDao.saveAllMovie(comingSoonMovie);
      // return Future.value(value);
    });
  }

  @override
  void getUserProfileData() {
    mDataAgent
        .getUserProfileData(tokenDao.getToken().toString())
        ?.then((value) => value);
  }

  @override
  Future<MovieVO?>? getMovieDetails(int movieId) {
    return mDataAgent.getMovieDetails(movieId)?.then((value) async {
      movieDao.saveSingleMovie(value!);
      return Future.value(value);
    });
  }

  @override
  Future<List<CinemasVO>?>? getCinemasList() {
    return mDataAgent.getCinemasList()?.then((value) => value);
  }

  @override
  Future<List<TimeSlotDataVO>?>? getCinemaNameAndTimeSlots(String? date) {
    return mDataAgent
        .getCinemaNameAndTimeSlots(tokenDao.getToken().toString(), date)
        ?.then((value) => value);
  }

  @override
  Future<List<List<MovieSeatListVO>>?> getMovieSeat(
      int cinemaDayTimeslotId, String bookingDate) {
    return mDataAgent
        .getMovieSeat(
            tokenDao.getToken().toString(), cinemaDayTimeslotId, bookingDate)!
        .then((value) => value);
  }

  @override
  Future<List<SnackVO>>? getSnack() {
    return mDataAgent
        .getSnackList(tokenDao.getToken().toString())
        ?.then((value) => value);
  }

  @override
  Future<List<PaymentMethodVO>?>? getPaymentList() {
    return mDataAgent
        .getPaymentMethodList(tokenDao.getToken().toString())
        ?.then((value) => value);
  }

  @override
  Future<List<CardVO>?>? registerPaymentCard(
      String cardHolder, String cardNumber, String expireDate, String cvc) {
    return mDataAgent
        .registerPaymentCard(tokenDao.getToken().toString(), cardHolder,
            cardNumber, expireDate, cvc)
        ?.then((value) => value);
  }

  @override
  Future<CheckOutResponse>? postCheckOutRequest(Map<String, dynamic> json) {
    return mDataAgent
        .postCheckOut(TokenDao().getToken().toString(), json)
        ?.then((value) => value);
  }

  //Database

  @override
  Future<UserVO>? getUserInfoFromDatabase() {
    this.getUserProfileData();
    return userDao
        .getUserInfoEventStream()
        .startWith(userDao.getUserInfoStream())
        .combineLatest(userDao.getUserInfoStream(), (p0, p1) => p1 as UserVO)
        .first;
  }

  @override
  Future<String?>? getTokenFromDatabase() {
    return Future.value(tokenDao.getToken());
  }

  @override
  Future<List<MovieVO>?>? getNowShowingMovieFromDatabase() {
    this.getNowShowingMovie(statusValue1);
    return movieDao
        .getAllMovieEventStream()
        .startWith(movieDao.getNowShowingMovieListStream())
        .combineLatest(movieDao.getNowShowingMovieListStream(),
            (p0, p1) => p1 as List<MovieVO>)
        .first;
  }

  @override
  Future<List<MovieVO>?>? getComingSoonMovieFromDatabase() {
    this.getComingSoonMovie(statusValue2);
    return movieDao
        .getAllMovieEventStream()
        .startWith(movieDao.getCommingSoonMovieListStream())
        .combineLatest(movieDao.getCommingSoonMovieListStream(),
            (p0, p1) => p1 as List<MovieVO>)
        .first;
  }

  @override
  Future<MovieVO> getMovieDetailsFromDatabase(int movieId) {
    return Future.value(movieDao.getSingleMovie(movieId));
  }

  @override
  Future<CheckOutResponse>? checkOut(CheckoutRequest checkoutRequest) {
    return mDataAgent
        .checkOut(tokenDao.getToken().toString(), checkoutRequest)
        ?.then((value) => value);
  }

  @override
  void deleteTokenFromDatabase() {
    tokenDao.deleteToken();
  }

  @override
  void deleteUserInfoFromDatabase() {
    userDao.deleteUserUnfo();
  }

  //Other

  // for select and show dates in UI section
  @override
  List<DateVO> getDates() {
    List<DateVO> dateList = [];

    for (int i = 0; i < 7; i++) {
      String day = DateFormat.E().format(DateTime.now().add(Duration(days: i)));
      String date =
          DateFormat.d().format(DateTime.now().add(Duration(days: i)));
      String dayMonthDate =
          DateFormat.MMMMEEEEd().format(DateTime.now().add(Duration(days: i)));

      String yMMMMd =
          DateFormat.yMd().format(DateTime.now().add(Duration(days: i)));

      var dateVo = DateVO(i, day, date, dayMonthDate, yMMMMd);
      dateList.add(dateVo);
    }
    return dateList;
  }

  @override
  void logOut() {
    userDao.deleteUserUnfo();
    tokenDao.deleteToken();
  }

  @override
  bool isLogIn() {
    return tokenDao.getToken()?.isNotEmpty ?? false;
  }
}
