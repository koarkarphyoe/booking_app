import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app/bloc/timeslots_bloc.dart';
import 'package:student_app/data/vos/date_vo.dart';
import 'package:student_app/data/vos/timeslotdata_vo.dart';
import 'package:student_app/resources/colors.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/widgets/title_text_bold.dart';
import '../resources/strings.dart';
import '../widgets/confirm_button_view.dart';
import 'movie_seats_page.dart';

class MovieChooseTime extends StatelessWidget {
  final dynamic movieDetails;
  const MovieChooseTime(this.movieDetails, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: TimeSlotsBloc(),
      child: Scaffold(
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
          body: Consumer<TimeSlotsBloc>(
            builder: (BuildContext context, mCinemaList, Widget? child) {
              return (mCinemaList.cinemaList != null)
                  ? SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Selector<TimeSlotsBloc, List<DateVO?>?>(
                                selector: (p0, p1) => p1.dateList,
                                builder: (BuildContext context, dateList,
                                    Widget? child) {
                                  return MovieDateChooseSectionView(dateList,
                                      (dateId) {
                                    TimeSlotsBloc bloc =
                                        Provider.of(context, listen: false);
                                    bloc.onTapDate(dateId);
                                  });
                                },
                              ),
                              Selector<TimeSlotsBloc, List<TimeSlotDataVO>?>(
                                shouldRebuild: (previous, next) => false,
                                selector: (p0, p1) => p1.cinemaList,
                                builder: (BuildContext context, cinemaList,
                                    Widget? child) {
                                  return ChooseItemGridSectionView(cinemaList,
                                      (timeSlotsId, cinemaId) {
                                    TimeSlotsBloc bloc =
                                        Provider.of(context, listen: false);
                                    bloc.onTapTime(timeSlotsId, cinemaId);
                                  });
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: marginMedium,
                                    vertical: marginMedium2X),
                                child: Selector<TimeSlotsBloc,
                                    List<TimeSlotDataVO>?>(
                                  selector: (p0, p1) => p1.cinemaList,
                                  builder: (BuildContext context, bloc,
                                      Widget? child) {
                                    return ConfirmButtonView(
                                      buttonNextText,
                                      () {
                                        TimeSlotsBloc bloc =
                                            Provider.of(context, listen: false);
                                        if (bloc.cinemaNameForMovieSeatsPage ==
                                                null &&
                                            bloc.cinemaIdForMovieSeatsPage ==
                                                null) {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return const AlertDialog(
                                                title: Text("Sorry!"),
                                                content: Text(
                                                    "Please choose time from one of the Cineam !"),
                                              );
                                            },
                                          );
                                        } else {
                                          _navigateToMovieSeatsPage(
                                              context,
                                              bloc.cinemaNameForMovieSeatsPage,
                                              bloc.dateForMovieSeatsPage,
                                              bloc.timeForMovieSeatsPage,
                                              bloc.cinemaIdForMovieSeatsPage,
                                              bloc.yMdForMovieSeatsPage,
                                              bloc.cinemaTimeSlotsIdForMovieSeatsPage);
                                        }
                                      },
                                      isGhostButton: true,
                                      buttonBackgroundColor: primaryColor,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            },
          )),
    );
  }

  _navigateToMovieSeatsPage(BuildContext context, String? cinemaName,
      String? date, String? time, int? cinemaId, String? yMd, int? timeSlotId) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieSeatsPage(
            movieDetails, cinemaName, date, time, cinemaId, yMd, timeSlotId),
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
