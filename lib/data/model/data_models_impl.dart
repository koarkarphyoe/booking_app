import 'package:student_app/data/model/data_models.dart';
import 'package:student_app/data/vos/data_vo.dart';
import 'package:student_app/data/vos/movie_details_vo.dart';
import 'package:student_app/data/vos/user_vo.dart';
import 'package:student_app/network/data_agents/data_agents.dart';
import 'package:student_app/network/data_agents/data_agents_impl.dart';
import 'package:student_app/network/response/email_response.dart';
import 'package:student_app/persistence/daos/movie_dao.dart';
import 'package:student_app/persistence/daos/movie_details_dao.dart';
import 'package:student_app/persistence/daos/profile_image_dao.dart';
import 'package:student_app/persistence/daos/token_dao.dart';
import 'package:student_app/persistence/daos/user_dao.dart';

class DataModelsImpl extends DataModels {
  DataAgents mDataAgent = DataAgentsImpl();

  static final DataModelsImpl _singleton = DataModelsImpl._internal();

  factory DataModelsImpl() {
    return _singleton;
  }

  DataModelsImpl._internal();

  UserDao userDao = UserDao();
  TokenDao tokenDao = TokenDao();
  ProfileImageDao profileImageDao = ProfileImageDao();
  MovieDao movieDao = MovieDao();
  MovieDetailsDao movieDetailsDao = MovieDetailsDao();

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
  Future<EmailResponse>? postLoginWithEmail(String email, String password) {
    return mDataAgent.postLoginWithEmail(email, password)?.then((value) async {
      userDao.saveUserInfo(value.data);
      profileImageDao.saveProfileImage(value.data?.profileImage);
      //save token to Database(Hive)
      tokenDao.saveToken(value.token);

      return Future.value(value);
    });
  }

  @override
  Future<List<DataVO>?>? getNowShowingMovie(String status) {
    return mDataAgent.getNowShowingMovie(status)?.then((value) async {
      List<DataVO> nowShowingMovie = value!.map((e) {
        e.isCurrentMovie = true;
        e.isComingSoonMovie = false;
        return e;
      }).toList();
      movieDao.saveAllMovie(nowShowingMovie);
      return Future.value(value);
    });
  }

  @override
  Future<List<DataVO>?>? getComingSoonMovie(String status) {
    return mDataAgent.getComingSoonMovie(status)?.then((value) async {
      List<DataVO> comingSoonMovie = value!.map((e) {
        e.isComingSoonMovie = true;
        e.isCurrentMovie = false;
        return e;
      }).toList();
      movieDao.saveAllMovie(comingSoonMovie);
      return Future.value(value);
    });
  }

  @override
  Future<MovieDetailsVO?>? getMovieDetails(int movieId) {
    return mDataAgent.getMovieDetails(movieId)?.then((value) => value.data);
  }

  //Database

  @override
  Future<UserVO>? getUserInfoFromDatabase() {
    return Future.value(userDao.getUserInfo());
  }

  @override
  Future<String>? getTokenFromDatabase() {
    return Future.value(tokenDao.getToken());
  }

  @override
  Future<String>? getProfileImageFromDatabase() {
    return Future.value(profileImageDao.getProfileImage());
  }

  @override
  Future<List<DataVO>?>? getNowShowingMovieFromDatabase() {
    return Future.value(movieDao
        .getAllMovie()
        .where((element) => element.isCurrentMovie ?? true)
        .toList());
  }

  @override
  Future<List<DataVO>?>? getComingSoonMovieFromDatabase() {
    return Future.value(movieDao
        .getAllMovie()
        .where((element) => element.isComingSoonMovie ?? true)
        .toList());
  }

  @override
  Future<DataVO>? getMovieFromDatabase(int movieId) {
    return Future.value(movieDao.getSingleMovie(movieId));
  }

  @override
  Future<MovieDetailsVO?> getMovieDetailsFromDatabase(int movieId) {
    return Future.value(movieDetailsDao.getMovieDetails(movieId));
  }
}
