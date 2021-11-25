// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmailResponse _$EmailResponseFromJson(Map<String, dynamic> json) =>
    EmailResponse(
      json['code'] as int?,
      json['message'] as String?,
      json['data'] == null
          ? null
          : UserVO.fromJson(json['data'] as Map<String, dynamic>),
      json['token'] as String?,
    );

Map<String, dynamic> _$EmailResponseToJson(EmailResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
      'token': instance.token,
    };
