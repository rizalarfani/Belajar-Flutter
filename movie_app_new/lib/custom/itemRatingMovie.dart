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
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          '$titleRating',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromRGBO(156, 173, 244, 10),
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
