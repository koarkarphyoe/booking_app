// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:student_app/data/model/data_models_impl.dart';
import 'package:student_app/data/vos/movie_seat_list_vo.dart';
import 'package:student_app/itemsview/movie_seat_item_view.dart';
import 'package:student_app/resources/colors.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/widgets/confirm_button_view.dart';
import 'package:student_app/widgets/title_text.dart';
import 'package:student_app/widgets/title_text_bold.dart';

import '../itemsview/movie_seats_status.dart';
import '../resources/strings.dart';

class MovieSeatsPage extends StatefulWidget {
  final movieDetails;
  final cinemaName;
  final date;
  final time;
  final cinemaId;
  final yMd;
  const MovieSeatsPage(this.movieDetails, this.cinemaName, this.date, this.time,
      this.cinemaId, this.yMd,
      {Key? key})
      : super(key: key);

  @override
  State<MovieSeatsPage> createState() => _MovieSeatsPageState();
}

class _MovieSeatsPageState extends State<MovieSeatsPage> {
  DataModelsImpl mModel = DataModelsImpl();

  List<List<MovieSeatListVO>>? allSeatPlanList;
  List<MovieSeatListVO>? seatListForRow;
  int? rowNumbersListForGridView;
  List<String> selectedSeat = [];
  double totalSelectedSeatPrice = 0.0;

  //for Method 2
  // List<MovieSeatListVO> seatNameLists = [];

  @override
  void initState() {
    super.initState();
    mModel.getMovieSeat(widget.cinemaId, widget.yMd).then(
      (value) {
        setState(
          () {
            //Method 2
            allSeatPlanList = value;
            rowNumbersListForGridView = allSeatPlanList?.first.length;
            seatListForRow =
                allSeatPlanList?.expand((element) => element).toList();
            // seatNameLists.addAll(seatListForRow!.map((e) => e).toList());
            // addSeatId(seatLists);

            //Method 1
            // allSeatPlanList = value;
            // seatListForRow = [];
            // for (int i = 0; i < allSeatPlanList!.length; i++) {
            //   List<MovieSeatListVO> seats = [
            //     ...allSeatPlanList![i]
            //   ]; // ... Spread operator insert all the elements of a list into another list
            //   for (var seat in seats) {
            //     seatListForRow?.add(seat);
            //   }
            // }
            // rowNumbersListForGridView = allSeatPlanList?.first.length;
          },
        );
      },
    );
  }

  void _selectedSeat(String? seatName) {
    setState(
      () {
        //Method 1
        seatListForRow?.map((e) {
          if (e.seatName != "" &&
              e.type == "available" &&
              e.seatName == seatName) {
            if (e.isSelected == true) {
              e.isSelected = false;
              selectedSeat.remove(e.seatName);
              totalSelectedSeatPrice -= e.price!.toDouble();

              // print(totalSelectedSeatPrice.toString());
              // print("Remove seat $selectedSeat");
            } else {
              e.isSelected = true;
              selectedSeat.add(e.seatName.toString());
              totalSelectedSeatPrice += e.price!.toDouble();

              // print("Selected seat $selectedSeat");
              // print(e.seatName.toString());
              // print(totalSelectedSeatPrice.toString());
            }
          }
        }).toList();

        //Method 2
        // seatNameLists.map((e) {
        //   if (e.seatName == seatName) {
        //     e.isSelected = true;
        //     print(e.seatName.toString());
        //   } else {
        //     e.isSelected = false;
        //   }
        // }).toList();
      },
    );
  }

  // addSeatId(List<MovieSeatListVO> mseats) {
  //   for (int i = 0; i < mseats.length; i++) {
  //     seatLists[i].seatId = i + 1;
  //     seatLists[i].isSelected = false;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // final List<MovieSeatVO> _movieSeats = dummyMovieSeats;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.chevron_left,
            size: paymentPageBackButtonIconSize,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              MovieNameTimeAndCinemaSectionView(widget.movieDetails,
                  widget.cinemaName, widget.date, widget.time),
              const SizedBox(height: marginMedium1X),
              MovieSeatsSectionView(seatListForRow, rowNumbersListForGridView,
                  (seatName) {
                _selectedSeat(seatName);
              }),
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
                child: TotalTicketAndSeatsTextView(
                    "Tickets", selectedSeat.length.toString()),
              ),
              const SizedBox(height: marginMedium),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: marginMedium),
                child: TotalTicketAndSeatsTextView(
                    "Seats", selectedSeat.map((e) => e).toString()),
              ),
              const SizedBox(
                height: marginMedium,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: marginMedium),
                child: ConfirmButtonView(
                  "Buy Ticket for \$${totalSelectedSeatPrice.toString()}",
                  () {},
                  buttonBackgroundColor: primaryColor,
                ),
              ),
              const SizedBox(height: marginMedium),
            ],
          ),
        ),
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
  // const MovieSeatsSectionView({
  //   Key? key,
  //   required List<MovieSeatVO> movieSeats,
  // })  : _movieSeats = movieSeats,
  //       super(key: key);

  // final List<MovieSeatVO> _movieSeats;
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
        Center(
          child: TitleTextBold(
            movieName!,
            textColor: Colors.black,
            textSize: textRegular4X,
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
