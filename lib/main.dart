import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_app/data/model/data_models_impl.dart';
import 'package:student_app/data/vos/cinemas_vo.dart';
import 'package:student_app/data/vos/data_vo.dart';
import 'package:student_app/data/vos/payment_method_vo.dart';
import 'package:student_app/data/vos/timeslotdata_vo.dart';
import 'package:student_app/page/home_page.dart';
import 'package:student_app/page/splash_screen_page.dart';
import 'package:student_app/persistence/hive_constants.dart';
import 'data/vos/card_vo.dart';
import 'data/vos/casts_vo.dart';
import 'data/vos/snack_vo.dart';
import 'data/vos/timeslots_vo.dart';
import 'data/vos/user_vo.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(UserVOAdapter());
  Hive.registerAdapter(CardVOAdapter());
  Hive.registerAdapter(DataVOAdapter());
  Hive.registerAdapter(CastsVOAdapter());
  Hive.registerAdapter(CinemasVOAdapter());
  Hive.registerAdapter(TimeslotsVOAdapter());
  Hive.registerAdapter(TimeSlotDataVOAdapter());
  Hive.registerAdapter(SnackVOAdapter());
  Hive.registerAdapter(PaymentMethodVOAdapter());

  await Hive.openBox<UserVO>(boxNameUserVO);
  await Hive.openBox<CardVO>(boxNameCardVO);
  await Hive.openBox<DataVO>(boxNameDataVO);
  await Hive.openBox<String>(boxNameTokenVO);
  await Hive.openBox<DataVO>(boxNameMovieDetailsVO);
  await Hive.openBox<TimeSlotDataVO>(boxNameCinemaTimeSlotDataVO);
  await Hive.openBox<SnackVO>(boxNameSnackVO);
  await Hive.openBox<PaymentMethodVO>(boxNamePaymentMethodVO);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DataModelsImpl dataModels = DataModelsImpl();

  @override
  void initState() {
    super.initState();
    dataModels.isLogIn();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: dataModels.isLogIn() ? const HomePage() : const SplashScreen(),
    );
  }
}
