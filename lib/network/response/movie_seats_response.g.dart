// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_seats_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieSeatsResponse _$MovieSeatsResponseFromJson(Map<String, dynamic> json) =>
    MovieSeatsResponse(
      code: json['code'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>)
              .map((e) => MovieSeatListVO.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
    );

Map<String, dynamic> _$MovieSeatsResponseToJson(MovieSeatsResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
