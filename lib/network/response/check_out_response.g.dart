// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_out_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckOutResponse _$CheckOutResponseFromJson(Map<String, dynamic> json) =>
    CheckOutResponse(
      json['code'] as int?,
      json['data'] == null
          ? null
          : VoucherVO.fromJson(json['data'] as Map<String, dynamic>),
      json['message'] as String?,
    );

Map<String, dynamic> _$CheckOutResponseToJson(CheckOutResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
