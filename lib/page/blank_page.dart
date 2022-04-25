import 'package:flutter/material.dart';
import 'package:student_app/data/model/data_models.dart';
import '../data/model/data_models_impl.dart';
import '../data/vos/casts_vo.dart';
import '../data/vos/movie_vo.dart';
import '../network/api_constants.dart';
import '../resources/dimens.dart';
import '../widgets/movie_details_cast_image.dart';

class BlankPage extends StatefulWidget {
  final int movieId;
  final String token;
  const BlankPage(this.movieId, this.token, {Key? key}) : super(key: key);

  @override
  State<BlankPage> createState() => _BlankPageState();
}

class _BlankPageState extends State<BlankPage> {
  DataModels movieModels = DataModelsImpl();
  MovieVO? movieDetails;
  List<CastsVO?>? castImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieModels.getMovieDetailsFromDatabase(widget.movieId)?.then((value) {
      setState(() {
        movieDetails = value;
        castImage = value.casts;

        print(movieDetails?.id.toString());
        print(movieDetails?.originalTitle.toString());
        print(movieDetails?.posterPath.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
          width: 500,
          child: Image.network(
              "$moviePosterBaseUrl${movieDetails?.posterPath.toString()}"),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            padding:const EdgeInsets.symmetric(horizontal: marginMedium),
            itemCount: castImage?.length.toInt(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return (castImage != null)
                  ? MovieDetailsCastImageView(castImage?[index])
                  : Container();
            },
          ),
        )
      ],
    );
  }
}
