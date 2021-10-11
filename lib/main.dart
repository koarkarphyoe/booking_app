import 'package:flutter/material.dart';
import 'package:student_app/page/home_page.dart';
import 'package:student_app/page/movie_details_page.dart';
import 'package:student_app/page/movie_seats_page.dart';
import 'package:student_app/page/movie_choose_time.dart';
import 'package:student_app/page/payment_method_page.dart';
import 'package:student_app/page/paymethod_card_page.dart';
import 'package:student_app/page/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MovieChooseTime(),
    );
  }
}
