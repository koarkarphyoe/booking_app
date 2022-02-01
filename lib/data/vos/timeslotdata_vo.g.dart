// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeslotdata_vo.dart';

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
