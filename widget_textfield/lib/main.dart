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
        body: _buildLogin()
      ),
    );
  }

  Widget _buildLogin() {
    return Scaffold(
      body: Stack(
        overflow: Overflow.visible, 
        children: <Widget>[
          Container(
              width: double.infinity,
              height: 300.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(35)),
                  color: Colors.blueAccent),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "JEMPOLAN",
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                ],
              )),
          Positioned(
            top: 250,
            child: Container(
              height: 600,
             width: 300.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: Colors.white),
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Login Pendamping",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      controller: username,
                      onTap: () {},
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          fillColor: Colors.blue,
                          prefixIcon: Icon(Icons.person),
                          labelText: "Masukan Username"),
                    ),
                    SizedBox(
                      height: 20.0,
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
                    SizedBox(
                      height: 20.0,
                    ),
                    RaisedButton(
                      onPressed: (){},
                      child: Text("Login",style: TextStyle(fontSize: 15.0,color: Colors.white,fontWeight: FontWeight.bold),),
                      color: Colors.blueAccent,
                    ),
                  ],
                ),
              ),
            ),
          )
        ]),
    );
  }

}
