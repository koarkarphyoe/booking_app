// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app/bloc/seats_bloc.dart';
import 'package:student_app/data/vos/movie_seat_list_vo.dart';
import 'package:student_app/itemsview/movie_seat_item_view.dart';
import 'package:student_app/page/snacks_page.dart';
import 'package:student_app/resources/colors.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/widgets/confirm_button_view.dart';
import 'package:student_app/widgets/title_text.dart';
import 'package:student_app/widgets/title_text_bold.dart';

import '../itemsview/movie_seats_status.dart';
import '../resources/strings.dart';

class MovieSeatsPage extends StatelessWidget {
  final dynamic movieDetails;
  final dynamic cinemaName;
  final dynamic date;
  final dynamic time;
  final dynamic cinemaId;
  final dynamic yMd;
  final dynamic timeSlotsId;
  const MovieSeatsPage(this.movieDetails, this.cinemaName, this.date, this.time,
      this.cinemaId, this.yMd, this.timeSlotsId,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: SeatsBloc(cinemaId, yMd),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const BackButtonView(),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                MovieNameTimeAndCinemaSectionView(
                    movieDetails.originalTitle, cinemaName, date, time),
                const SizedBox(height: marginMedium1X),
                Consumer<SeatsBloc>(
                  builder: (BuildContext context, bloc, Widget? child) {
                    return MovieSeatsSectionView(
                        bloc.seatListForRow, bloc.rowNumbersListForGridView,
                        (seatName) {
                      bloc.onTapSeat(seatName!);
                    });
                  },
                ),
                const SizedBox(height: marginMedium),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: marginMedium),
                  child: Row(
                    children: [
                      const MovieSeatsStatusView(
                          movieSeatAvailableColor, movieSeatAvailable),
                      const SizedBox(
                        width: marginMediumXXXX,
                      ),
                      const MovieSeatsStatusView(
                          movieSeatReservedColor, movieSeatReserved),
                      const SizedBox(
                        width: marginMediumXXX,
                      ),
                      const MovieSeatsStatusView(
                          movieSeatTakenColor, movieSeatYourSelection)
                    ],
                  ),
                ),
                const SizedBox(height: marginMedium1X),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: marginMedium),
                  child: Consumer<SeatsBloc>(
                    builder: (BuildContext context, bloc, Widget? child) {
                      return TotalTicketAndSeatsTextView(
                          "Tickets", bloc.selectedSeat.length.toString());
                    },
                  ),
                ),
                const SizedBox(height: marginMedium),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: marginMedium),
                  child: Consumer<SeatsBloc>(
                    builder: (BuildContext context, bloc, Widget? child) {
                      return TotalTicketAndSeatsTextView(
                          "Seats", bloc.selectedSeat.map((e) => e).toString());
                    },
                  ),
                ),
                const SizedBox(
                  height: marginMedium,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: marginMedium),
                  child: Consumer<SeatsBloc>(
                    builder: (BuildContext context, bloc, Widget? child) {
                      return ConfirmButtonView(
                        "Buy Ticket for \$${bloc.totalSelectedSeatPrice.toString()}",
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SnacksPage(
                                bloc.selectedSeat.join(","),
                                bloc.totalSelectedSeatPrice,
                                movieDetails,
                                yMd,
                                time,
                                cinemaId,
                                timeSlotsId,
                              ),
                            ),
                          );
                        },
                        buttonBackgroundColor: primaryColor,
                      );
                    },
                  ),
                ),
                const SizedBox(height: marginMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BackButtonView extends StatelessWidget {
  const BackButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: const Icon(
        Icons.chevron_left,
        size: paymentPageBackButtonIconSize,
        color: Colors.black,
      ),
    );
  }
}

class TotalTicketAndSeatsTextView extends StatelessWidget {
  final String text;
  final String value;
  const TotalTicketAndSeatsTextView(
    this.text,
    this.value, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(
              fontSize: textRegular2X,
              color: paymentCardIconColor,
              fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
                fontSize: textRegular,
                color: Colors.black87,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class MovieSeatsSectionView extends StatefulWidget {
  const MovieSeatsSectionView(
      this.seatListForRow, this.rowNumbersListForGridView, this.selectedSeat);

  final List<MovieSeatListVO>? seatListForRow;
  final int? rowNumbersListForGridView;
  final Function(String? seatName) selectedSeat;

  @override
  State<MovieSeatsSectionView> createState() => _MovieSeatsSectionViewState();
}

class _MovieSeatsSectionViewState extends State<MovieSeatsSectionView> {
  @override
  Widget build(BuildContext context) {
    return (widget.rowNumbersListForGridView != null)
        ? GridView.builder(
            itemCount: widget.seatListForRow?.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: marginSmall),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 2,
                crossAxisCount: widget.rowNumbersListForGridView!,
                childAspectRatio: 1),
            itemBuilder: (context, index) {
              return MovieSeatItemView(
                  widget.seatListForRow?[index], widget.selectedSeat);
            },
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}

class MovieNameTimeAndCinemaSectionView extends StatelessWidget {
  final String? movieName;
  final String? cinemaName;
  final String? date;
  final String? time;
  const MovieNameTimeAndCinemaSectionView(
    this.movieName,
    this.cinemaName,
    this.date,
    this.time, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Center(
            child: TitleTextBold(
              movieName!,
              textColor: Colors.black,
              textSize: textRegular4X,
            ),
          ),
        ),
        const SizedBox(
          height: marginXSmall,
        ),
        TitleText(
          cinemaName!,
          textColor: paymentCardIconColor,
          textSize: textRegular1X,
        ),
        const SizedBox(
          height: marginXSmall,
        ),
        TitleText(
          "$date , $time",
          textColor: Colors.black,
          textSize: textRegular1X,
        ),
      ],
    );
  }
}
