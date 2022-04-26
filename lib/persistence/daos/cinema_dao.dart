import 'package:hive/hive.dart';
import 'package:student_app/data/vos/cinemas_vo.dart';
import 'package:student_app/persistence/hive_constants.dart';

class CinemaDao {
  static final CinemaDao _singleton = CinemaDao._internal();

  factory CinemaDao() {
    return _singleton;
  }

  CinemaDao._internal();

  void saveAllCinema(List<CinemasVO> cinemaList) async {
    // Map<int, CinemasVO> cinemaMap = Map.fromIterable(cinemaList,
    //     key: (cinema) => cinema.id, value: (cinema) => cinema);

    Map<int, CinemasVO> cinemaMap = {
      for (var cinema in cinemaList) cinema.id: cinema
    };

    await getCinemaBox().putAll(cinemaMap);
  }

  List<CinemasVO> getCinemaList() {
    return getCinemaBox().values.toList();
  }

  Stream<void> getAllCinemaListEventStream() {
    return getCinemaBox().watch();
  }

  Stream<List<CinemasVO>> getAllCinemaListStream() {
    return Stream.value(getCinemaBox().values.toList());
  }

  Box<CinemasVO> getCinemaBox() {
    return Hive.box<CinemasVO>(boxNameCinemaVO);
  }
}
