// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardListResponse _$CardListResponseFromJson(Map<String, dynamic> json) =>
    CardListResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) => CardVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CardListResponseToJson(CardListResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
