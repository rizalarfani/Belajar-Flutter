import 'package:flutter/material.dart';

class ItemTab extends StatelessWidget {
  final String title;
  final IconData icon;

  const ItemTab({Key key, this.title, this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          Icon(icon),
          SizedBox(
            width: 15,
          ),
          Text(
            "$title",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
