// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieDetailsVOAdapter extends TypeAdapter<MovieDetailsVO> {
  @override
  final int typeId = 4;

  @override
  MovieDetailsVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieDetailsVO(
      fields[7] as double?,
      fields[8] as int?,
      fields[0] as int?,
      fields[1] as String?,
      fields[2] as String?,
      (fields[3] as List?)?.cast<String>(),
      fields[4] as String?,
      fields[5] as bool?,
      fields[6] as bool?,
    )
      ..overview = fields[9] as String?
      ..casts = (fields[10] as List?)?.cast<CastsVO>();
  }

  @override
  void write(BinaryWriter writer, MovieDetailsVO obj) {
    writer
      ..writeByte(11)
      ..writeByte(7)
      ..write(obj.rating)
      ..writeByte(8)
      ..write(obj.runtime)
      ..writeByte(9)
      ..write(obj.overview)
      ..writeByte(10)
      ..write(obj.casts)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.originalTitle)
      ..writeByte(2)
      ..write(obj.releaseDate)
      ..writeByte(3)
      ..write(obj.genres)
      ..writeByte(4)
      ..write(obj.posterPath)
      ..writeByte(5)
      ..write(obj.isCurrentMovie)
      ..writeByte(6)
      ..write(obj.isComingSoonMovie);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieDetailsVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
