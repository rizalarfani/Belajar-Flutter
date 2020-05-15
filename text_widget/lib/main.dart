import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Text widget"),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Container(
              color: Colors.blue,
              height: 50.0,
              width: 150.0,
              child: Text(
                'Text Widget',
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 18.0,fontWeight: FontWeight.w500),
              )
          ),
        ),
      ),
    );
  }
}
