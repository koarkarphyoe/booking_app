import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:student_app/persistence/hive_constants.dart';
import 'casts_vo.dart';
part 'data_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: hiveTypeIdMovieVO, adapterName: "DataVOAdapter")
class DataVO {
  @JsonKey(name: "id")
  @HiveField(0)
  int? id;

  @JsonKey(name: "original_title")
  @HiveField(1)
  String? originalTitle;

  @JsonKey(name: "release_date")
  @HiveField(2)
  String? releaseDate;

  @JsonKey(name: "genres")
  @HiveField(3)
  List<String>? genres;

  @JsonKey(name: "poster_path")
  @HiveField(4)
  String? posterPath;

  @HiveField(5)
  bool? isCurrentMovie;

  @HiveField(6)
  bool? isComingSoonMovie;

  DataVO(this.id, this.originalTitle, this.releaseDate, this.genres,
      this.posterPath, this.isCurrentMovie, this.isComingSoonMovie);

  factory DataVO.fromJson(Map<String, dynamic> json) => _$DataVOFromJson(json);

  Map<String, dynamic> toJson() => _$DataVOToJson(this);
}
