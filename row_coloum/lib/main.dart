import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Belajar Row Dan Coloum"),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    "Colum 1 dan Row 1",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                  height: 50.0,
                  width: 160.0,
                  color: Colors.blue,
                ),
                Container(
                  child: Text(
                    "Colum 1 dan Row 2",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                  height: 50.0,
                  width: 160.0,
                  color: Colors.lightBlue,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
