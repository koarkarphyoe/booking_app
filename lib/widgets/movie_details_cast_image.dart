import 'package:flutter/material.dart';
import 'package:student_app/resources/dimens.dart';

class MovieDetailsCastImageView extends StatelessWidget {
  const MovieDetailsCastImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(right: marginMedium),
      child: CircleAvatar(
        radius: movieDetailsScreenCastImageRadius,
        backgroundImage: NetworkImage(
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR41Jl9Omn4hm2Kv7j7K4eVqFC16vrZ7zlDk6fXsjmtTbnNNrGuD3ESEOcpdSsg6tP7h4s&usqp=CAU",
        ),
      ),
    );
  }
}
