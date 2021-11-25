import 'package:flutter/material.dart';
import 'package:student_app/data/model/data_models.dart';
import 'package:student_app/data/model/data_models_impl.dart';
import 'package:student_app/network/api_constants.dart';
import 'package:student_app/network/response/email_response.dart';
import 'package:student_app/resources/colors.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/resources/strings.dart';
import 'package:student_app/widgets/title_text.dart';
import 'package:student_app/widgets/title_text_bold.dart';

class HomePage extends StatefulWidget {
  

  final String email;
  final String password;
  const HomePage(this.email, this.password);

  @override
  State<HomePage> createState() => _HomePageState(email,password);
}

class _HomePageState extends State<HomePage> {
//   final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
//  void _openDrawer() {
//     _drawerKey.currentState!.openDrawer();
//   }

  EmailResponse? mUser;
  final String email;
  final String password;

  DataModels userModels = DataModelsImpl();

  _HomePageState(this.email, this.password);

  @override
  void initState() {
    userModels.postLoginWithEmail(email,password)?.then((value) {
      setState(() {
        mUser = value;
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
                  DrawerHeaderSectionView(mUser: mUser),
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
    );
  }
}

class DrawerHeaderSectionView extends StatelessWidget {
  final EmailResponse? mUser;

  const DrawerHeaderSectionView({required this.mUser});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          height: marginMediumXXLarge,
        ),
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage("$baseUrl${mUser!.data!.profileImage}"
              // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR41Jl9Omn4hm2Kv7j7K4eVqFC16vrZ7zlDk6fXsjmtTbnNNrGuD3ESEOcpdSsg6tP7h4s&usqp=CAU"
              ),
        ),
        const SizedBox(
          width: marginMedium,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleTextBold("${mUser!.data!.name}", textSize: textRegular1X),
            Row(
              children: [
                TitleText(
                  "${mUser!.data!.email}",
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
