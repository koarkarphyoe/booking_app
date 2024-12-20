import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';
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

  UserVO? getUserInfo() {
    return getUserInfoBox().values.last;
  }

  //Reactive Programming
  Stream<UserVO?> getUserInfoStream() {
    return getUserInfoBox()
        .watch()
        .map((event) => getUserInfo())
        .startWith(getUserInfo());
  }

  //Create Hive Box
  Box<UserVO> getUserInfoBox() {
    return Hive.box<UserVO>(boxNameUserVO);
  }

  void deleteUserUnfo() {
    // Hive.box<UserVO>(boxNameUserVO).clear();
    getUserInfoBox().clear();
  }
}
