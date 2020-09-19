import 'package:flutter/material.dart';

class ItemRatingMovie extends StatelessWidget {
  final String rating;
  final String titleRating;
  const ItemRatingMovie({Key key, this.rating, this.titleRating})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          '$rating',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(
          '$titleRating',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
