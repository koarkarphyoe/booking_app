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
import 'package:student_app/persistence/daos/payment_method_dao.dart';
import 'package:student_app/persistence/daos/snack_dao.dart';
import 'package:student_app/persistence/daos/timeslot_dao.dart';
import 'package:student_app/persistence/daos/movie_dao.dart';
import 'package:student_app/persistence/daos/movie_details_dao.dart';
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
  MovieDetailsDao movieDetailsDao = MovieDetailsDao();
  TimeSlotDao cinemasTimeSlotDao = TimeSlotDao();
  SnackDao snackDao = SnackDao();
  PaymentMethodDao paymentMethodDao = PaymentMethodDao();

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
      movieDetailsDao.saveSingleMovie(value!.data!);
    });
  }

  @override
  Future<List<CinemasVO>?>? getCinemasList() {
    return mDataAgent.getCinemasList()?.then((value) => value);
  }

  //Before migrate to Reactive Programming
  // @override
  // Future<List<TimeSlotDataVO>> getCinemaNameAndTimeSlots(String? date) async {
  //   return mDataAgent
  //       .getCinemaNameAndTimeSlots(tokenDao.getToken().toString(), date)!
  //       .then((value) {
  //     cinemasTimeSlotDao.saveAllCinemasList(value!, date!);
  //     return Future.value(value);
  //   });
  // }

  //After migrate to Reactive Programming
  @override
  void getCinemaNameAndTimeSlots(String? date) async {
    mDataAgent
        .getCinemaNameAndTimeSlots(tokenDao.getToken().toString(), date)!
        .then((value) {
      cinemasTimeSlotDao.saveAllCinemasList(value!, date!);
    });
  }

  @override
  Future<List<List<MovieSeatListVO>>?> getMovieSeat(
      int cinemaDayTimeslotId, String bookingDate) {
    return mDataAgent
        .getMovieSeat(
            tokenDao.getToken().toString(), cinemaDayTimeslotId, bookingDate)!
        .then((value) => value);
  }

  //Before migrate to Reactive Programming
  // @override
  // Future<List<SnackVO>>? getSnack() {
  //   return mDataAgent
  //       .getSnackList(tokenDao.getToken().toString())
  //       ?.then((value) => value);
  // }

  //After migrate to Reactive Programming
  @override
  void getSnack() {
    mDataAgent.getSnackList(tokenDao.getToken().toString())?.then((value) {
      snackDao.saveAllSnack(value);
    });
  }

  @override
  void getPaymentList() {
     mDataAgent
        .getPaymentMethodList(tokenDao.getToken().toString())
        ?.then((value) => paymentMethodDao.saveAllPaymentMethod(value!));
  }

  @override
  Future<CheckOutResponse>? postCheckOutRequest(Map<String, dynamic> json) {
    return mDataAgent
        .postCheckOut(TokenDao().getToken().toString(), json)
        ?.then((value) => value);
  }

  //Database
  //Before migrate to Reactive Programming
  // @override
  // Future<UserVO>? getUserInfoFromDatabase() {
  //   return Future.value(userDao.getUserInfo());
  // }

  //After migrate to Reactive Programming
  @override
  Stream<UserVO?>? getUserInfoFromDatabase() {
    return userDao.getUserInfoStream();
  }

  //Before migrate to Reactive Programming
  // @override
  // Future<String?>? getTokenFromDatabase() {
  //   return Future.value(tokenDao.getToken());
  // }

  //After migrate to Reactive Programming
  @override
  Stream<String?>? getTokenFromDatabase() {
    return tokenDao.getTokenStream();
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
  Stream<DataVO?> getMovieDetailsFromDatabase(int movieId) {
    getMovieDetails(movieId);
    return movieDetailsDao.getSingleMovieStream(movieId);
  }

  //Before migrate to Reactive Programming
  //   @override
  //   Future<List<TimeSlotDataVO>> getCinemasListFromDatabase(String date) {
  //   getCinemaNameAndTimeSlots(date);
  //   return Future.value(cinemasTimeSlotDao.getCinemasList(date));
  // }

  //After migrate to Reactive Programming
  @override
  Stream<List<TimeSlotDataVO>> getCinemasListFromDatabase(String date) {
    getCinemaNameAndTimeSlots(date);
    return cinemasTimeSlotDao.getCinemaTimeSlotStream(date);
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

  @override
  Stream<List<SnackVO>> getSnackListFromDatabase() {
    getSnack();
    return snackDao.getAllSnackListStream();
  }

  @override
  Stream<List<PaymentMethodVO>> getPaymentListFromDatabase() {
    getPaymentList();
    return paymentMethodDao.getAllPaymentListStream();
  }
}
