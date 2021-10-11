import 'package:flutter/material.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/resources/strings.dart';
import 'package:student_app/widgets/movie_booking_voucher_text.dart';
import 'package:student_app/widgets/title_text.dart';
import 'package:student_app/widgets/title_text_bold.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class TicketViewPage extends StatelessWidget {
  const TicketViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: moveiTicketToolBarHeight,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Padding(
          padding:
              const EdgeInsets.only(top: marginMedium, bottom: marginMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              CloseIcomView(),
              TitleTextBoldView(),
              SizedBox(height: marginXSmall),
              TitleTextNormalView(),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: movieTicketTopSizedBoxHeight,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: marginMediumXXX),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    MovieTicketImageView(),
                    SizedBox(height: marginSmall),
                    Padding(
                      padding: EdgeInsets.only(left: marginMedium),
                      child: MovieTitleNameInTicketView(),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 250,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: marginMediumXXXX),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    MovieBookingVoucherView(bookingNoText, "GC1547219308"),
                    SizedBox(height: marginMedium),
                    MovieBookingVoucherView(
                        showTimeAndDateText, "7:00 PM -10 May"),
                    SizedBox(height: marginMedium),
                    MovieBookingVoucherView(
                        theaterText, "Galaxy Cinema - Golden City"),
                    SizedBox(height: marginMedium),
                    MovieBookingVoucherView(screenText, "2"),
                    SizedBox(height: marginMedium),
                    MovieBookingVoucherView(rowText, "D"),
                    SizedBox(height: marginMedium),
                    MovieBookingVoucherView(seatText, "5,6"),
                    SizedBox(height: marginMedium),
                    MovieBookingVoucherView(priceText, "\$40.00"),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(marginMedium),
              child: BarCodeView(),
            ),
          ],
        ),
      ),
    );
  }
}

class BarCodeView extends StatelessWidget {
  const BarCodeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: movieTicketBarCodeHeight,
      child: SfBarcodeGenerator(
        value: 'www.syncfusion.com',
      ),
    );
  }
}

class MovieTitleNameInTicketView extends StatelessWidget {
  const MovieTitleNameInTicketView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        TitleText(
          "Detective Pikachu",
          textColor: Colors.black,
          textSize: textRegular1X,
        ),
        SizedBox(height: marginXSmall),
        TitleText(
          "105m -IMAX",
          textColor: Colors.black54,
          textSize: textRegular,
        )
      ],
    );
  }
}

class MovieTicketImageView extends StatelessWidget {
  const MovieTicketImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: movieTicketImageHeight,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcrsg63dcaAKqyZO_gAke2rkymE4ZddnVs5Aoq_CbK7PAoM6MAB_0M8icUnNrWCpozB2o&usqp=CAU"),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(movieTicketImageCircularRadius),
          topRight: Radius.circular(movieTicketImageCircularRadius),
        ),
      ),
    );
  }
}

class TitleTextNormalView extends StatelessWidget {
  const TitleTextNormalView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: TitleText(
        thisIsYourTicketText,
        textColor: Colors.black26,
        textSize: textRegular,
      ),
    );
  }
}

class TitleTextBoldView extends StatelessWidget {
  const TitleTextBoldView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: TitleTextBold(
        awesomeTitleText,
        textColor: Colors.black,
        textSize: textRegular4X,
      ),
    );
  }
}

class CloseIcomView extends StatelessWidget {
  const CloseIcomView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.close,
      color: Colors.black,
      size: movieTicketCloseIconSize,
    );
  }
}
