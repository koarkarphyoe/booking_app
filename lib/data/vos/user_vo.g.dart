// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVO _$UserVOFromJson(Map<String, dynamic> json) => UserVO(
      (json['cards'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : CardVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['email'] as String?,
      json['id'] as int?,
      json['name'] as String?,
      json['phone'] as String?,
      json['profile_image'] as String?,
      json['total_expense'] as int?,
    );

Map<String, dynamic> _$UserVOToJson(UserVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'total_expense': instance.totalExpense,
      'profile_image': instance.profileImage,
      'cards': instance.cards,
    };
