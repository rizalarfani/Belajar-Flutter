import 'package:flutter/material.dart';

// Runn app adalah method untuk raning class atau widget pertama kali
// void main(){
//   runApp(Container(
//     color: Colors.blueAccent,
//   ));
// }

// void main() => runApp(Myapp());

// class Myapp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color:  Colors.blueAccent,
//     );
//   }
// }

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Myapp(),
    ));

class Myapp extends StatefulWidget {
  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.settings_backup_restore),
        
      ),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Movie Apps"),
        actions: <Widget>[
          Icon(Icons.android),
          Icon(Icons.settings_applications),
        ],
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            FlutterLogo(
              style: FlutterLogoStyle.markOnly,
              size: 100.0,
            ),
            Text(
              "Flutter Classroom Beginer",
              style: TextStyle(
                fontSize: 20,
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold
              ),
            ),
            Text("Fasilitator : Edi Kurniawan"),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(
                  Icons.ac_unit,
                  size: 70,
                ),
                Icon(
                  Icons.home,
                  size: 70,
                ),
                Icon(
                  Icons.person,
                  size: 70,
                )
              ],
            )
          ],
        ),
      )
    );
  }
}
