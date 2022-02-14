import 'package:json_annotation/json_annotation.dart';
import 'package:student_app/data/vos/payment_method_vo.dart';
part 'payment_method_response.g.dart';

@JsonSerializable()
class PaymentMethodResponse {
  @JsonKey(name: "data")
  List<PaymentMethodVO>? data;

  PaymentMethodResponse(this.data);

  factory PaymentMethodResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodResponseToJson(this);
}
