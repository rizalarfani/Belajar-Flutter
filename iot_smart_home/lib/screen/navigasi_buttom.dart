import 'package:flutter/material.dart';
import 'home/Home.dart';

class Navigasi_buttom extends StatefulWidget {
  @override
  _Navigasi_buttomState createState() => _Navigasi_buttomState();
}

class _Navigasi_buttomState extends State<Navigasi_buttom> {

  var _bottomNavIndex = 0;
  List<Widget> _container = [
    Home()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _container[_bottomNavIndex],
      bottomNavigationBar: _buildBottimNavigasi(),
    );
  }

  Widget _buildBottimNavigasi(){
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: (i) {
        setState(() {
          _bottomNavIndex;
        });
      },
      currentIndex: _bottomNavIndex,
      items: [
        BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.home,
            color: Colors.blueAccent,
          ),
          icon: Icon(
            Icons.home,
            color: Colors.blueAccent,
          ),
          title: Text("Home")
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.move_to_inbox,
            color: Colors.blueAccent,
          ),
          icon: Icon(
            Icons.move_to_inbox,
            color: Colors.blueAccent,
          ),
          title: Text("Monitoring")
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.control_point,
            color: Colors.blueAccent,
          ),
          icon: Icon(
            Icons.control_point,
            color: Colors.blueAccent,
          ),
          title: Text("Controll")
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.account_circle,
            color: Colors.blueAccent,
          ),
          icon: Icon(
            Icons.account_circle,
            color: Colors.blueAccent,
          ),
          title: Text("Accunt")
        ),
      ],
    );
  }
}

