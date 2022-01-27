import 'package:json_annotation/json_annotation.dart';
part 'cinemas_vo.g.dart';

@JsonSerializable()
class CinemasVO {
  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "name")
  String name;

  @JsonKey(name: "phone")
  String phone;

  @JsonKey(name: "email")
  String email;

  @JsonKey(name: "address")
  String address;

  CinemasVO(this.id, this.name, this.phone, this.email, this.address);

  factory CinemasVO.fromJson(Map<String, dynamic> json) =>
      _$CinemasVOFromJson(json);

  Map<String, dynamic> toJson() => _$CinemasVOToJson(this);
}
