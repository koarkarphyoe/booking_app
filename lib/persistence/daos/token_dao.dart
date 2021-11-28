import 'package:hive/hive.dart';
import 'package:student_app/persistence/hive_constants.dart';

class TokenDao {
  static final TokenDao _singleton = TokenDao._internal();

  factory TokenDao() {
    return _singleton;
  }

  TokenDao._internal();

  void saveToken(String? token) async {
    await getTokenBox().put("token", "Bearer $token");
  }

  String? getToken() {
    return getTokenBox().get("token");
  }

  Box<String> getTokenBox() {
    return Hive.box<String>(boxNameTokenVO);
  }
}
