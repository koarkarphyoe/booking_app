import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:student_app/data/vos/user_vo.dart';
import 'package:student_app/persistence/hive_constants.dart';
part 'email_response.g.dart';

//response from network api

@JsonSerializable()
class EmailResponse {
  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "data")
  UserVO? data;

  @JsonKey(name: "token")
  String? token;

  EmailResponse(this.code, this.message, this.data, this.token);

  factory EmailResponse.fromJson(Map<String, dynamic> json) =>
      _$EmailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EmailResponseToJson(this);
}
