import 'package:json_annotation/json_annotation.dart';
import 'package:student_app/data/vos/snack_vo.dart';
part 'snack_list_response.g.dart';

@JsonSerializable()
class SnackListResponse {
  @JsonKey(name: "data")
  List<SnackVO> snackList;
  SnackListResponse(this.snackList);
  factory SnackListResponse.fromJson(Map<String, dynamic> json) =>
      _$SnackListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SnackListResponseToJson(this);
}
