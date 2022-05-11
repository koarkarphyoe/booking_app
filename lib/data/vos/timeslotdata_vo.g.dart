// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeslotdata_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimeSlotDataVOAdapter extends TypeAdapter<TimeSlotDataVO> {
  @override
  final int typeId = 7;

  @override
  TimeSlotDataVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimeSlotDataVO(
      fields[0] as int?,
      fields[1] as String?,
      (fields[2] as List?)?.cast<TimeslotsVO?>(),
    );
  }

  @override
  void write(BinaryWriter writer, TimeSlotDataVO obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.cinemaId)
      ..writeByte(1)
      ..write(obj.cinema)
      ..writeByte(2)
      ..write(obj.timeslots);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeSlotDataVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeSlotDataVO _$TimeSlotDataVOFromJson(Map<String, dynamic> json) =>
    TimeSlotDataVO(
      json['cinema_id'] as int?,
      json['cinema'] as String?,
      (json['timeslots'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : TimeslotsVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TimeSlotDataVOToJson(TimeSlotDataVO instance) =>
    <String, dynamic>{
      'cinema_id': instance.cinemaId,
      'cinema': instance.cinema,
      'timeslots': instance.timeslots,
    };
