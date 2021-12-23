import 'package:flutter/material.dart';
import 'package:student_app/data/vos/casts_vo.dart';
import 'package:student_app/network/api_constants.dart';
import 'package:student_app/resources/dimens.dart';

class MovieDetailsCastImageView extends StatelessWidget {
  final CastsVO? castImage;
  const MovieDetailsCastImageView(this.castImage, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: marginMedium),
      child: (castImage != null)
          ? CircleAvatar(
              radius: movieDetailsScreenCastImageRadius,
              backgroundImage: NetworkImage(
                "$moviePosterBaseUrl${castImage?.profilePath}",
                // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR41Jl9Omn4hm2Kv7j7K4eVqFC16vrZ7zlDk6fXsjmtTbnNNrGuD3ESEOcpdSsg6tP7h4s&usqp=CAU",
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
