import 'package:flutter/material.dart';

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
      home: Scaffold(
        appBar: AppBar(title: Text("Widget Container"),),
        body: Container(
          color: Colors.blueAccent,
          margin: EdgeInsets.all(30.0),
          padding: EdgeInsets.all(25.0),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.0),
              gradient: LinearGradient(colors: <Color>[
              Colors.yellow,
              Colors.redAccent
            ])),
          ),
        ),
      ),
    );
  }
}