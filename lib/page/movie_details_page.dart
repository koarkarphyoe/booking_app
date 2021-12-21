import 'package:flutter/material.dart';
import 'package:student_app/data/model/data_models.dart';
import 'package:student_app/data/model/data_models_impl.dart';
import 'package:student_app/data/vos/movie_details_vo.dart';
import 'package:student_app/network/api_constants.dart';
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
  const MovieDetailsPage(this.movieId);

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  DataModels movieModels = DataModelsImpl();
  MovieDetailsVO? movieDetails;

  @override
  void initState() {
    super.initState();
    movieModels.getMovieDetails(widget.movieId)?.then((value) {
      setState(() {
        movieDetails = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> genreList = ["Adventure", "Action"];
    return Scaffold(
      body: SizedBox(
        // height: MediaQuery.of(context).size.height,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0,
              expandedHeight: MediaQuery.of(context).size.height / 2,
              collapsedHeight: sliverAppBarCollapsedHeight,
              automaticallyImplyLeading: false,
              backgroundColor: primaryColor,
              flexibleSpace: Stack(
                children: [
                  Positioned.fill(
                    child: MovieDetailsScreenImageView(movieDetails),
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: 50, left: 16),
                      child: MovieDetailsScreenBackButtonView(),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: MovieDetailsScreenPlayButtonView(),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: movieDetailsTitleScreenContainerHeight,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(marginMedium1X),
                          topRight: Radius.circular(marginMedium1X),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: marginMediumX, left: marginMedium),
                        child: MovieDetailScreenTitleAndRatingView(
                            genreList: genreList),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const Padding(
                    padding: EdgeInsets.all(marginMedium),
                    child: PlotSummarySectionView(),
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
                      SizedBox(
                        height: movieDetailsScteenCastContainerHeight,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: marginMedium),
                          itemCount: 10,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return const MovieDetailsCastImageView();
                          },
                        ),
                      ),
                      const SizedBox(
                        height: marginMedium,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(marginMedium),
                        child: ConfirmButtonView(
                          getYourTicketText,
                          () {},
                          buttonBackgroundColor: primaryColor,
                          isGhostButton: true,
                        ),
                      ),
                      const SizedBox(
                        height: marginMediumXXLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlotSummarySectionView extends StatelessWidget {
  const PlotSummarySectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        TitleTextBold(
          plotSummaryText,
          textSize: textRegular2X,
          textColor: Colors.black,
        ),
        SizedBox(
          height: marginXSmall,
        ),
        TitleText(
          "Ace detective Harry Goodman goes mysteriously missing, prompting his 21-year-old son, Tim, to find out what happened. Aiding in the investigation is Harry's former Pokémon partner, wise-cracking, adorable super-sleuth Detective Pikachu.",
          textColor: Colors.black54,
          textSize: textRegular,
        )
      ],
    );
  }
}

class MovieDetailScreenTitleAndRatingView extends StatelessWidget {
  final List<String> genreList;
  const MovieDetailScreenTitleAndRatingView({
    Key? key,
    required this.genreList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleTextBold(
          "Detective Pikachu",
          textColor: Colors.black,
          textSize: textRegular4X,
        ),
        const SizedBox(height: marginXSmall),
        Row(
          children: [
            const TitleText(
              "1h 45m",
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
            const TitleText(
              "IMDb 6.6",
              textColor: Colors.black87,
              textSize: textRegular3X,
            )
          ],
        ),
        const SizedBox(
          height: marginXSmall,
        ),
        Row(
          children:
              genreList.map((genreText) => GenreListView(genreText)).toList(),
        ),
      ],
    );
  }
}

class GenreListView extends StatelessWidget {
  final String genreList;
  const GenreListView(this.genreList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: marginMedium),
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
  final MovieDetailsVO? movie;
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
  const MovieDetailsScreenBackButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.chevron_left,
      size: 50,
      color: Colors.white,
    );
  }
}

class MovieDetailsImageView extends StatelessWidget {
  final MovieDetailsVO? movie;
  const MovieDetailsImageView(
    this.movie, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (movie != null)
        ? Image.network(
            "$moviePosterBaseUrl${movie?.posterPath}",
            // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHD8WDfqyhvTJycYGsqcxkhv5dG8PcxQ8YMw&usqp=CAU",
            fit: BoxFit.fill,
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
