import 'package:flutter/material.dart';
import 'package:clone_gojek/constant.dart';
import 'package:clone_gojek/beranda/BerandaPage.dart';

class Home_view extends StatefulWidget {
  @override
  _Home_viewState createState() => _Home_viewState();
}

class _Home_viewState extends State<Home_view> {

  int _bottomNavIndex = 0;
  List<Widget> _container = [
    new BerandaPage()
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _container[_bottomNavIndex],
      bottomNavigationBar: _buildBottomNovaigation(),
    );
  }

  Widget _buildBottomNovaigation ()
  {
    return new BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: (i) {
        setState(() {
          _bottomNavIndex = i;
          print(_bottomNavIndex);
        });
      },
      currentIndex: _bottomNavIndex,
      items: [
        BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.home,
            color: GojekPalet.green,
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
            Icons.assignment,
            color: GojekPalet.green,
          ),
          icon: Icon(
            Icons.assignment,
            color: Colors.grey,
          ),
          title: Text(
            "Pesanan"
          ),
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.mail,
            color: GojekPalet.green,
          ),
          icon: Icon(
            Icons.mail,
            color: Colors.grey,
          ),
          title: Text(
            "Inbox"
          ),
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.person,
            color: GojekPalet.green,
          ),
          icon: Icon(
            Icons.person,
            color: Colors.grey,
          ),
          title: Text(
            "Profile"
          ),
        ),
      ],
    );
  }

}