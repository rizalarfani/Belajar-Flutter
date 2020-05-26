import 'package:flutter/material.dart';
import 'package:http_request/lansia/Maps_lansia.dart';
import 'package:http_request/beranda/Beranda_page.dart';
import 'package:http_request/login.dart';
import 'package:http_request/berita/listBerita.dart';

class Landing_page extends StatefulWidget {
  @override
  _Landing_pageState createState() => _Landing_pageState();
}

class _Landing_pageState extends State<Landing_page> {

  int _bottomNavIndex = 0;
  List<Widget> _container = [
    Beranda_page(),
    Maps_lansia(),
    ListBerita(),
    Login()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _container[_bottomNavIndex],
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildBottomNavigation ()
  {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: (i) {
        setState(() {
          _bottomNavIndex = i;
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
            color: Colors.grey
          ),
          title: Text(
            "Beranda"
          ),
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.map,
            color: Colors.blueAccent,
          ),
          icon: Icon(
            Icons.map,
            color: Colors.grey
          ),
          title: Text(
            "Peta Lansia"
          ),
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.new_releases,
            color: Colors.blueAccent,
          ),
          icon: Icon(
            Icons.new_releases,
            color: Colors.grey
          ),
          title: Text(
            "Berita"
          ),
        ),
        BottomNavigationBarItem( 
          activeIcon: Icon(
            Icons.verified_user,
            color: Colors.blueAccent,
          ),
          icon: Icon(
            Icons.verified_user,
            color: Colors.grey
          ),
          title: Text(
            "Login"
          ),
        ),
      ],
    );
  }

}