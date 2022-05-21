import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'package:student_app/data/vos/timeslotdata_vo.dart';
import 'package:student_app/persistence/hive_constants.dart';

class TimeSlotDao {
  static final TimeSlotDao _singleton = TimeSlotDao._internal();
  factory TimeSlotDao() {
    return _singleton;
  }
  TimeSlotDao._internal();

  void saveAllCinemasList(List<TimeSlotDataVO> timeSlot, String date) async {
    Map<int, TimeSlotDataVO> timeSlotMap = { for (var timeSlot in timeSlot) timeSlot.cinemaId! : timeSlot };
    await getCinemaBox().putAll(timeSlotMap);
  }

  List<TimeSlotDataVO> getCinemasList(String date) {
    return getCinemaBox().values.toList();
  }

  //Reactive Programming

  Stream<List<TimeSlotDataVO>> getCinemaTimeSlotStream(String date) {
    return getCinemaBox()
        .watch()
        .map((event) => getCinemasList(date))
        .startWith(getCinemasList(date));
  }

  Box<TimeSlotDataVO> getCinemaBox() {
    return Hive.box<TimeSlotDataVO>(boxNameCinemaTimeSlotDataVO);
  }
}
