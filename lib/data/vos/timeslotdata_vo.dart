import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:student_app/data/vos/timeslots_vo.dart';
import 'package:student_app/persistence/hive_constants.dart';

part 'timeslotdata_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: hiveTypeIdTimeSlotDataVO,adapterName: "TimeSlotDataVOAdapter")
class TimeSlotDataVO {
  @JsonKey(name: "cinema_id")
  @HiveField(0)
  int? cinemaId;

  @JsonKey(name: "cinema")
  @HiveField(1)
  String? cinema;

  @JsonKey(name: "timeslots")
  @HiveField(2)
  List<TimeslotsVO?>? timeslots;

  TimeSlotDataVO(this.cinemaId, this.cinema, this.timeslots);

  factory TimeSlotDataVO.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotDataVOFromJson(json);

  Map<String, dynamic> toJson() => _$TimeSlotDataVOToJson(this);
}
