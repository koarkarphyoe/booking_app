import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app/bloc/home_bloc.dart';
import 'package:student_app/data/model/data_models.dart';
import 'package:student_app/data/vos/data_vo.dart';
import 'package:student_app/data/vos/user_vo.dart';
import 'package:student_app/itemsview/horizontal_movie_list_view.dart';
import 'package:student_app/network/api_constants.dart';
import 'package:student_app/page/movie_details_page.dart';
import 'package:student_app/page/splash_screen_page.dart';
import 'package:student_app/resources/colors.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/resources/strings.dart';
import 'package:student_app/widgets/title_text.dart';
import 'package:student_app/widgets/title_text_bold.dart';

class HomePage extends StatelessWidget {
  //for Navigation Drawer Section ,it is need key and openDrawer()
  HomePage({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  void openDrawer() {
    _drawerKey.currentState!.openDrawer();
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
    return ChangeNotifierProvider(
      create: (BuildContext context)=>HomeBloc(),
      child: Scaffold(
        key: _drawerKey, //for Navigation Drawer Section
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              //for Navigation Drawer Section
              openDrawer();
            },
            child: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
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
        drawer: Selector<HomeBloc, UserVO?>(
          selector: (BuildContext context, userVO) => userVO.mUser,
          builder: (BuildContext context, userInfo, Widget? child) {
            return Selector<HomeBloc, DataModels>(
              selector: (BuildContext context, model) => model.userModels,
              builder: (BuildContext context, userModels, Widget? child) {
                return DrawerSectionView(
                    mUser: userInfo,
                    menuItems: menuItems,
                    userModels: userModels);
              },
            );
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: marginMedium, top: marginMedium),
                child: Selector<HomeBloc, UserVO?>(
                  selector: (BuildContext context, userVO) => userVO.mUser,
                  builder: (BuildContext context, mUser, Widget? child) {
                    return UserNameAndPhoto(mUser);
                  },
                ),
              ),
              const SizedBox(height: marginMedium),
              Selector<HomeBloc, List<DataVO>?>(
                selector: (BuildContext context, dataVO) => dataVO.currentMovie,
                builder: (BuildContext context, currentMovie, Widget? child) {
                  return Selector<HomeBloc, String?>(
                    selector: (BuildContext context, tokenString) =>
                        tokenString.token,
                    builder: (BuildContext context, token, Widget? child) {
                      return HorizontalMovieListView(
                          nowShowingText,
                          currentMovie,
                          (movieId) => _navigateToMovieDetailPage(
                              context, movieId, token!));
                    },
                  );
                },
              ),
              Selector<HomeBloc, List<DataVO>?>(
                selector: (BuildContext context, dataVO) =>
                    dataVO.comingSoonMovie,
                builder:
                    (BuildContext context, comingSoonMovie, Widget? child) {
                  return Selector<HomeBloc, String?>(
                    selector: (BuildContext context, tokenString) =>
                        tokenString.token,
                    builder: (BuildContext context, token, Widget? child) {
                      return HorizontalMovieListView(
                          comingSoonText,
                          comingSoonMovie,
                          (movieId) => _navigateToMovieDetailPage(
                              context, movieId, token!));
                    },
                  );
                },
              ),
              const SizedBox(
                height: marginXSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _navigateToMovieDetailPage(
      BuildContext context, int movieId, String token) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailsPage(movieId, token),
      ),
    );
  }
}

class DrawerSectionView extends StatelessWidget {
  const DrawerSectionView({
    Key? key,
    required this.mUser,
    required this.menuItems,
    required this.userModels,
  }) : super(key: key);

  final UserVO? mUser;
  final List<String> menuItems;
  final DataModels userModels;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                DrawerHeaderSectionView(userVO: mUser),
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
                GestureDetector(
                  onTap: () {
                    userModels.logOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SplashScreen(),
                        ),
                        (route) => false);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const SplashScreen(),
                    //   )
                    // );
                  },
                  child: const ListTile(
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
                ),
                const SizedBox(
                  height: marginMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserNameAndPhoto extends StatelessWidget {
  final UserVO? userVO;
  const UserNameAndPhoto(this.userVO, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          child: (userVO?.profileImage != null)
              ? CircleAvatar(
                  radius: 25,
                  backgroundImage:
                      NetworkImage("$baseUrl${userVO?.profileImage}"),
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
  final UserVO? userVO;

  const DrawerHeaderSectionView({Key? key, required this.userVO})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          height: marginMediumXXLarge,
        ),
        Container(
          child: (userVO?.profileImage != null)
              ? CircleAvatar(
                  radius: 25,
                  backgroundImage:
                      NetworkImage("$baseUrl${userVO?.profileImage}"),
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
