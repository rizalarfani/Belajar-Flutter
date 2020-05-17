import 'package:flutter/material.dart';
import 'SplashScreen.dart';
import 'package:clone_gojek/constant.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Clone GoJek",
      theme: ThemeData(
        fontFamily: 'Pluto',
        primaryColor: GojekPalet.green,
        accentColor: GojekPalet.green
      ),
      home: SplashScreen(),
    );
  }
}