import 'package:flutter/material.dart';
import 'package:student_app/data/vos/casts_vo.dart';
import 'package:student_app/network/api_constants.dart';
import 'package:student_app/resources/dimens.dart';

class MovieDetailsCastImageView extends StatelessWidget {
  final CastsVO? castImage;
  const MovieDetailsCastImageView(this.castImage, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final castImageUrl = castImage?.profilePath != null
        ? "$moviePosterBaseUrl${castImage?.profilePath}"
        : "https://e7.pngegg.com/pngimages/529/832/png-clipart-computer-icons-avatar-user-profile-avatar-blue-heroes.png";
    return Padding(
      padding: const EdgeInsets.only(right: marginMedium),
      child: CircleAvatar(
        radius: movieDetailsScreenCastImageRadius,
        backgroundImage: NetworkImage(
          castImageUrl,
        ),
      ),
    );
  }
}
