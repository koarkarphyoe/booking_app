import 'package:json_annotation/json_annotation.dart';
import 'package:student_app/data/vos/timeslotdata_vo.dart';
part 'day_timeslots_response.g.dart';

@JsonSerializable()
class DayTimeslotsResponse {
  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "data")
  List<TimeSlotDataVO>? data;

  DayTimeslotsResponse(this.code, this.message, this.data);

  factory DayTimeslotsResponse.fromJson(Map<String, dynamic> json) =>
      _$DayTimeslotsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DayTimeslotsResponseToJson(this);
}
