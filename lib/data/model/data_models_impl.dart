import 'package:intl/intl.dart';
import 'package:student_app/data/model/data_models.dart';
import 'package:student_app/data/vos/card_vo.dart';
import 'package:student_app/data/vos/cinemas_vo.dart';
import 'package:student_app/data/vos/data_vo.dart';
import 'package:student_app/data/vos/date_vo.dart';
import 'package:student_app/data/vos/movie_seat_list_vo.dart';
import 'package:student_app/data/vos/payment_method_vo.dart';
import 'package:student_app/data/vos/snack_vo.dart';
import 'package:student_app/data/vos/timeslotdata_vo.dart';
import 'package:student_app/data/vos/user_vo.dart';
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
  void getNowShowingMovie() {
    mDataAgent.getNowShowingMovie()?.then((value) async {
      List<DataVO> nowShowingMovie = value!.map((e) {
        e.isCurrentMovie = true;
        e.isComingSoonMovie = false;
        return e;
      }).toList();
      movieDao.saveAllMovie(nowShowingMovie);
      // return Future.value(value);
    });
  }

  //Before migrate to Reactive Programming
  // @override
  // Future<List<DataVO>> getComingSoonMovie() {
  //    mDataAgent.getComingSoonMovie()?.then((value) async {
  //     List<DataVO> comingSoonMovie = value!.map((e) {
  //       e.isComingSoonMovie = true;
  //       e.isCurrentMovie = false;
  //       return e;
  //     }).toList();
  //     movieDao.saveAllMovie(comingSoonMovie);
  //     // return Future.value(value);
  //   });
  // }

//After migrate to Reactive Programming,so no need to Future list and return
  @override
  void getComingSoonMovie() {
    mDataAgent.getComingSoonMovie()?.then((value) async {
      List<DataVO> comingSoonMovie = value!.map((e) {
        e.isComingSoonMovie = true;
        e.isCurrentMovie = false;
        return e;
      }).toList();
      movieDao.saveAllMovie(comingSoonMovie);
      // return Future.value(value);
    });
  }

  @override
  void getMovieDetails(int movieId) {
    mDataAgent.getMovieDetails(movieId)?.then((value) async {
      value.data;
      movieDao.saveSingleMovie(value.data!);
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
  Future<CheckOutResponse>? postCheckOutRequest(Map<String, dynamic> json) {
    return mDataAgent
        .postCheckOut(TokenDao().getToken().toString(), json)
        ?.then((value) => value);
  }

  //Database

  @override
  Future<UserVO>? getUserInfoFromDatabase() {
    return Future.value(userDao.getUserInfo());
  }

  @override
  Future<String?>? getTokenFromDatabase() {
    return Future.value(tokenDao.getToken());
  }

  //Before migrate to Reactive Programming
  // @override
  // Future<List<DataVO>?>? getNowShowingMovieFromDatabase() {
  //   return Future.value(movieDao
  //       .getAllMovie()
  //       .where((element) => element.isCurrentMovie ?? true)
  //       .toList());
  // }

  //After migrate to Reactive Programming
  @override
  Stream<List<DataVO>?>? getNowShowingMovieFromDatabase() {
    getNowShowingMovie();
    return movieDao.getAllCurrentMovieStream();
  }

  @override
  Stream<List<DataVO>?>? getComingSoonMovieFromDatabase() {
    getComingSoonMovie();
    return movieDao.getAllComingSoonMovieStream();
  }

  @override
  Future<DataVO>? getMovieFromDatabase(int movieId) {
    return Future.value(movieDao.getSingleMovie(movieId));
  }

  @override
  Stream<DataVO?> getMovieDetailsFromDatabase(int movieId) {
    getMovieDetails(movieId);
    return movieDao.getSingleMovieStream(movieId);
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

  @override
  Future<List<CardVO>?>? registerCardList(
      String cardHolder, String cardNumber, String expireDate, String cvc) {
    return mDataAgent
        .registerCardList(tokenDao.getToken().toString(), cardHolder,
            cardNumber, expireDate, cvc)
        ?.then((value) => value);
  }

  @override
  Future<CheckOutResponse>? checkOut(CheckoutRequest checkoutRequest) {
    return mDataAgent
        .checkOut(tokenDao.getToken().toString(), checkoutRequest)
        ?.then((value) => value);
  }
}
