import 'package:json_annotation/json_annotation.dart';
part 'movie_seat_list_vo.g.dart';

@JsonSerializable()
class MovieSeatListVO {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "type")
  String? type;

  @JsonKey(name: "seat_name")
  String? seatName;

  @JsonKey(name: "symbol")
  String? symbol;

  @JsonKey(name: "price")
  int? price;

  bool isSelected;
  int? seatId;

  MovieSeatListVO(
      {this.id,
      this.type,
      this.seatName,
      this.symbol,
      this.price,
      this.isSelected = false,
      this.seatId});

  factory MovieSeatListVO.fromJson(Map<String, dynamic> json) =>
      _$MovieSeatListVOFromJson(json);

  Map<String, dynamic> toJson() => _$MovieSeatListVOToJson(this);
}
