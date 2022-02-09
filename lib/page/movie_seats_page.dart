// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:student_app/data/model/data_models_impl.dart';
import 'package:student_app/data/vos/movie_seat_list_vo.dart';
import 'package:student_app/itemsview/movie_seat_item_view.dart';
import 'package:student_app/resources/colors.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/widgets/title_text.dart';
import 'package:student_app/widgets/title_text_bold.dart';

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
              MovieSeatsSectionView(seatListForRow, rowNumbersListForGridView),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieSeatsSectionView extends StatelessWidget {
  const MovieSeatsSectionView(
      this.seatListForRow, this.rowNumbersListForGridView);
  // const MovieSeatsSectionView({
  //   Key? key,
  //   required List<MovieSeatVO> movieSeats,
  // })  : _movieSeats = movieSeats,
  //       super(key: key);

  // final List<MovieSeatVO> _movieSeats;
  final List<MovieSeatListVO>? seatListForRow;
  final int? rowNumbersListForGridView;

  @override
  Widget build(BuildContext context) {
    return (rowNumbersListForGridView != null)
        ? GridView.builder(
            itemCount: seatListForRow?.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: marginSmall),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 2,
                crossAxisCount: rowNumbersListForGridView!,
                childAspectRatio: 1),
            itemBuilder: (context, index) {
              return MovieSeatItemView(seatListForRow?[index]);
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
