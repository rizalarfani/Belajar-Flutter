import 'package:flutter/material.dart';
import 'screen/home.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),
    themeMode: ThemeMode.dark,
    home: Home(),
  )
);