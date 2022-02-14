import 'package:json_annotation/json_annotation.dart';
import 'package:student_app/data/vos/card_vo.dart';
part 'card_list_response.g.dart';

@JsonSerializable()
class CardListResponse {
  @JsonKey(name: "data")
  List<CardVO>? data;

  CardListResponse(this.data);

   factory CardListResponse.fromJson(Map<String, dynamic> json) =>
      _$CardListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CardListResponseToJson(this);
}
