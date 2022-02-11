import 'dart:io';
import 'dart:math';

import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class FileUtils {
  List docExtention = ['.pdf'];
  static List<FileSystemEntity> listPdf = <FileSystemEntity>[];

  /// Convert Byte to KB, MB, .......
  static String formatBytes(bytes, decimals) {
    if (bytes == 0) return '0.0 KB';
    var k = 1024,
        dm = decimals <= 0 ? 0 : decimals,
        sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
        i = (log(bytes) / log(k)).floor();
    return (((bytes / pow(k, i)).toStringAsFixed(dm)) + ' ' + sizes[i]);
  }

  /// Get mime information of a file
  static String getMime(String path) {
    File file = File(path);
    String mimeType = mime(file.path) ?? '';
    return mimeType;
  }

  static Directory removeDataDirectory(String path) {
    return Directory(path.split('Android')[0]);
  }

  /// Get all Files and Directories in a Directory
  static Future<List<FileSystemEntity>> getFilesInPath(String path) async {
    Directory dir = Directory(path);
    return dir.listSync();
  }

  /// Return all available Storage path
  static Future<List<Directory>> getStorageList() async {
    List<Directory> paths = (await getExternalStorageDirectories())!;
    List<Directory> filteredPaths = <Directory>[];
    for (Directory dir in paths) {
      filteredPaths.add(removeDataDirectory(dir.path));
    }
    return filteredPaths;
  }

  /// Get all Files on the Device
  static Future<List<FileSystemEntity>> getAllFiles(
      {bool showHiden = false}) async {
    List<Directory> storages = await getStorageList();
    List<FileSystemEntity> files = <FileSystemEntity>[];
    for (Directory dir in storages) {
      List<FileSystemEntity> allFilesInPath = [];
      try {
        allFilesInPath =
            await getAllFilesInPath(dir.path, showHiden: showHiden);
      } catch (e) {
        print(e.toString());
      }
      files.addAll(allFilesInPath);
    }
    return files;
  }

  // Get all Files
  static Future<List<FileSystemEntity>> getAllFilesInPath(String path,
      {bool showHiden = false}) async {
    List<FileSystemEntity> files = <FileSystemEntity>[];
    Directory dir = Directory(path);
    List<FileSystemEntity> listSync = dir.listSync();
    for (FileSystemEntity file in listSync) {
      if (FileSystemEntity.isFileSync(file.path)) {
        if (!showHiden) {
          if (!basename(file.path).startsWith('.')) {
            files.add(file);
          }
        } else {
          files.add(file);
        }
      } else {
        if (!file.path.contains('/storage/emulated/0/Android')) {
          if (!showHiden) {
            if (!basename(file.path).startsWith('.')) {
              files.addAll(
                  await getAllFilesInPath(file.path, showHiden: showHiden));
            }
          } else {
            files.addAll(
                await getAllFilesInPath(file.path, showHiden: showHiden));
          }
        }
      }
    }
    return files;
  }

  static Future<List> getFileType(List docExtention) async {
    List<FileSystemEntity> file = await getAllFiles(showHiden: false);
    for (FileSystemEntity entity in file) {
      if (docExtention.contains(extension(entity.path))) {
        listPdf.add(entity);
      }
    }
    return listPdf;
  }
}
