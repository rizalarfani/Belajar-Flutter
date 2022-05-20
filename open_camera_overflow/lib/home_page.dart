import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:open_camera_overflow/camera_page.dart';

class HomePage extends StatefulWidget {
  final String? title;
  const HomePage({Key? key, this.title}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? imagePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: imagePath != null
          ? Container(
              margin: const EdgeInsets.all(25),
              child: Image.file(
                imagePath!,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ))
          : noImage(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          availableCameras().then((camera) async {
            final _imagePath = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CameraPage(camera: camera)));
            setState(() => imagePath = _imagePath);
          });
        },
        tooltip: 'Take camera',
        child: const Icon(Icons.camera),
      ),
    );
  }
}

Widget noImage() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(
          Icons.image,
          size: 50,
        ),
        SizedBox(height: 20),
        Text(
          'No Image Captured',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
        )
      ],
    ),
  );
}
