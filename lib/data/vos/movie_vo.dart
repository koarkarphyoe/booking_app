import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:student_app/persistence/hive_constants.dart';
import 'casts_vo.dart';
part 'movie_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: hiveTypeIdMovieVO, adapterName: "MovieVOAdapter")
class MovieVO {
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

  @JsonKey(name: "rating")
  @HiveField(7)
  double? rating;

  @JsonKey(name: "runtime")
  @HiveField(8)
  int? runtime;

  @JsonKey(name: "overview")
  @HiveField(9)
  String? overview;

  @JsonKey(name: "casts")
  @HiveField(10)
  List<CastsVO>? casts;

  MovieVO(this.id, this.originalTitle, this.releaseDate, this.genres,
      this.posterPath, this.isCurrentMovie, this.isComingSoonMovie);

  factory MovieVO.fromJson(Map<String, dynamic> json) => _$MovieVOFromJson(json);

  Map<String, dynamic> toJson() => _$MovieVOToJson(this);
}
