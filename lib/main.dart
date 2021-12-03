import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_app/data/model/data_models_impl.dart';
import 'package:student_app/data/vos/data_vo.dart';
import 'package:student_app/page/splash_screen_page.dart';
import 'package:student_app/persistence/hive_constants.dart';

import 'data/vos/card_vo.dart';
import 'data/vos/user_vo.dart';

void main() async {
  //check from DataAgents
  // DataAgentsImpl()
  //     .postRegisterWithEmail("testpjj", "testpjj@gmail.com", "123456",
  //         "959123456789012345", "", "")
  //     ?.then((value) {
  //   print(value.message);
  //   print(value.code);
  //   print(value.data);
  //   print(value.token);
  // });

  //check from DataModels
  // DataModelsImpl()
  //     .postLoginWithEmail("testpjj@gmail.com", "123456")
  //     ?.then((value) {
  //   print(value.code);
  //   print(value.message);
  //   print(value.data);
  //   print(value.token);
  // });

  DataModelsImpl().getComingSoonMovie("comingsoon")?.then((value) {
    debugPrint(value.toString());
  });

  //need to import hive_flutter packages
  await Hive.initFlutter();

  Hive.registerAdapter(UserVOAdapter());
  Hive.registerAdapter(CardVOAdapter());
  Hive.registerAdapter(DataVOAdapter());

  await Hive.openBox<UserVO>(boxNameUserVO);
  await Hive.openBox<CardVO>(boxNameCardVO);
  await Hive.openBox<String>(boxNameTokenVO);
  await Hive.openBox<DataVO>(boxNameDataVO);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
