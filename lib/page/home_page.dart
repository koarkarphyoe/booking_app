import 'package:flutter/material.dart';
import 'package:student_app/data/model/data_models.dart';
import 'package:student_app/data/model/data_models_impl.dart';
import 'package:student_app/data/vos/data_vo.dart';
import 'package:student_app/data/vos/user_vo.dart';
import 'package:student_app/itemsview/horizontal_movie_list_view.dart';
import 'package:student_app/network/api_constants.dart';
import 'package:student_app/resources/colors.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/resources/strings.dart';
import 'package:student_app/widgets/title_text.dart';
import 'package:student_app/widgets/title_text_bold.dart';

class HomePage extends StatefulWidget {
  //First page
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//   final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
//  void _openDrawer() {
//     _drawerKey.currentState!.openDrawer();
//   }

  DataModels userModels = DataModelsImpl();

  UserVO? mUser;
  String? profileImage;
  String? token;
  List<DataVO>? movie;

  // call network data again from this page
  @override
  void initState() {
    userModels.getNowShowingMovie(statusValue1)?.then((value) {
      setState(() {
        movie = value;
      });
    });

    userModels.getUserInfoFromDatabase()?.then((value) {
      setState(() {
        mUser = value;
      });
    });

    userModels.getProfileImageFromDatabase()?.then((value) {
      setState(() {
        profileImage = value;
      });
    });

    userModels.getTokenFromDatabase()?.then((value) {
      setState(() {
        token = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> menuItems = [
      "Promotion code",
      "Select language",
      "Term of service",
      "Help",
      "Rate us"
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
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
        elevation: 0,
      ),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Drawer(
          child: Container(
            color: primaryColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: marginMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DrawerHeaderSectionView(profileImage, userVO: mUser),
                  Column(
                    children: menuItems.map((menu) {
                      return Container(
                        margin: const EdgeInsets.only(top: marginMedium),
                        child: ListTile(
                          leading: const Icon(Icons.help, color: Colors.white),
                          title: Text(
                            menu,
                            style: const TextStyle(
                              fontSize: textRegular,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const Spacer(),
                  const ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    title: Text(
                      logOutText,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: textRegular,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: marginMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: marginMedium, top: marginMedium),
              child: UserNameAndPhoto(profileImage, mUser),
            ),
            const SizedBox(height: marginMedium),
            HorizontalMovieListView(nowShowingText, movie),
            HorizontalMovieListView(comingSoonText, movie),
          ],
        ),
      ),
    );
  }
}

class UserNameAndPhoto extends StatelessWidget {
  final String? profileImage;
  final UserVO? userVO;
  const UserNameAndPhoto(this.profileImage, this.userVO, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageUrl = "$baseUrl${userVO?.profileImage}";
    return Row(
      children: [
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
        Container(
          child: (profileImage != null)
              ? CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(profileImage ?? imageUrl),
                )
              : const CircularProgressIndicator(),
        ),
        const SizedBox(width: marginMedium),
        TitleTextBold(
          "Hi ${userVO?.name}",
          textSize: textRegular3X,
          textColor: Colors.black,
        )
      ],
    );
  }
}

class DrawerHeaderSectionView extends StatelessWidget {
  final String? profileImage;
  final UserVO? userVO;

  const DrawerHeaderSectionView(this.profileImage, {Key? key, required this.userVO})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageUrl = "$baseUrl${userVO?.profileImage}";
    return Row(
      children: [
        const SizedBox(
          height: marginMediumXXLarge,
        ),
        Container(
          child: (profileImage != null)
              ? CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(profileImage ?? imageUrl),
                )
              : const CircularProgressIndicator(),
        ),
        const SizedBox(
          width: marginMedium,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleTextBold("${userVO?.name}", textSize: textRegular1X),
            Row(
              children: [
                TitleText(
                  "${userVO?.email}",
                  textSize: textRegular,
                ),
                const SizedBox(width: marginMedium1X),
                const TitleText(
                  "Edit",
                  textSize: textRegular,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
