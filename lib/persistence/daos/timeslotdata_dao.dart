import 'package:hive/hive.dart';
import 'package:student_app/data/vos/timeslotdata_vo.dart';
import 'package:student_app/persistence/hive_constants.dart';

class TimeSlotDataDao {
  static final TimeSlotDataDao _singleton = TimeSlotDataDao._internal();

  factory TimeSlotDataDao() {
    return _singleton;
  }

  TimeSlotDataDao._internal();

  void saveAllTimeSlotData(List<TimeSlotDataVO> timeSlotDataList) async {
    Map<int, TimeSlotDataVO> timeSlotDataMap = {
      for (var timeslot in timeSlotDataList) timeslot.cinemaId!.toInt(): timeslot
    };
    await getTimeSlotDataBox().putAll(timeSlotDataMap);
  }

  List<TimeSlotDataVO> getAllTimeSlotData() {
    return getTimeSlotDataBox().values.toList();
  }

  //Reactive programming
  Stream<void> getAllTimeSlotDataEventStream() {
    return getTimeSlotDataBox().watch();
  }

  Stream<List<TimeSlotDataVO>> getAllTimeSlotDataListStream() {
    return Stream.value(getTimeSlotDataBox().values.toList());
  }

  Box<TimeSlotDataVO> getTimeSlotDataBox() {
    return Hive.box<TimeSlotDataVO>(boxNameTimeSlotDataVO);
  }
}
