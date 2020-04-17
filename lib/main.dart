import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netflix/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      // statusBarColor: Color(0xff0f0f0f),
      systemNavigationBarColor: Color(0xff0f0f0f),
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
