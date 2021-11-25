// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardVO _$CardVOFromJson(Map<String, dynamic> json) => CardVO(
      json['id'] as int?,
      json['card_holder'] as String?,
      json['card_number'] as String?,
      json['expiration_date'] as String?,
      json['card_type'] as String?,
    );

Map<String, dynamic> _$CardVOToJson(CardVO instance) => <String, dynamic>{
      'id': instance.id,
      'card_holder': instance.cardHolder,
      'card_number': instance.cardNumber,
      'expiration_date': instance.expirationDate,
      'card_type': instance.cardType,
    };
