class DateVO {
  int id;
  String day;
  String date;
  String dayMonthDate;
  String yMd;
  bool isSelected;

  DateVO(this.id, this.day, this.date, this.dayMonthDate, this.yMd,
      {this.isSelected = false});
}
