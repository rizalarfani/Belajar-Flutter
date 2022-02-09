import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  PermissionStatus? _permissionStatus = PermissionStatus.denied;

  Future<void> _listenForPermissionStatus() async {
    var status = await Permission.storage.status;
    setState(() => _permissionStatus = status);
    switch (status) {
      case PermissionStatus.denied:
        requestPermission();
        break;
      case PermissionStatus.undetermined:
        break;
      case PermissionStatus.granted:
        break;
      case PermissionStatus.restricted:
        break;
      case PermissionStatus.limited:
        break;
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        break;
    }
  }

  void requestPermission() async {
    var status = Permission.storage.request();
    setState(() => _permissionStatus = status as PermissionStatus);
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    _listenForPermissionStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: requestPermission,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
