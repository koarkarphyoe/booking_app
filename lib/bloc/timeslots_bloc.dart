import 'package:flutter/material.dart';
import '../data/model/data_models.dart';
import '../data/model/data_models_impl.dart';
import '../data/vos/date_vo.dart';
import '../data/vos/timeslotdata_vo.dart';

class TimeSlotsBloc extends ChangeNotifier {
  //Model
  DataModels mDataModels = DataModelsImpl();

  //State
  List<TimeSlotDataVO>? cinemaList;
  List<DateVO?>? dateList;

  DateVO? selectedDate;
  // Send data to MovieSeatsPage
  String? dateForMovieSeatsPage;
  String? timeForMovieSeatsPage;
  String? cinemaNameForMovieSeatsPage;
  int? cinemaIdForMovieSeatsPage;
  int? cinemaTimeSlotsIdForMovieSeatsPage;
  String? yMdForMovieSeatsPage;

  TimeSlotsBloc() {
    // take dateList from dateVO
    dateList = mDataModels.getDates();
    // firstly,to get the cinemaList data from api,so it is need => date String
    selectedDate = dateList?.first;
    //to use for first date auto selected
    selectedDate?.isSelected = true;
    dateForMovieSeatsPage = selectedDate?.dayMonthDate;
    yMdForMovieSeatsPage = selectedDate?.yMd;

    mDataModels
        .getCinemasListFromDatabase(selectedDate!.yMd.toString())
        .listen((value) {
      cinemaList = value;
      notifyListeners();
    });
  }

  void onTapDate(int dateId) {
    _selectDate(dateId);
    
  }

  _selectDate(int dateId) {
    //second method for time choosing
    dateList = dateList?.map(
      (date) {
        date?.isSelected = false;
        if (date?.id == dateId) {
          date?.isSelected = true;
          dateForMovieSeatsPage = date?.dayMonthDate; //for single select
          yMdForMovieSeatsPage = date?.yMd;
          notifyListeners();
          // From database
          mDataModels
              .getCinemasListFromDatabase(date!.yMd.toString())
              .listen((value) {
            cinemaList = value;
            // cinemaList
            //     ?.map(
            //       (e) => e.timeslots?.map((e) {
            //         e?.isSelected = true;
            //         timeForMovieSeatsPage = e?.startTime;
            //       }),
            //     )
            //     .toList();
          });
        }
        return date;
      },
    ).toList();
    notifyListeners();
  }

  void onTapTime(int? timeSlotsId, int? cinemaId) {
    _selectTime(timeSlotsId, cinemaId);
  }

  _selectTime(int? timeSlotsId, int? cinemaId) {
    //Method 1 can use
    cinemaList = cinemaList?.map(
      (cinema) {
        cinema.timeslots?.map(
          (timeSlots) {
            timeSlots?.isSelected =
                false; //if want double selecting,no need to use
            if (timeSlots?.cinemaDayTimeslotId == timeSlotsId) {
              timeSlots?.isSelected = true;
              timeForMovieSeatsPage = timeSlots?.startTime;
              cinemaNameForMovieSeatsPage = cinema.cinema;
              cinemaIdForMovieSeatsPage = cinema.cinemaId;
              cinemaTimeSlotsIdForMovieSeatsPage = timeSlotsId;
              print(
                  "CinemaTimeSlotsID is =>$cinemaTimeSlotsIdForMovieSeatsPage");
            }
          },
        ).toList();
        return cinema;
      },
    ).toList();
    notifyListeners();
  }
}
