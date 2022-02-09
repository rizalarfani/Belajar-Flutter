import 'dart:io';

import 'package:file_managet_test/widget/cardView.dart';
import 'package:flutter/material.dart';
import 'package:file_manager/file_manager.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  final String? title;
  final FileManagerController? controller;
  const HomePage({Key? key, this.title, this.controller}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: FileManager(
            controller: widget.controller!,
            builder: (context, snapshot) {
              final List<FileSystemEntity> entites = snapshot;
              return (entites.isEmpty)
                  ? Center(
                      child: Text('Is Empety'),
                    )
                  : ListView.builder(
                      itemCount: entites.length,
                      itemBuilder: (context, index) {
                        FileSystemEntity entity = entites[index];
                        return CardView(
                          entity: entity,
                          controller: widget.controller,
                        );
                      },
                    );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.ac_unit_outlined),
      ),
    );
  }
}
