// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailsVO _$MovieDetailsVOFromJson(Map<String, dynamic> json) =>
    MovieDetailsVO(
      (json['rating'] as num?)?.toDouble(),
      json['runtime'] as int?,
      json['id'] as int?,
      json['original_title'] as String?,
      json['release_date'] as String?,
      (json['genres'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['poster_path'] as String?,
      json['isCurrentMovie'] as bool?,
      json['isComingSoonMovie'] as bool?,
    )
      ..overview = json['overview'] as String?
      ..casts = (json['casts'] as List<dynamic>?)
          ?.map((e) => CastsVO.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$MovieDetailsVOToJson(MovieDetailsVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'original_title': instance.originalTitle,
      'release_date': instance.releaseDate,
      'genres': instance.genres,
      'poster_path': instance.posterPath,
      'isCurrentMovie': instance.isCurrentMovie,
      'isComingSoonMovie': instance.isComingSoonMovie,
      'rating': instance.rating,
      'runtime': instance.runtime,
      'overview': instance.overview,
      'casts': instance.casts,
    };
