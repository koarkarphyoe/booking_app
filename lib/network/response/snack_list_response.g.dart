// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snack_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SnackListResponse _$SnackListResponseFromJson(Map<String, dynamic> json) =>
    SnackListResponse(
      (json['data'] as List<dynamic>)
          .map((e) => SnackVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SnackListResponseToJson(SnackListResponse instance) =>
    <String, dynamic>{
      'data': instance.snackList,
    };
