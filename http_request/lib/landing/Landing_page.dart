import 'package:flutter/material.dart';
import 'package:http_request/lansia/Maps_lansia.dart';
import 'package:http_request/beranda/Beranda_page.dart';
import 'package:http_request/login.dart';
import 'package:http_request/berita/listBerita.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Landingpage extends StatefulWidget {
  @override
  _LandingpageState createState() => _LandingpageState();
}

class _LandingpageState extends State<Landingpage> {

  var statusIsLogin;
  getPrev() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      statusIsLogin = pref.getInt("status");
    });
  }

  logOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      pref.remove("id");
      pref.remove("status");
      pref.remove("name");
    });
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
      return new Landingpage();
    }));
  }

  int _bottomNavIndex = 0;
  List<Widget> _container = [
    BerandaPage(),
    MapsLansia(),
    ListBerita(),
    Login(),
  ];

  @override
  void initState() {
    super.initState();
    getPrev();
  }

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
          _bottomNavIndex = statusIsLogin == 200 && i == 3 ? logOut() : i;
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
            statusIsLogin == 200 ? Icons.settings_bluetooth : Icons.verified_user,
            color: Colors.grey
          ),
          title: Text(
            statusIsLogin == 200 ? "Logout" : "Login"
          ),
        ),
      ],
    );
  }

}