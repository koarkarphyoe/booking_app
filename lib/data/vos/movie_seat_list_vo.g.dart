// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_seat_list_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieSeatListVO _$MovieSeatListVOFromJson(Map<String, dynamic> json) =>
    MovieSeatListVO(
      id: json['id'] as int?,
      text: json['text'] as String?,
      seatName: json['seat_name'] as String?,
      symbol: json['symbol'] as String?,
      price: json['price'] as int?,
    );

Map<String, dynamic> _$MovieSeatListVOToJson(MovieSeatListVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'seat_name': instance.seatName,
      'symbol': instance.symbol,
      'price': instance.price,
    };
