import 'package:flutter/material.dart';
import 'package:clone_gojek/beranda/beranda_appBar.dart';

class BerandaPage extends StatefulWidget {
  @override
  _BerandaPageState createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: GojekAppBar(),
        body: Center(
          child: Text("Halaman Beranda"),
        ),
      ),
    );
  }
}