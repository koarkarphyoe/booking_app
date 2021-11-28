import 'package:hive/hive.dart';
import 'package:student_app/network/api_constants.dart';

import '../hive_constants.dart';

class ProfileImageDao {
  static final ProfileImageDao _singleton = ProfileImageDao._internal();
  factory ProfileImageDao() {
    return _singleton;
  }
  ProfileImageDao._internal();

  void saveProfileImage(String? profileImage) async {
    await getBoxProfileImage().put("profileImage", "$baseUrl$profileImage");
  }

  String? getProfileImage() {
    return getBoxProfileImage().get("profileImage");
  }

  Box<String> getBoxProfileImage() {
    return Hive.box<String>(boxNameProfileVO);
  }
}
