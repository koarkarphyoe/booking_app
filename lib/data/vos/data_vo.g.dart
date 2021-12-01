// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataVO _$DataVOFromJson(Map<String, dynamic> json) => DataVO(
      json['id'] as int?,
      json['original_title'] as String?,
      json['release_date'] as String?,
      (json['genres'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['poster_path'] as String?,
    );

Map<String, dynamic> _$DataVOToJson(DataVO instance) => <String, dynamic>{
      'id': instance.id,
      'original_title': instance.originalTitle,
      'release_date': instance.releaseDate,
      'genres': instance.genres,
      'poster_path': instance.posterPath,
    };
