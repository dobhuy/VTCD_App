import 'package:flutter/material.dart';
import 'package:vtcc_app/src/screens/home_screen.dart';
import 'package:vtcc_app/src/screens/image_pick.dart';
import 'package:vtcc_app/src/screens/main_screen.dart';

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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MainScreen(),
    );
  }
}
