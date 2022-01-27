import 'package:json_annotation/json_annotation.dart';
import 'package:student_app/data/vos/timeslots_vo.dart';

part 'timeslotdata_vo.g.dart';

@JsonSerializable()
class TimeSlotDataVO {
  @JsonKey(name: "cinema_id")
  int? cinemaId;

  @JsonKey(name: "cinema")
  String? cinema;

  @JsonKey(name: "timeslots")
  List<TimeslotsVO>? timeslots;

  TimeSlotDataVO(this.cinemaId, this.cinema, this.timeslots);

  factory TimeSlotDataVO.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotDataVOFromJson(json);

  Map<String, dynamic> toJson() => _$TimeSlotDataVOToJson(this);
}
