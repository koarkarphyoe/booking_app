import 'package:json_annotation/json_annotation.dart';
import 'package:student_app/data/vos/casts_vo.dart';
import 'package:student_app/data/vos/data_vo.dart';
part 'movie_details_vo.g.dart';

@JsonSerializable()
class MovieDetailsVO extends DataVO {
  @JsonKey(name: "rating")
  double? rating;

  @JsonKey(name: "runtime")
  int? runtime;

  @JsonKey(name: "overview")
  String? overview;

  @JsonKey(name: "casts")
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
      : super(id, originalTitle, releaseDate, genres,
            posterPath, isCurrentMovie, isComingSoonMovie);

  factory MovieDetailsVO.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsVOFromJson(json);
  
  @override
  Map<String, dynamic> toJson() => _$MovieDetailsVOToJson(this);
}
