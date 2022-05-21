import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app/bloc/ticket_bloc.dart';
import 'package:student_app/data/vos/data_vo.dart';
import 'package:student_app/page/home_page.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/resources/strings.dart';
import 'package:student_app/widgets/movie_booking_voucher_text.dart';
import 'package:student_app/widgets/title_text.dart';
import 'package:student_app/widgets/title_text_bold.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../network/api_constants.dart';

class TicketViewPage extends StatelessWidget {
  final dynamic checkoutRequest;

  const TicketViewPage(this.checkoutRequest, {Key? key}) : super(key: key);

//   @override
//   State<TicketViewPage> createState() => _TicketViewPageState();
// }

// class _TicketViewPageState extends State<TicketViewPage> {
//   DataModels mDataModel = DataModelsImpl();
//   VoucherVO? voucher;
//   DataVO? mMovie;

//   @override
//   void initState() {
//     setState(() {

//       mDataModel.checkOut(widget.checkoutRequest)?.then((value) {
//         setState(() {
//           voucher = value.data;

//           mDataModel
//               .getMovieDetailsFromDatabase(voucher!.movieId!.toInt())
//               .listen((value) {
//             if (mounted) {
//               setState(() {
//                 mMovie = value;
//               });
//             }
//           });
//         });
//       });
//     });

//     super.initState();
//   }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: TicketBloc(checkoutRequest),
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: marginMedium),
              child: GestureDetector(
                onTap: () {
                  _navigateToHomePage(context);
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.black,
                  size: comboSetButtonHeight,
                ),
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
          ),
          body: Consumer<TicketBloc>(
            builder: (BuildContext context, bloc, Widget? child) {
              return (bloc.voucher != null && bloc.mMovie != null)
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          TitleTextBoldView(
                              bloc.mMovie?.originalTitle.toString()),
                          const SizedBox(height: marginXSmall),
                          TitleTextNormalView(bloc.voucher?.username),
                          const SizedBox(height: marginXSmall),
                          SizedBox(
                            height: movieTicketTopSizedBoxHeight,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: marginMediumXXX),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MovieTicketImageView(bloc.mMovie),
                                  const SizedBox(height: marginSmall),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: marginMedium),
                                    child: MovieTitleNameInTicketView(
                                        bloc.mMovie!.originalTitle.toString(),
                                        bloc.mMovie!.runtime.toString()),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 250,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: marginMediumXXXX),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MovieBookingVoucherView(bookingNoText,
                                      bloc.voucher!.bookingNo.toString()),
                                  const SizedBox(height: marginMedium),
                                  MovieBookingVoucherView(showTimeAndDateText,
                                      "${bloc.voucher!.timeslot?.startTime}  ${bloc.voucher!.bookingDate}"),
                                  const SizedBox(height: marginMedium),
                                  MovieBookingVoucherView(theaterText,
                                      bloc.voucher!.cinemaId.toString()),
                                  const SizedBox(height: marginMedium),
                                  MovieBookingVoucherView(
                                      rowText, bloc.voucher!.row.toString()),
                                  const SizedBox(height: marginMedium),
                                  MovieBookingVoucherView(
                                      seatText, bloc.voucher!.seat.toString()),
                                  const SizedBox(height: marginMedium),
                                  MovieBookingVoucherView(
                                      priceText, "${bloc.voucher!.total}"),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(marginMedium),
                            child: BarCodeView(bloc.voucher!.bookingNo),
                          ),
                        ],
                      ),
                    )
                  : const Center(child: CircularProgressIndicator());
            },
          )),
    );
  }

  void _navigateToHomePage(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false);
  }
}

class BarCodeView extends StatelessWidget {
  String? barCode;
  BarCodeView(
    this.barCode, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: movieTicketBarCodeHeight,
      child: SfBarcodeGenerator(
        value: barCode,
      ),
    );
  }
}

class MovieTitleNameInTicketView extends StatelessWidget {
  final String? title;
  final String? length;
  const MovieTitleNameInTicketView(
    this.title,
    this.length, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(
          title!,
          textColor: Colors.black,
          textSize: textRegular1X,
        ),
        const SizedBox(height: marginXSmall),
        TitleText(
          "$length m",
          textColor: Colors.black54,
          textSize: textRegular,
        ),
      ],
    );
  }
}

class MovieTicketImageView extends StatelessWidget {
  final DataVO? mMovie;
  const MovieTicketImageView(
    this.mMovie, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: movieTicketImageHeight,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage("$moviePosterBaseUrl${mMovie!.posterPath}"),
          fit: BoxFit.cover,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(movieTicketImageCircularRadius),
          topRight: Radius.circular(movieTicketImageCircularRadius),
        ),
      ),
    );
  }
}

class TitleTextNormalView extends StatelessWidget {
  final String? text;
  const TitleTextNormalView(
    this.text, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TitleText(
        "This is $text's ticket!",
        textColor: Colors.black26,
        textSize: textRegular,
      ),
    );
  }
}

class TitleTextBoldView extends StatelessWidget {
  final String? title;
  const TitleTextBoldView(
    this.title, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TitleTextBold(
        title!,
        textColor: Colors.black,
        textSize: textRegular4X,
      ),
    );
  }
}
