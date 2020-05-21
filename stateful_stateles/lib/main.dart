import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int number = 0;
  void tekanTombol() {
    setState(() {
      number++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("StateFul Widget")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                number.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10 + number.toDouble(),
                    color: Colors.blueAccent),
              ),
              RaisedButton(
                onPressed: tekanTombol,
                child: Text(
                  "Tambah Bilangan",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                color: Colors.blue,
              ),
              SizedBox(
                width: 50.0,
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    number = 0;
                  });
                },
                child: Text(
                  'Reset Number',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                color: Colors.orangeAccent,
              )
            ],
          ),
        ),
      ),
    );
  }
}
