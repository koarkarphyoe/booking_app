import 'package:json_annotation/json_annotation.dart';
import 'package:student_app/data/vos/voucher_vo.dart';
part 'check_out_response.g.dart';

@JsonSerializable()
class CheckOutResponse {
  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "data")
  VoucherVO? data;

  CheckOutResponse(this.code, this.data, this.message);

  factory CheckOutResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckOutResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckOutResponseToJson(this);
}
