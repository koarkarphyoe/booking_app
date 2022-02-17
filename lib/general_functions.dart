class Functions {
  String formatDate(String date) {
    List<String> dateList = date.split("/");
    List<String> newDateList = [dateList[2], dateList[0], dateList[1]];
    String dateFormat = newDateList.join('/');
    return dateFormat;
  }
}
