import 'package:flutter/material.dart';
import 'package:student_app/data/model/data_models.dart';
import 'package:student_app/data/model/data_models_impl.dart';
import 'package:student_app/data/vos/casts_vo.dart';
import 'package:student_app/data/vos/movie_vo.dart';
import 'package:student_app/network/api_constants.dart';
import 'package:student_app/page/movie_choose_time.dart';
import 'package:student_app/resources/colors.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/resources/strings.dart';
import 'package:student_app/widgets/confirm_button_view.dart';
import 'package:student_app/widgets/movie_details_cast_image.dart';
import 'package:student_app/widgets/title_text.dart';
import 'package:student_app/widgets/title_text_bold.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieDetailsPage extends StatefulWidget {
  final int movieId;
  final String token;
  const MovieDetailsPage(this.movieId, this.token, {Key? key})
      : super(key: key);
  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  DataModels movieModels = DataModelsImpl();
  MovieVO? movieDetails;
  List<CastsVO?>? castImage;

  @override
  void initState() {
    super.initState();

    // Network used before migrate to Reactive Programming
    // movieModels.getMovieDetails(widget.movieId).then((value) {
    //   setState(() {
    //     movieDetails = value;
    //     castImage = value.casts;
    //   });
    // });

    //Database used after migrate to Reactive Programming
    movieModels.getMovieDetailsFromDatabase(widget.movieId)?.then((value) {
      setState(() {
        movieDetails = value;
        castImage = value.casts;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return (movieDetails != null)
        ? Scaffold(
            backgroundColor: Colors.white,
            body: SizedBox(
              // height: MediaQuery.of(context).size.height,
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    elevation: 0,
                    expandedHeight: MediaQuery.of(context).size.height / 2,
                    collapsedHeight: sliverAppBarCollapsedHeight,
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.white,
                    flexibleSpace: Stack(
                      children: [
                        Positioned.fill(
                          child: MovieDetailsScreenImageView(movieDetails),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: marginMedium2X, left: marginMedium),
                            child: MovieDetailsScreenBackButtonView(
                              onTapBack: () {
                                navigateToPreviousPage(context);
                              },
                            ),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.center,
                          child: MovieDetailsScreenPlayButtonView(),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: movieDetailsWhiteContainerHeight,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(marginMedium2X),
                                topRight: Radius.circular(marginMedium2X),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                          padding: const EdgeInsets.only(left: marginMedium),
                          child: MovieDetailScreenTitleAndRatingView(
                              movieDetails, movieDetails),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(marginMedium),
                          child: PlotSummarySectionView(movieDetails),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                  left: marginMedium,
                                  right: marginMedium,
                                  bottom: marginMedium),
                              child: TitleTextBold(
                                castText,
                                textSize: textRegular2X,
                                textColor: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              height: marginXSmall,
                            ),
                            // SizedBox(
                            //   height: movieDetailsScteenCastContainerHeight,
                            //   child: ListView.builder(
                            //     padding: const EdgeInsets.symmetric(
                            //         horizontal: marginMedium),
                            //     itemCount: castImage?.length.toInt(),
                            //     scrollDirection: Axis.horizontal,
                            //     itemBuilder: (BuildContext context, int index) {
                            //       return (castImage != null)
                            //           ? MovieDetailsCastImageView(
                            //               castImage?[index])
                            //           : Container();
                            //     },
                            //   ),
                            // ),
                            const SizedBox(
                              height: marginMedium,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(marginMedium),
                              child: ConfirmButtonView(
                                getYourTicketText,
                                () {
                                  _navigateToMovieChooseTimePage(context);
                                },
                                buttonBackgroundColor: primaryColor,
                                isGhostButton: true,
                              ),
                            ),
                            const SizedBox(
                              height: marginMediumLarge,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }

  void _navigateToMovieChooseTimePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieChooseTime(
          movieDetails!,
        ),
      ),
    );
  }

  void navigateToPreviousPage(BuildContext context) => Navigator.pop(context);
}

class PlotSummarySectionView extends StatelessWidget {
  final MovieVO? movieDetails;
  const PlotSummarySectionView(
    this.movieDetails, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleTextBold(
          plotSummaryText,
          textSize: textRegular2X,
          textColor: Colors.black,
        ),
        const SizedBox(
          height: marginXSmall,
        ),
        (movieDetails != null)
            ? TitleText(
                movieDetails!.overview.toString(),
                textColor: Colors.black54,
                textSize: textRegular,
              )
            : const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                ),
              ),
      ],
    );
  }
}

class MovieDetailScreenTitleAndRatingView extends StatelessWidget {
  final MovieVO? movieDetails;
  final MovieVO? genreList;
  const MovieDetailScreenTitleAndRatingView(this.genreList, this.movieDetails,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleTextBold(
          movieDetails!.originalTitle.toString(),
          textColor: Colors.black,
          textSize: textRegular4X,
        ),
        const SizedBox(height: marginXSmall),
        Row(
          children: [
            TitleText(
              "${movieDetails!.runtime.toString()}m",
              textColor: Colors.black87,
              textSize: textRegular2X,
            ),
            const SizedBox(
              width: marginSmall,
            ),
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              itemCount: 5,
              itemSize: 25,
              itemBuilder: (BuildContext context, int index) {
                return const Icon(Icons.star, color: Colors.amber);
              },
              onRatingUpdate: (rating) {
                // ignore: avoid_print
                print("rating");
              },
            ),
            const SizedBox(
              width: marginMedium,
            ),
            TitleText(
              "IMDb ${movieDetails!.rating.toString()}",
              textColor: Colors.black87,
              textSize: textRegular3X,
            )
          ],
        ),
        const SizedBox(
          height: marginXSmall,
        ),
        Wrap(
          alignment: WrapAlignment.start,
          direction: Axis.horizontal,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: _genresListWidget(),
          // genreList?.genres?.map((e) => GenreListView(e)).toList() ??
          // genreListOriginal.map((e) => GenreListView(e)).toList(),
        ),
      ],
    );
  }

  List<Widget> _genresListWidget() {
    List<Widget> widgets = [];
    final List<String> genreListOriginal = ["", "", ""];
    widgets.addAll(genreList?.genres?.map((e) => GenreListView(e)).toList() ??
        genreListOriginal.map((e) => GenreListView(e)).toList());
    return widgets;
  }
}

class GenreListView extends StatelessWidget {
  final String genreList;
  const GenreListView(this.genreList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: marginForChip),
      child: Chip(
          //if use FilterChip
          // onSelected: (bool value) {
          //   // ignore: avoid_print
          //   print("selected");
          // },
          shape: const StadiumBorder(
            side: BorderSide(color: Colors.black12),
          ),
          backgroundColor: Colors.transparent,
          label: Padding(
            padding: const EdgeInsets.all(marginXSmall),
            child: Text(
              genreList,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: textRegular,
              ),
            ),
          )),
    );
  }
}

class MovieDetailsScreenPlayButtonView extends StatelessWidget {
  const MovieDetailsScreenPlayButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.play_circle_outlined,
      color: Colors.white,
      size: movieDetailsScreenPlayCircleSize,
    );
  }
}

class MovieDetailsScreenImageView extends StatelessWidget {
  final MovieVO? movie;
  const MovieDetailsScreenImageView(
    this.movie, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MovieDetailsImageView(movie);
  }
}

class MovieDetailsScreenBackButtonView extends StatelessWidget {
  final Function onTapBack;
  const MovieDetailsScreenBackButtonView({
    Key? key,
    required this.onTapBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapBack();
      },
      child: const Icon(
        Icons.chevron_left,
        size: paymentPageBackButtonIconSize,
        color: Colors.white,
      ),
    );
  }
}

class MovieDetailsImageView extends StatelessWidget {
  final MovieVO? movie;
  const MovieDetailsImageView(
    this.movie, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "$moviePosterBaseUrl${movie?.posterPath.toString()}",
      // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHD8WDfqyhvTJycYGsqcxkhv5dG8PcxQ8YMw&usqp=CAU",
      fit: BoxFit.fill,
    );
  }
}
