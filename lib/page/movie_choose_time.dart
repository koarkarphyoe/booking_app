import 'package:flutter/material.dart';
import 'package:student_app/data/model/data_models.dart';
import 'package:student_app/data/model/data_models_impl.dart';
import 'package:student_app/data/vos/date_vo.dart';
import 'package:student_app/data/vos/movie_details_vo.dart';
import 'package:student_app/data/vos/timeslotdata_vo.dart';
import 'package:student_app/data/vos/timeslots_vo.dart';
import 'package:student_app/resources/colors.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/resources/strings.dart';
import 'package:student_app/widgets/confirm_button_view.dart';
import 'package:student_app/widgets/title_text_bold.dart';

class MovieChooseTime extends StatefulWidget {
  final MovieDetailsVO movieDetails;
  const MovieChooseTime(this.movieDetails, {Key? key}) : super(key: key);

  @override
  State<MovieChooseTime> createState() => _MovieChooseTimeState();
}

class _MovieChooseTimeState extends State<MovieChooseTime> {
  DataModels mDataModels = DataModelsImpl();

  // List<CinemasVO?>? cinemas;
  List<TimeSlotDataVO>? cinemaList;
  TimeslotsVO? timeSlots;
  List<DateVO?>? dateList;
  DateVO? selectedDate;
  TimeSlotDataVO? selectedCinemaTime;

  @override
  void initState() {
    super.initState();

    // this api not use for cinema names (only testing api)
    // mDataModels.getCinemasList()?.then((value) {
    //   setState(() {
    //     cinemas = value;
    //   });
    // });

    // take dateList from dateVO
    dateList = mDataModels.getDates();

    // firstly,to get the cinemaList data from api,so it is need => date String
    selectedDate = dateList?.first;

    //to use for first date auto selected
    selectedDate?.isSelected = true;

    // this api use for cinema names
    mDataModels
        .getCinemaNameAndTimeSlots(selectedDate?.yMd.toString())
        ?.then((value) {
      setState(() {
        cinemaList = value;
      });
    });
  }

  _selectDate(int dateId) {
    setState(
      () {
        //second method for time choosing
        dateList = dateList?.map((date) {
          date?.isSelected = false;
          print("setState condition in UI before tapping by user");
          if (date?.id == dateId) {
            date?.isSelected = true;
            print("setState condition in UI after tapping by user");
          }
          return date;
        }).toList();

        //first method for date choosing
        // selectedDate = dateList!.firstWhere((element) => element.id == dateId);
        //Reset all selected date when user chage tapping on date!
        // dateList?.forEach((element) => element.isSelected = false);
        //isSelected is false in DateVO,now it is setup to true to handle the color of date when select the date from the user!
        // selectedDate?.isSelected = true;
        //to show and test actual date in console!
        // debugPrint(selectedDate?.yMd.toString());
        // debugPrint("DateVO id is ${selectedDate?.id.toString()}");

        // this api use for cinema names and user behavior in selecting date and time to request movie timeSlots
        // it is need to call again in setState bcoz timeSlots will different by following user selected date from Api
        mDataModels
            .getCinemaNameAndTimeSlots(selectedDate?.yMd.toString())
            ?.then(
          (value) {
            setState(
              () {
                cinemaList = value;
                //to test time slot Id from api
                // ignore: avoid_print
                // print(
                // "cinema_day_timeslot_id is ${cinemaList?.first.timeslots?[1]?.cinemaDayTimeslotId}");
              },
            );
          },
        );
      },
    );
  }

  _selectTime(int? timeSlotsId, int? cinemaId) {
    setState(
      () {
        //Method 1 can use
        cinemaList = cinemaList?.map(
          (cinema) {
            cinema.timeslots?.map(
              (timeSlots) {
                timeSlots?.isSelected = false;
                if (timeSlots?.cinemaDayTimeslotId == timeSlotsId) {
                  timeSlots?.isSelected = true;
                  print(
                      "Cinema Id is ${cinemaId.toString()} and TimeSlots id is ${timeSlots?.cinemaDayTimeslotId.toString()}");
                }
              },
            ).toList();
            return cinema;
          },
        ).toList();

        //Method 2 also can use
        //Already test and get the result!
        // cinemaList = cinemaList?.map(
        //   (cinema) {
        //     cinema.timeslots?.map(
        //       (timeSlotsId) {
        //         timeSlotsId?.isSelected = false;
        //       },
        //     ).toList();
        //     return cinema;
        //   },
        // ).toList();

        // selectedCinemaTime =
        //     cinemaList?.firstWhere((element) => element.cinemaId == cinemaId);
        // selectedCinemaTime?.timeslots
        //     ?.firstWhere(
        //         (element) => element?.cinemaDayTimeslotId == timeSlotsId)
        //     ?.isSelected = true;
      },
    );

    //Method 3
    //Reset unselected time button colors
    // cinemaList?.forEach((element) {
    //   element.timeslots?.forEach((element) {
    //     element?.isSelected = false;
    //   });
    //   element.timeslots?.forEach((element) {
    //     if (element?.cinemaDayTimeslotId == timeSlotsId) {
    //       element?.isSelected = true;
    //     }
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        leading: GestureDetector(
          onTap: () {
            _navigateToPreviousPage(context);
          },
          child: const Icon(
            Icons.chevron_left,
            size: paymentPageBackButtonIconSize,
            color: Colors.white,
          ),
        ),
      ),
      body: (cinemaList != null)
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MovieDateChooseSectionView(
                          dateList, (dateId) => _selectDate(dateId)),
                      ChooseItemGridSectionView(
                          cinemaList,
                          (timeSlotsId, cinemaId) =>
                              _selectTime(timeSlotsId, cinemaId)),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: marginMedium, vertical: marginMedium2X),
                        child: ConfirmButtonView(
                          buttonNextText,
                          () {},
                          isGhostButton: true,
                          buttonBackgroundColor: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  void _navigateToPreviousPage(BuildContext context) => Navigator.pop(context);
}

class ChooseItemGridSectionView extends StatelessWidget {
  final List<TimeSlotDataVO>? cinemaList;
  final Function(int?, int?) selectTime;
  const ChooseItemGridSectionView(this.cinemaList, this.selectTime);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: cinemaList!
          .map((cinema) => CinemaNameView(cinema, selectTime))
          .toList(),
    );
  }
}

class CinemaNameView extends StatefulWidget {
  const CinemaNameView(this.cinema, this.selectedTime);
  final TimeSlotDataVO? cinema;
  final Function(int?, int?) selectedTime;

  @override
  State<CinemaNameView> createState() => _CinemaNameViewState();
}

class _CinemaNameViewState extends State<CinemaNameView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: marginSmall, vertical: marginSmall),
            child: TitleTextBold(
              widget.cinema!.cinema.toString(),
              textColor: Colors.black,
              textSize: textRegular1X,
            )),
        GridView.builder(
          itemCount: widget.cinema?.timeslots?.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                widget.selectedTime(
                    widget.cinema?.timeslots?[index]?.cinemaDayTimeslotId,
                    widget.cinema?.cinemaId);
              },
              child: Container(
                margin: const EdgeInsets.only(
                    top: marginMedium, left: marginMedium, right: marginMedium),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                  color: (widget.cinema!.timeslots![index]!.isSelected!)
                      ? primaryColor
                      : null,
                ),
                child: Center(
                  child: Text(
                    widget.cinema!.timeslots![index]!.startTime.toString(),
                    style: TextStyle(
                      color: (widget.cinema!.timeslots![index]!.isSelected!)
                          ? Colors.white
                          : null,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class MovieDateChooseSectionView extends StatefulWidget {
  final List<DateVO?>? dateList;
  final Function(int) selectDate;
  const MovieDateChooseSectionView(
    this.dateList,
    this.selectDate, {
    Key? key,
  }) : super(key: key);

  @override
  State<MovieDateChooseSectionView> createState() =>
      _MovieDateChooseSectionViewState();
}

class _MovieDateChooseSectionViewState
    extends State<MovieDateChooseSectionView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      height: movieDateChooseContainerHeight,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: marginMedium),
        scrollDirection: Axis.horizontal,
        children: widget.dateList!
            .map(
              (e) => DateView(
                e,
                (dateId) => widget.selectDate(dateId),
              ),
            )
            .toList(),
      ),
      // child: ListView.separated(
      //   padding: const EdgeInsets.symmetric(horizontal: marginMedium),
      //   separatorBuilder: (context, index) {
      //     return const SizedBox(width: marginMedium);
      //   },
      //   scrollDirection: Axis.horizontal,
      //   itemCount: dateList!.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     return Column(
      //       children: const [
      //         TitleText(
      //           "Wed",
      //           textSize: textRegular,
      //         ),
      //         SizedBox(
      //           height: marginMedium,
      //         ),
      //         TitleText(
      //           "10",
      //           textSize: textRegular,
      //         ),
      //       ],
      //     );
      //   },
      // ),
    );
  }
}

class DateView extends StatelessWidget {
  final DateVO? date;
  final Function(int) selectDate;

  const DateView(
    this.date,
    this.selectDate, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: marginMedium),
      child: GestureDetector(
        onTap: () {
          selectDate(date!.id);
        },
        child: Column(
          children: [
            Text(
              date!.day,
              style: TextStyle(
                  fontSize: (date!.isSelected) ? textRegular4X : textRegular,
                  color:
                      (date!.isSelected) ? Colors.white : paymentCardIconColor),
            ),
            const SizedBox(
              height: marginMedium,
            ),
            Text(
              date!.date,
              style: TextStyle(
                  fontSize: (date!.isSelected) ? textRegular4X : textRegular,
                  color:
                      (date!.isSelected) ? Colors.white : paymentCardIconColor),
            ),
          ],
        ),
      ),
    );
  }
}
