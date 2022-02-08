import 'package:json_annotation/json_annotation.dart';
import 'package:student_app/data/vos/movie_seat_list_vo.dart';

part 'movie_seats_response.g.dart';


@JsonSerializable()
class MovieSeatsResponse {
  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "data")
  List<List<MovieSeatListVO>>? data;

  MovieSeatsResponse({this.code, this.message, this.data});

  factory MovieSeatsResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieSeatsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieSeatsResponseToJson(this);
}
