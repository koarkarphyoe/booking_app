import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:student_app/persistence/hive_constants.dart';
part 'timeslots_vo.g.dart';

@JsonSerializable()
@HiveType(typeId:hiveTypeIdTimeSlotVO,adapterName: "TimeslotsVOAdapter")
class TimeslotsVO {
  @JsonKey(name: "cinema_day_timeslot_id")
  @HiveField(0)
  int? cinemaDayTimeslotId;

  @JsonKey(name: "start_time")
  @HiveField(1)
  String? startTime;

  bool? isSelected;

  TimeslotsVO(this.cinemaDayTimeslotId, this.startTime, {this.isSelected=false});

  factory TimeslotsVO.fromJson(Map<String, dynamic> json) =>
      _$TimeslotsVOFromJson(json);

  Map<String, dynamic> toJson() => _$TimeslotsVOToJson(this);
}
