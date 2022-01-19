import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:student_app/data/vos/casts_vo.dart';
import 'package:student_app/data/vos/data_vo.dart';
import 'package:student_app/page/movie_details_page.dart';
import 'package:student_app/persistence/hive_constants.dart';
part 'movie_details_vo.g.dart';

@JsonSerializable()
@HiveType(
    typeId: hiveTypeIdMovieDetailsVO, adapterName: "MovieDetailsVOAdapter")
class MovieDetailsVO extends DataVO {
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

  MovieDetailsVO(
      this.rating,
      this.runtime,
      int? id,
      String? originalTitle,
      String? releaseDate,
      List<String>? genres,
      String? posterPath,
      bool? isCurrentMovie,
      bool? isComingSoonMovie)
      : super(id, originalTitle, releaseDate, genres, posterPath,
            isCurrentMovie, isComingSoonMovie);

  factory MovieDetailsVO.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsVOFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MovieDetailsVOToJson(this);

  map(GenreListView Function(dynamic e) param0) {}
}
