// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DataVOAdapter extends TypeAdapter<DataVO> {
  @override
  final int typeId = 3;

  @override
  DataVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataVO(
      fields[0] as int?,
      fields[1] as String?,
      fields[2] as String?,
      (fields[3] as List?)?.cast<String>(),
      fields[4] as String?,
      fields[5] as bool?,
      fields[6] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, DataVO obj) {
    writer
      ..writeByte(7)
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
      other is DataVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataVO _$DataVOFromJson(Map<String, dynamic> json) => DataVO(
      json['id'] as int?,
      json['original_title'] as String?,
      json['release_date'] as String?,
      (json['genres'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['poster_path'] as String?,
      json['isCurrentMovie'] as bool?,
      json['isComingSoonMovie'] as bool?,
    );

Map<String, dynamic> _$DataVOToJson(DataVO instance) => <String, dynamic>{
      'id': instance.id,
      'original_title': instance.originalTitle,
      'release_date': instance.releaseDate,
      'genres': instance.genres,
      'poster_path': instance.posterPath,
      'isCurrentMovie': instance.isCurrentMovie,
      'isComingSoonMovie': instance.isComingSoonMovie,
    };
