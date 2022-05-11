import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../persistence/hive_constants.dart';
part 'snack_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: hiveTypeIdSnackVO,adapterName: "SnackVOAdapter")
class SnackVO {
  @JsonKey(name: "id")
  @HiveField(0)
  int? id;
  
  @JsonKey(name: "name")
  @HiveField(1)
  String? name;

  @JsonKey(name: "description")
  @HiveField(2)
  String? description;

  @JsonKey(name: "price")
  @HiveField(3)
  int? price;

  @JsonKey(name: "image")
  @HiveField(4)
  String? image;

  @JsonKey(name:"unit_price")
  @HiveField(5)
  double? unitPrice;

  @JsonKey(name: "quantity")
  @HiveField(6)
  int? quantity;

  @JsonKey(name: "total_price")
  @HiveField(7)
  double? totalPrice;

  SnackVO(this.id, this.name, this.description, this.price, this.image,this.unitPrice,
      {this.quantity = 0, this.totalPrice = 0.0});

  factory SnackVO.fromJson(Map<String, dynamic> json) =>
      _$SnackVOFromJson(json);
  Map<String, dynamic> toJson() => _$SnackVOToJson(this);
}
