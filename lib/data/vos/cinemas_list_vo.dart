import 'package:json_annotation/json_annotation.dart';
part 'cinemas_list_vo.g.dart';

@JsonSerializable()
class CinemasListVO {
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

  CinemasListVO(this.id, this.name, this.phone, this.email, this.address);

  factory CinemasListVO.fromJson(Map<String, dynamic> json) =>
      _$CinemasListVOFromJson(json);

  Map<String, dynamic> toJson() => _$CinemasListVOToJson(this);
}
