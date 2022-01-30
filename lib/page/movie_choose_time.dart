import 'package:flutter/material.dart';
import 'package:student_app/data/model/data_models.dart';
import 'package:student_app/data/model/data_models_impl.dart';
import 'package:student_app/data/vos/cinemas_vo.dart';
import 'package:student_app/data/vos/date_vo.dart';
import 'package:student_app/data/vos/movie_details_vo.dart';
import 'package:student_app/data/vos/timeslotdata_vo.dart';
import 'package:student_app/data/vos/timeslots_vo.dart';
import 'package:student_app/resources/colors.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/resources/strings.dart';
import 'package:student_app/widgets/confirm_button_view.dart';
import 'package:student_app/widgets/title_text.dart';
import 'package:student_app/widgets/title_text_bold.dart';

class MovieChooseTime extends StatefulWidget {
  final MovieDetailsVO movieDetails;
  const MovieChooseTime(this.movieDetails, {Key? key}) : super(key: key);

  @override
  State<MovieChooseTime> createState() => _MovieChooseTimeState();
}

class _MovieChooseTimeState extends State<MovieChooseTime> {
  DataModels mDataModels = DataModelsImpl();

  List<CinemasVO?>? cinemas;
  List<TimeSlotDataVO>? cinemaList;
  TimeslotsVO? timeSlots;
  List<DateVO>? dateList;

  @override
  void initState() {
    super.initState();

    // this api not use for cinema names
    mDataModels.getCinemasList()?.then((value) {
      setState(() {
        cinemas = value;
      });
    });
    // this api use for cinema names
    mDataModels.getCinemaNameAndTimeSlots()?.then((value) {
      setState(() {
        cinemaList = value;
      });
    });

    dateList = mDataModels.getDates();
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
      body: (cinemas != null && cinemaList != null)
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MovieDateChooseSectionView(dateList),
                      ChooseItemGridSectionView(cinemaList),
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

  const ChooseItemGridSectionView(this.cinemaList);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: cinemaList!.map((cinema) => CinemaNameView(cinema)).toList(),
    );
  }
}

class CinemaNameView extends StatelessWidget {
  const CinemaNameView(this.cinema);
  final TimeSlotDataVO? cinema;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: marginSmall, vertical: marginSmall),
            child: TitleTextBold(
              cinema!.cinema.toString(),
              textColor: Colors.black,
              textSize: textRegular1X,
            )),
        GridView.builder(
          itemCount: cinema?.timeslots?.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2,
          ),
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(
                  top: marginMedium, left: marginMedium, right: marginMedium),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  cinema!.timeslots![index].startTime.toString(),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class MovieDateChooseSectionView extends StatelessWidget {
  final List<DateVO>? dateList;
  const MovieDateChooseSectionView(
    this.dateList, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      height: movieDateChooseContainerHeight,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: marginMedium),
        scrollDirection: Axis.horizontal,
        children: dateList!.map((e) => DateView(e)).toList(),
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
  final DateVO date;
  const DateView(
    this.date, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: marginMedium),
      child: Column(
        children: [
          TitleText(
            date.day,
            textSize: textRegular,
          ),
          const SizedBox(
            height: marginMedium,
          ),
          TitleText(
            date.date,
            textSize: textRegular,
          ),
        ],
      ),
    );
  }
}
