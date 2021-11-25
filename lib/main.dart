import 'package:flutter/material.dart';
import 'package:student_app/data/model/data_models_impl.dart';
import 'package:student_app/page/splash_screen_page.dart';

void main() {
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
