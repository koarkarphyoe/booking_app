import 'package:json_annotation/json_annotation.dart';
part 'movie_seat_list_vo.g.dart';

@JsonSerializable()
class MovieSeatListVO {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "text")
  String? text;

  @JsonKey(name: "seat_name")
  String? seatName;

  @JsonKey(name: "symbol")
  String? symbol;

  @JsonKey(name: "price")
  int? price;
  MovieSeatListVO({this.id, this.text, this.seatName, this.symbol, this.price});

  factory MovieSeatListVO.fromJson(Map<String, dynamic> json) =>
      _$MovieSeatListVOFromJson(json);

  Map<String, dynamic> toJson() => _$MovieSeatListVOToJson(this);
}
