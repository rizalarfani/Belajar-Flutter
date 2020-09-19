import 'package:flutter/material.dart';

class PosterMovie extends StatelessWidget {
  final int selectPage;
  final int index;
  final String imgUrl;

  const PosterMovie({Key key, this.selectPage, this.index, this.imgUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: selectPage == index ? 130 : 150, horizontal: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          "$imgUrl",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
