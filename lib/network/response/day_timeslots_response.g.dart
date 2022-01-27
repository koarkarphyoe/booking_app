// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_timeslots_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DayTimeslotsResponse _$DayTimeslotsResponseFromJson(
        Map<String, dynamic> json) =>
    DayTimeslotsResponse(
      json['code'] as int?,
      json['message'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => TimeSlotDataVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DayTimeslotsResponseToJson(
        DayTimeslotsResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
