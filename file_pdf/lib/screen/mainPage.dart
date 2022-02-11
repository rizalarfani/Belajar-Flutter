import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_pdf/utils/utils.dart';
import 'package:path/path.dart';
import 'package:file_pdf/widget/cardView.dart';

class MainPage extends StatefulWidget {
  final String? title;
  const MainPage({Key? key, this.title}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List docExtention = ['.pdf'];

  @override
  void initState() {
    FileUtils.getFileType(docExtention);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: FileUtils.listPdf.length,
          itemBuilder: (context, index) {
            FileSystemEntity file = FileUtils.listPdf[index];
            return CardView(entity: file);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          List<FileSystemEntity> pdfFile = <FileSystemEntity>[];
          List<FileSystemEntity> file =
              await FileUtils.getAllFiles(showHiden: false);
          for (FileSystemEntity files in file) {
            if (docExtention.contains(extension(files.path))) {
              pdfFile.add(files);
            }
          }
          print(pdfFile);
          print(pdfFile.length);
        },
        child: Icon(Icons.cached),
      ),
    );
  }
}
