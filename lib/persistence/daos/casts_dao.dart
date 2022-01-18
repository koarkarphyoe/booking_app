import 'package:hive/hive.dart';
import 'package:student_app/data/vos/casts_vo.dart';

import '../hive_constants.dart';

class CastsDao {
  static final CastsDao _singleton = CastsDao._internal();
  factory CastsDao() {
    return _singleton;
  }

  CastsDao._internal();

  void saveAllCasts(List<CastsVO> castsList) async {
    Map<int, CastsVO> castsMap = Map.fromIterable(castsList,
        key: (casts) => casts.id, value: (casts) => casts);
    await getCastsBox().putAll(castsMap);
  }

  List<CastsVO> getCasts() {
    return getCastsBox().values.toList();
  }

  Box<CastsVO> getCastsBox() {
    return Hive.box<CastsVO>(boxNameCastsVO);
  }
}
