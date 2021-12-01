import 'package:student_app/data/model/data_models.dart';
import 'package:student_app/data/vos/data_vo.dart';
import 'package:student_app/data/vos/user_vo.dart';
import 'package:student_app/network/data_agents/data_agents.dart';
import 'package:student_app/network/data_agents/data_agents_impl.dart';
import 'package:student_app/network/response/email_response.dart';
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
  Future<List<DataVO>?>? getNowShowingMovie(String status) {
    return mDataAgent.getNowShowingMovie(status);
  }
}
