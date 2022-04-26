import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_app/data/model/data_models_impl.dart';
import 'package:student_app/data/vos/card_vo.dart';
import 'package:student_app/data/vos/casts_vo.dart';
import 'package:student_app/data/vos/movie_vo.dart';
import 'package:student_app/data/vos/timeslotdata_vo.dart';
import 'package:student_app/data/vos/user_vo.dart';
import 'package:student_app/page/home_page.dart';
import 'package:student_app/page/splash_screen_page.dart';
import 'package:student_app/persistence/hive_constants.dart';
import 'data/vos/cinemas_vo.dart';
import 'data/vos/timeslots_vo.dart';

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

  // DataModelsImpl().getCinemaNameAndTimeSlots("2022-01-28")?.then((value) {
  //   print(value.toString());
  // });

  //need to import hive_flutter packages
  await Hive.initFlutter();

  Hive.registerAdapter(UserVOAdapter());
  Hive.registerAdapter(CardVOAdapter());
  Hive.registerAdapter(MovieVOAdapter());
  Hive.registerAdapter(CastsVOAdapter());
  Hive.registerAdapter(CinemasVOAdapter());
  Hive.registerAdapter(TimeSlotDataVOAdapter());
  Hive.registerAdapter(TimeslotsVOAdapter());

  await Hive.openBox<UserVO>(boxNameUserVO);
  await Hive.openBox<CardVO>(boxNameCardVO);
  await Hive.openBox<MovieVO>(boxNameMovieVO);
  await Hive.openBox<CastsVO>(boxNameCastsVO);
  await Hive.openBox<String>(boxNameTokenVO);
  await Hive.openBox<CinemasVO>(boxNameCinemaVO);
  await Hive.openBox<TimeSlotDataVO>(boxNameTimeSlotDataVO);

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

  // String? token = "";

  @override
  void initState() {
    super.initState();
    //Method 1 to check token
    // dataModels.getTokenFromDatabase()?.then((value) {
    //   setState(() {
    //     token = value;
    //   });
    // });

    //Method 2 to check token
    dataModels.isLogIn();

    // cause of token , check the movieSeatApi in this state!
    // DataModelsImpl()
    //     .getMovieSeat(1, "8-2-2022")
    //     .then((value) => print(value.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // home: (token != "" && token != null)
      //     ? const HomePage()
      //     : const SplashScreen(),

      home: dataModels.isLogIn() ? const HomePage() : const SplashScreen(),
    );
  }
}

