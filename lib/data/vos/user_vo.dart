import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:student_app/persistence/hive_constants.dart';

import 'card_vo.dart';
part 'user_vo.g.dart';

@JsonSerializable()
@HiveType(typeId:hiveTypeIdUserVO,adapterName: "UserVOAdapter")
class UserVO {
  @JsonKey(name:"id")
  @HiveField(0)
  int? id;

  @JsonKey(name: "name")
  @HiveField(1)
  String? name;

  @JsonKey(name: "email")
  @HiveField(2)
  String? email;

  @JsonKey(name: "phone")
  @HiveField(3)
  String? phone;

  @JsonKey(name: "total_expense")
  @HiveField(4)
  int? totalExpense;

  @JsonKey(name: "profile_image")
  @HiveField(5)
  String? profileImage;

  @JsonKey(name: "cards")
  @HiveField(6)
  List<CardVO>? cards;

  UserVO(this.cards, this.email, this.id, this.name, this.phone,
      this.profileImage, this.totalExpense);

  factory UserVO.fromJson(Map<String, dynamic> json) => _$UserVOFromJson(json);
  Map<String, dynamic> toJson() => _$UserVOToJson(this);


  @override
  String toString() {
    return 'UserVO{id: $id, name: $name, email: $email, phone: $phone, totalExpense: $totalExpense, profileImage: $profileImage, cards: $cards}';
  }
}
