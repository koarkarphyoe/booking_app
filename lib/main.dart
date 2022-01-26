import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_app/data/model/data_models_impl.dart';
import 'package:student_app/data/vos/casts_vo.dart';
import 'package:student_app/data/vos/data_vo.dart';
import 'package:student_app/data/vos/movie_details_vo.dart';
import 'package:student_app/network/data_agents/data_agents_impl.dart';
import 'package:student_app/network/response/email_response.dart';
import 'package:student_app/page/home_page.dart';
import 'package:student_app/page/splash_screen_page.dart';
import 'package:student_app/page/login_page.dart';
import 'package:student_app/persistence/hive_constants.dart';
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

  // take movie details with movieId
  // DataAgentsImpl().getMovieDetails(634649)?.then((value) {
  //   print(value.data.toString());
  // });

  // DataModelsImpl().getMovieDetails(634649)?.then((value) {
  //   print(value?.posterPath.toString());
  // });

  DataModelsImpl().getCinemasList()?.then((value) {
    print(value.toString());
  });

  //need to import hive_flutter packages
  await Hive.initFlutter();

  Hive.registerAdapter(UserVOAdapter());
  Hive.registerAdapter(CardVOAdapter());
  Hive.registerAdapter(DataVOAdapter());
  Hive.registerAdapter(MovieDetailsVOAdapter());

  await Hive.openBox<UserVO>(boxNameUserVO);
  await Hive.openBox<CardVO>(boxNameCardVO);
  await Hive.openBox<DataVO>(boxNameDataVO);
  await Hive.openBox<MovieDetailsVO>(boxNameMovieDetailsVO);
  await Hive.openBox<String>(boxNameTokenVO);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  DataModelsImpl dataModels = DataModelsImpl();
  String? token = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataModels.getTokenFromDatabase()?.then((value) {
      setState(() {
        token = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: SplashScreen(),
      home: (token != "" && token != null)
          ? const HomePage()
          : const SplashScreen(),
    );
  }
}
