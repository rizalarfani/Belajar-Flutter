import 'package:flutter/material.dart';
import 'package:file_manager/file_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'screen/homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final FileManagerController? controller = FileManagerController();
  PermissionStatus? permissionStatus = PermissionStatus.denied;

  void listenPermissionStatus() async {
    var status = await Permission.storage.status;
    setState(() => permissionStatus = status);
    print(status);
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

  void requestPermission() async {
    var status = await Permission.storage.request();
    setState(() => permissionStatus = status);
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    listenPermissionStatus();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      listenPermissionStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WillPopScope(
        onWillPop: () async {
          if (await controller!.isRootDirectory()) {
            return true;
          } else {
            controller!.goToParentDirectory();
            return false;
          }
        },
        child: HomePage(
          title: 'File Manager',
          controller: controller,
        ),
      ),
    );
  }
}
