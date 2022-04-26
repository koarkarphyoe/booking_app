import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:student_app/persistence/hive_constants.dart';
part 'cinemas_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: hiveTypeIdCinemaVO,adapterName: "CinemasVOAdapter")
class CinemasVO {
  @JsonKey(name: "id")
  @HiveField(0)
  int id;

  @JsonKey(name: "name")
  @HiveField(1)
  String name;

  @JsonKey(name: "phone")
  @HiveField(2)
  String phone;

  @JsonKey(name: "email")
  @HiveField(3)
  String email;

  @JsonKey(name: "address")
  @HiveField(4)
  String address;

  CinemasVO(this.id, this.name, this.phone, this.email, this.address);

  factory CinemasVO.fromJson(Map<String, dynamic> json) =>
      _$CinemasVOFromJson(json);

  Map<String, dynamic> toJson() => _$CinemasVOToJson(this);
}
