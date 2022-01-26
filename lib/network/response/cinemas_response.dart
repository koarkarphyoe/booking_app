import 'package:json_annotation/json_annotation.dart';
import 'package:student_app/data/vos/cinemas_list_vo.dart';

part 'cinemas_response.g.dart';

@JsonSerializable()
class CinemasResponse {
  @JsonKey(name: "code")
  int code;

  @JsonKey(name: "message")
  String message;

  @JsonKey(name: "data")
  List<CinemasListVO> data;

  CinemasResponse(this.code, this.message, this.data);

  factory CinemasResponse.fromJson(Map<String, dynamic> json) =>
      _$CinemasResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CinemasResponseToJson(this);
}
