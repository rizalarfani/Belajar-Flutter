import 'package:flutter/material.dart';

class GojekAppBar extends AppBar {
  GojekAppBar ()
    : super (
      elevation : 0.25,
      backgroundColor: Colors.white,
      flexibleSpace : _buildGojekAppBar()
    );
  static Widget _buildGojekAppBar ()
  {
    return Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset(
            "assets/logo_gojek.png",
            height: 50.0,
            width: 80.0,
          ),
          Container (
            child: Row( 
              children: <Widget>[
                Container(
                  height: 25.0,
                  width: 25.0,
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius:  BorderRadius.all(Radius.circular(100.0)),
                    color: Colors.orangeAccent
                  ),
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.local_bar,
                    color: Colors.white,
                    size: 15.0,
                  ),
                ),
                Container (
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(0.7)
                    ),
                    color: Color(0x50FFD180)
                  ),
                  child: Text(
                    "1.7781 Poin",
                    style: TextStyle(fontSize: 13.0),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}