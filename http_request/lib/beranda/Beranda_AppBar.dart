import 'package:flutter/material.dart';

class BerandaAppbar extends AppBar {
  String name;
  int statusLogin;
  BerandaAppbar({this.name,this.statusLogin})
      : super(
            elevation: 0.25,
            backgroundColor: Colors.blueAccent,
            flexibleSpace: _buildAppBar(statusLogin,name));

  static Widget _buildAppBar(status,name) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(left: 15.0, right: 15.0,top: 5.0,bottom: 5.0),
        color: Colors.blueAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.asset(
              "assets/logo/logo_jempolan.png",
              height: 50.0,
              width: 50.0,
            ),
            Text(
              "JEMPOLAN",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,),
                  textAlign: TextAlign.center,
            ),
            status == 200 ? Text(
              name.toString(),
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.white
              ),
            ) : Icon(
              Icons.account_circle,
              color: Colors.white,
              size: 30.0,
            )
          ],
        ),
      ),
    );
  }
}
