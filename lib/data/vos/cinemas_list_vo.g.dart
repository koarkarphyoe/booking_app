// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinemas_list_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CinemasListVO _$CinemasListVOFromJson(Map<String, dynamic> json) =>
    CinemasListVO(
      json['id'] as int,
      json['name'] as String,
      json['phone'] as String,
      json['email'] as String,
      json['address'] as String,
    );

Map<String, dynamic> _$CinemasListVOToJson(CinemasListVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
      'address': instance.address,
    };
