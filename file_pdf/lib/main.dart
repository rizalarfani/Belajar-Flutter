import 'package:file_pdf/screen/mainPage.dart';
import 'utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Permission? permission;
  PermissionStatus permissionStatus = PermissionStatus.denied;

  Future<void> listTenPermission() async {
    var status = await Permission.storage.status;
    setState(() => permissionStatus = status);
    switch (status) {
      case PermissionStatus.denied:
        requestPermission();
        break;
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        break;
      default:
    }
  }

  Future<void> requestPermission() async {
    var status = await Permission.storage.request();
    setState(() => permissionStatus = status);
  }

  @override
  void initState() {
    listTenPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(title: 'File Sort PDF'),
    );
  }
}
