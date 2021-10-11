import 'package:flutter/material.dart';
import 'package:student_app/resources/colors.dart';
import 'package:student_app/resources/dimens.dart';
import 'package:student_app/resources/strings.dart';
import 'package:student_app/widgets/title_text.dart';
import 'package:student_app/widgets/title_text_bold.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
                  const DrawerHeaderSectionView(),
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
  const DrawerHeaderSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          height: marginMediumXXLarge,
        ),
        const CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR41Jl9Omn4hm2Kv7j7K4eVqFC16vrZ7zlDk6fXsjmtTbnNNrGuD3ESEOcpdSsg6tP7h4s&usqp=CAU"),
        ),
        const SizedBox(
          width: marginMedium,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleTextBold("Lily Johnson", textSize: textRegular1X),
            Row(
              children: const [
                TitleText(
                  "lilyjohnson@gmail.com",
                  textSize: textRegular,
                ),
                SizedBox(width: marginMedium1X),
                TitleText(
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
