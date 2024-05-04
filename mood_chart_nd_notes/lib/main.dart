import 'package:flutter/material.dart';
import 'package:mood_chart_nd_notes/pages/SignIn.dart';
import 'package:mood_chart_nd_notes/pages/calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calendar(),
    );
  }
}
