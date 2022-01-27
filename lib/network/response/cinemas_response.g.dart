// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinemas_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CinemasResponse _$CinemasResponseFromJson(Map<String, dynamic> json) =>
    CinemasResponse(
      json['code'] as int,
      json['message'] as String,
      (json['data'] as List<dynamic>)
          .map((e) => CinemasVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CinemasResponseToJson(CinemasResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
