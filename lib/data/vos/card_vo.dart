import 'package:json_annotation/json_annotation.dart';

part 'card_vo.g.dart';

@JsonSerializable()
class CardVO {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "card_holder")
  String? cardHolder;

  @JsonKey(name: "card_number")
  String? cardNumber;

  @JsonKey(name: "expiration_date")
  String? expirationDate;

  @JsonKey(name: "card_type")
  String? cardType;

  CardVO(
      this.id,
      this.cardHolder,
      this.cardNumber,
      this.expirationDate,
      this.cardType,
      );


  @override
  String toString() {
    return 'CardVO{id: $id, cardHolder: $cardHolder, cardNumber: $cardNumber, expirationDate: $expirationDate, cardType: $cardType}';
  }

  factory CardVO.fromJson(Map<String, dynamic> json) => _$CardVOFromJson(json);

  Map<String, dynamic> toJson() => _$CardVOToJson(this);
}
