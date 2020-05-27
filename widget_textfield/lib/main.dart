import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Widget Text Field"),
        ),
        body: _buildTextFiled()
      ),
    );
  }

  Widget _buildTextFiled()
  {
    return Container(
          margin: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: username,
                onTap: () {},
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    fillColor: Colors.blue,
                    prefixIcon: Icon(Icons.person),
                    labelText: "Masukan Username"),
              ),
              TextField(
                controller: password,
                expands: false,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    fillColor: Colors.blue,
                    prefixIcon: Icon(Icons.person_pin),
                    suffixIcon: Icon(Icons.visibility_off),
                    labelText: "Masukan Password"),
              ),
            ],
          ),
        );
  }

}
