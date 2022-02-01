import 'package:json_annotation/json_annotation.dart';
part 'timeslots_vo.g.dart';

@JsonSerializable()
class TimeslotsVO {
  @JsonKey(name: "cinema_day_timeslot_id")
  int? cinemaDayTimeslotId;

  @JsonKey(name: "start_time")
  String? startTime;

  bool? isSelected;

  TimeslotsVO(this.cinemaDayTimeslotId, this.startTime, {this.isSelected=false});

  factory TimeslotsVO.fromJson(Map<String, dynamic> json) =>
      _$TimeslotsVOFromJson(json);

  Map<String, dynamic> toJson() => _$TimeslotsVOToJson(this);
}
