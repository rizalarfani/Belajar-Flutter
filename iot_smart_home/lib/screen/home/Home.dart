import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final DBrefFirebase = FirebaseDatabase.instance.reference();
  String statusLampu = "";
  String statusLampu2 = "";

  void getStatusLampu() async {
    Map<dynamic, dynamic> lampus;
    await DBrefFirebase.child('lampu/1')
        .once()
        .then((DataSnapshot snapshot) => {lampus = snapshot.value});
    setState(() {
      statusLampu = lampus.values.toString();
    });
  }

  void getStatusLampu2() async {
    Map<dynamic, dynamic> lampus;
    await DBrefFirebase.child('lampu/2')
        .once()
        .then((DataSnapshot snapshot) => {lampus = snapshot.value});
    setState(() {
      statusLampu2 = lampus.values.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    getStatusLampu();
    getStatusLampu2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Lampu 1" + statusLampu,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            RaisedButton(
              onPressed: () {
                if (statusLampu == "(on)") {
                  setState(() {
                    DBrefFirebase.child('lampu/1').update({'status': 'off'});
                    getStatusLampu();
                  });
                } else {
                  setState(() {
                    DBrefFirebase.child('lampu/1').update({'status': 'on'});
                    getStatusLampu();
                  });
                }
              },
              color: Colors.blueAccent,
              textColor: Colors.white,
              child: Text(
                  statusLampu == "(on)" ? "Matikan lampu" : "Nyalakan lampu"),
            ),
            SizedBox(height: 30),
            Text(
              "Lampu 2" + statusLampu2,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            RaisedButton(
              onPressed: () {
                if (statusLampu2 == "(on)") {
                  setState(() {
                    DBrefFirebase.child('lampu/2').update({'status': 'off'});
                    getStatusLampu2();
                  });
                } else {
                  setState(() {
                    DBrefFirebase.child('lampu/2').update({'status': 'on'});
                    getStatusLampu2();
                  });
                }
              },
              color: Colors.blueAccent,
              textColor: Colors.white,
              child: Text(
                  statusLampu2 == "(on)" ? "Matikan lampu" : "Nyalakan lampu"),
            ),
          ],
        ),
      ),
    );
  }
}
