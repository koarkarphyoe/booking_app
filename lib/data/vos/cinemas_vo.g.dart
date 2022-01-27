// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinemas_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CinemasVO _$CinemasVOFromJson(Map<String, dynamic> json) => CinemasVO(
      json['id'] as int,
      json['name'] as String,
      json['phone'] as String,
      json['email'] as String,
      json['address'] as String,
    );

Map<String, dynamic> _$CinemasVOToJson(CinemasVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
      'address': instance.address,
    };
