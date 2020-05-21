import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List<Widget> menu = [];
  int counter = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("ListView Widget"),
        ),
        body: ListView(
          children: <Widget> [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    setState(() {
                      menu.add(Text("Data Ke "+ counter.toString(),style: TextStyle(fontSize: 30.0, color: Colors.blue),));
                      counter++;
                    });
                  },
                  child: Text("Tambah Data"),
                ),
                RaisedButton(
                  onPressed: () {
                    setState(() {
                      menu.removeLast();
                      counter--;
                    });
                  },
                  child: Text('Hapus Data'),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: menu,
            )
          ],
        ),
      ),
    );
  }
}
