import 'package:json_annotation/json_annotation.dart';
part 'data_vo.g.dart';

@JsonSerializable()
class DataVO {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "original_title")
  String? originalTitle;

  @JsonKey(name: "release_date")
  String? releaseDate;

  @JsonKey(name: "genres")
  List<String>? genres;

  @JsonKey(name: "poster_path")
  String? posterPath;

  DataVO(this.id, this.originalTitle, this.releaseDate, this.genres,
      this.posterPath);

  factory DataVO.fromJson(Map<String, dynamic> json) => _$DataVOFromJson(json);

  Map<String, dynamic> toJson() => _$DataVOToJson(this);
}
