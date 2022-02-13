// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snack_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SnackVO _$SnackVOFromJson(Map<String, dynamic> json) => SnackVO(
      json['id'] as int?,
      json['name'] as String?,
      json['description'] as String?,
      json['price'] as int?,
      json['image'] as String?,
      quantity: json['quantity'] as int? ?? 0,
      totalCharges: (json['totalCharges'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$SnackVOToJson(SnackVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'image': instance.image,
      'quantity': instance.quantity,
      'totalCharges': instance.totalCharges,
    };
