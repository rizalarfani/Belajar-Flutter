import 'dart:io';

import 'package:file_pdf/utils/fileUtils.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class CardView extends StatelessWidget {
  final FileSystemEntity entity;
  const CardView({Key? key, required this.entity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      child: ListTile(
        onTap: () {
          print(entity.path);
        },
        leading: Icon(Icons.document_scanner),
        title: Text(
          '${basename(entity.path)}',
          style: TextStyle(fontSize: 14),
          maxLines: 2,
        ),
        subtitle:
            Text('${FileUtils.formatBytes(File(entity.path).lengthSync(), 2)}'),
      ),
    );
  }
}
