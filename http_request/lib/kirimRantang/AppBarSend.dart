import 'package:flutter/material.dart';

class AppBarSend extends AppBar {
  AppBarSend()
      : super(
            elevation: 0.25,
            backgroundColor: Colors.blueAccent,
            flexibleSpace: _buildAppBar());

  static Widget _buildAppBar() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(left: 15.0, right: 15.0,top: 5.0,bottom: 5.0),
        color: Colors.blueAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              "assets/logo/logo_jempolan.png",
              height: 50.0,
              width: 50.0,
            ),
            Text(
              "Jempolan",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            )
          ],
        ),
      ),
    );
  }
}
