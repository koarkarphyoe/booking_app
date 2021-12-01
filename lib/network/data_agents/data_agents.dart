import 'package:student_app/data/vos/data_vo.dart';
import 'package:student_app/network/response/email_response.dart';

abstract class DataAgents {
  Future<EmailResponse>? postRegisterWithEmail(
      String name,
      String email,
      String password,
      String phone,
      String facebookAccessToken,
      String googleAccessToken);

  Future<EmailResponse>? postLoginWithEmail(String email, String password);

  Future<List<DataVO>?>? getNowShowingMovie(String status);
  Future<List<DataVO>?>? getCommingSoonMovie(String status);
}
