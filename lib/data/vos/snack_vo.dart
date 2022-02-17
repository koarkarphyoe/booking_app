import 'package:json_annotation/json_annotation.dart';
part 'snack_vo.g.dart';

@JsonSerializable()
class SnackVO {
  @JsonKey(name: "id")
  int? id;
  
  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "price")
  int? price;

  @JsonKey(name: "image")
  String? image;

  @JsonKey(name:"unit_price")
  double? unitPrice;

  @JsonKey(name: "quantity")
  int? quantity;

  @JsonKey(name: "total_price")
  double? totalPrice;

  SnackVO(this.id, this.name, this.description, this.price, this.image,this.unitPrice,
      {this.quantity = 0, this.totalPrice = 0.0});

  factory SnackVO.fromJson(Map<String, dynamic> json) =>
      _$SnackVOFromJson(json);
  Map<String, dynamic> toJson() => _$SnackVOToJson(this);
}
