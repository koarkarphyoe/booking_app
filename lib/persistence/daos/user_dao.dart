import 'package:hive/hive.dart';
import 'package:student_app/data/vos/card_vo.dart';
import 'package:student_app/data/vos/user_vo.dart';
import 'package:student_app/persistence/hive_constants.dart';

class UserDao {
  static final UserDao _singleton = UserDao._internal();
  factory UserDao() {
    return _singleton;
  }
  UserDao._internal();

  void saveUserInfo(UserVO? userInfo) async {
    await getUserInfoBox().add(userInfo!);
  }

  UserVO getUserInfo() {
    return getUserInfoBox().values.last;
  }

  Box<UserVO> getUserInfoBox() {
    return Hive.box<UserVO>(boxNameUserVO);
  }

  ///Reactive Programming
  Stream<void> getUserInfoEventStream() {
    return getUserInfoBox().watch();
  }

  Stream<UserVO> getUserInfoStream() {
    return Stream.value(getUserInfo());
  }

  void deleteUserUnfo() {
    // Hive.box<UserVO>(boxNameUserVO).clear();
    getUserInfoBox().clear();
  }
}
