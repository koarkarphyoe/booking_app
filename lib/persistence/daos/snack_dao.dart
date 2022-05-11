import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'package:student_app/data/vos/snack_vo.dart';
import 'package:student_app/persistence/hive_constants.dart';

class SnackDao {
  static final SnackDao _singleton = SnackDao._internal();
  factory SnackDao() {
    return _singleton;
  }
  SnackDao._internal();

  void saveAllSnack(List<SnackVO> snackList) async {
    Map<int, SnackVO> snackMap = Map.fromIterable(snackList,
        key: (snack) => snack.id, value: (snack) => snack);
    await getSnackBox().putAll(snackMap);
  }

  List<SnackVO> getAllSnack() {
    return getSnackBox().values.toList();
  }

  //Reactive Programming
  Stream<List<SnackVO>> getAllSnackListStream() {
    return getSnackBox()
        .watch()
        .map((event) => getAllSnack())
        .startWith(getAllSnack());
  }

  Box<SnackVO> getSnackBox() {
    return Hive.box<SnackVO>(boxNameSnackVO);
  }
}
