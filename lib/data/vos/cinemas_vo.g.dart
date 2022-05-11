// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinemas_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CinemasVOAdapter extends TypeAdapter<CinemasVO> {
  @override
  final int typeId = 6;

  @override
  CinemasVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CinemasVO(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CinemasVO obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.address);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CinemasVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CinemasVO _$CinemasVOFromJson(Map<String, dynamic> json) => CinemasVO(
      json['id'] as int,
      json['name'] as String,
      json['phone'] as String,
      json['email'] as String,
      json['address'] as String,
    );

Map<String, dynamic> _$CinemasVOToJson(CinemasVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
      'address': instance.address,
    };
