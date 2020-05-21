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
        appBar: AppBar(title: Text("Anonymous Method"),),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 200.0,
                width: 200.0,
                color: Colors.blue,
              ),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              RaisedButton(
                onPressed: () {},
                child: Text("Ganti Warna"),
                color: Colors.orange,
              )
            ],
          ),
        )
      ),
    );
  }
}
