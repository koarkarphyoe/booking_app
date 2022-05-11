// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_method_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaymentMethodVOAdapter extends TypeAdapter<PaymentMethodVO> {
  @override
  final int typeId = 10;

  @override
  PaymentMethodVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PaymentMethodVO(
      fields[0] as int?,
      fields[1] as String?,
      fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PaymentMethodVO obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentMethodVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMethodVO _$PaymentMethodVOFromJson(Map<String, dynamic> json) =>
    PaymentMethodVO(
      json['id'] as int?,
      json['name'] as String?,
      json['description'] as String?,
    );

Map<String, dynamic> _$PaymentMethodVOToJson(PaymentMethodVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };
