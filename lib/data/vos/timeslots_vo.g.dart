// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeslots_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimeslotsVOAdapter extends TypeAdapter<TimeslotsVO> {
  @override
  final int typeId = 7;

  @override
  TimeslotsVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimeslotsVO(
      fields[0] as int?,
      fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TimeslotsVO obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.cinemaDayTimeslotId)
      ..writeByte(1)
      ..write(obj.startTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeslotsVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeslotsVO _$TimeslotsVOFromJson(Map<String, dynamic> json) => TimeslotsVO(
      json['cinema_day_timeslot_id'] as int?,
      json['start_time'] as String?,
      isSelected: json['isSelected'] as bool? ?? false,
    );

Map<String, dynamic> _$TimeslotsVOToJson(TimeslotsVO instance) =>
    <String, dynamic>{
      'cinema_day_timeslot_id': instance.cinemaDayTimeslotId,
      'start_time': instance.startTime,
      'isSelected': instance.isSelected,
    };
