import 'package:flutter/material.dart';
import 'package:student_app/itemsview/horizontal_movie_list_view.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/resources/strings.dart';
import 'package:student_app/widgets/title_text_bold.dart';

class MovieListPage extends StatelessWidget {
  const MovieListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const Icon(Icons.menu,
            color: Colors.black, size: searchAndMenuIconSize),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: marginMedium),
            child: Icon(
              Icons.search,
              color: Colors.black,
              size: searchAndMenuIconSize,
            ),
          ),
        ],
      ),
      body: Column(
        children: const [
          Padding(
            padding: EdgeInsets.only(left: marginMedium, top: marginMedium),
            child: UserNameAndPhoto(),
          ),
          SizedBox(height: marginMedium),
          HorizontalMovieListView(nowShowingText),
          HorizontalMovieListView(comingSoonText),
        ],
      ),
    );
  }
}

class UserNameAndPhoto extends StatelessWidget {
  const UserNameAndPhoto({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        // Container(
        //   height: 50.0,
        //   width: 50.0,
        //   decoration:  const BoxDecoration(
        //     shape: BoxShape.circle,
        //     image: DecorationImage(fit: BoxFit.cover,
        //       image:NetworkImage(
        //         "https://6.viki.io/image/9c15adec53ea43dfa3e2ce0c77c83c1f.jpeg?s=900x600&e=t",
        //       ),
        //     ),
        //   ),
        // ),
        CircleAvatar(
          backgroundImage: NetworkImage(
            "https://6.viki.io/image/9c15adec53ea43dfa3e2ce0c77c83c1f.jpeg?s=900x600&e=t",
          ),
        ),
        SizedBox(width: marginMedium),
        TitleTextBold(
          "Hi Lily!",
          textSize: textRegular3X,
          textColor: Colors.black,
        )
      ],
    );
  }
}
