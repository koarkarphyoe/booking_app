import 'package:json_annotation/json_annotation.dart';

import 'card_vo.dart';
part 'user_vo.g.dart';

@JsonSerializable()
class UserVO {
  @JsonKey(name:"id")
  int? id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "email")
  String? email;

  @JsonKey(name: "phone")
  String? phone;

  @JsonKey(name: "total_expense")
  int? totalExpense;

  @JsonKey(name: "profile_image")
  String? profileImage;

  @JsonKey(name: "cards")
  List<CardVO?>? cards;

  UserVO(this.cards, this.email, this.id, this.name, this.phone,
      this.profileImage, this.totalExpense);

  factory UserVO.fromJson(Map<String, dynamic> json) => _$UserVOFromJson(json);
  Map<String, dynamic> toJson() => _$UserVOToJson(this);


  @override
  String toString() {
    return 'UserVO{id: $id, name: $name, email: $email, phone: $phone, totalExpense: $totalExpense, profileImage: $profileImage, cards: $cards}';
  }
}
