class CastsDao {
  static final CastsDao _singleton = CastsDao._internal();

  factory CastsDao() {
    return _singleton;
  }
  CastsDao._internal();
}
