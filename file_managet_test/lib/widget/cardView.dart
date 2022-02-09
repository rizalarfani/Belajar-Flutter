import 'dart:io';

import 'package:file_manager/file_manager.dart';
import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  final FileSystemEntity entity;
  final FileManagerController? controller;
  const CardView({Key? key, required this.entity, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: FileManager.isFile(entity)
            ? Icon(Icons.feed_outlined)
            : Icon(Icons.folder),
        title: Text(FileManager.basename(entity)),
        subtitle: subtitle(entity),
        onTap: () async {
          if (FileManager.isDirectory(entity)) {
            controller!.openDirectory(entity);
          } else {}
        },
      ),
    );
  }

  Widget subtitle(FileSystemEntity entity) {
    return FutureBuilder<FileStat>(
      future: entity.stat(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (entity is File) {
            int size = snapshot.data!.size;
            return Text(
              "${FileManager.formatBytes(size)}",
            );
          }
          return Text(
            "${snapshot.data!.modified}",
          );
        } else {
          return Text("");
        }
      },
    );
  }
}
