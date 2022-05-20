import 'dart:io';
import 'dart:math';

import 'package:image/image.dart' as img;
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  final List<CameraDescription> camera;
  const CameraPage({Key? key, required this.camera}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? imagePath;
  bool? togleCamera = false;
  CameraController? controller;

  @override
  void initState() {
    onCameraSelected(widget.camera[0]);
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return cameraPreviewWidget();
  }

  Widget cameraPreviewWidget() {
    if (widget.camera.isEmpty || !controller!.value.isInitialized) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16.0),
        child: const Text(
          'No Camera Found',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
      );
    } else {
      return AspectRatio(
        aspectRatio: controller!.value.aspectRatio,
        child: Container(
          child: Stack(
            children: <Widget>[
              CameraPreview(controller!),
              cameraOverlay(
                padding: 50,
                aspectRatio: 1,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 120.0,
                  padding: const EdgeInsets.all(20.0),
                  // color: const Color.fromRGBO(00, 00, 00, 0.3),
                  color: Colors.black12,
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50.0)),
                            onTap: () => captureImage(),
                            child: Container(
                              padding: const EdgeInsets.all(4.0),
                              child: const Icon(
                                Icons.camera_alt_rounded,
                                size: 42,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(4.0),
                              child: const Icon(
                                Icons.toggle_off,
                                size: 42,
                                color: Colors.white,
                              ),
                            ),
                            onTap: () {
                              if (!togleCamera!) {
                                onCameraSelected(widget.camera[1]);
                                setState(() => togleCamera = true);
                              } else {
                                onCameraSelected(widget.camera[0]);
                                setState(() => togleCamera = false);
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget cameraOverlay({double? padding, double? aspectRatio}) {
    return LayoutBuilder(builder: (context, constraints) {
      double parentAspectRatio = constraints.maxWidth / constraints.maxHeight;
      double horizontalPadding;
      double verticalPadding;
      print(parentAspectRatio);
      if (parentAspectRatio < aspectRatio!) {
        horizontalPadding = padding!;
        verticalPadding = (constraints.maxHeight -
                ((constraints.maxWidth - 2 * padding) / aspectRatio)) /
            2;
      } else {
        verticalPadding = padding!;
        horizontalPadding = (constraints.maxWidth -
                ((constraints.maxHeight - 2 * padding) * aspectRatio)) /
            2;
      }
      return Stack(
        fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(width: horizontalPadding, color: Colors.black12),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(width: horizontalPadding, color: Colors.black12),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
                margin: EdgeInsets.only(
                    left: horizontalPadding, right: horizontalPadding),
                height: verticalPadding,
                color: Colors.black12),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                margin: EdgeInsets.only(
                    left: horizontalPadding, right: horizontalPadding),
                height: verticalPadding,
                color: Colors.black12),
          ),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: horizontalPadding, vertical: verticalPadding),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
            ),
          )
        ],
      );
    });
  }

  void captureImage() {
    takePictures().then((String? filePath) async {
      if (mounted) {
        img.Image? image = img.decodeImage(File(filePath!).readAsBytesSync());
        var cropSize = min(image!.width, image.height);
        int offsetX = (image.width - min(image.width, image.height)) ~/ 2;
        int offsetY = (image.height - min(image.width, image.height)) ~/ 2;
        img.Image? cropImage =
            img.copyCrop(image, offsetX, offsetY, cropSize, cropSize);
        File? fileOri =
            await File(filePath).writeAsBytes(img.encodeJpg(cropImage));
        setState(() => imagePath = fileOri);
        if (filePath != null) {
          print('Picture saved to ' + filePath);
          Navigator.pop(context, imagePath);
        }
      }
    });
  }

  Future<String> takePictures() async {
    String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
    if (!controller!.value.isInitialized) {
      print('Error: select a camera first.');
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Images';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (controller!.value.isTakingPicture) {
      print('A capture is already pending, do nothing.');
    }

    try {
      final image = await controller!.takePicture();
      image.saveTo(filePath);
    } catch (e) {
      print(e);
    }
    return filePath;
  }

  void onCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) await controller!.dispose();
    controller = CameraController(cameraDescription, ResolutionPreset.medium);
    controller!.addListener(() {
      if (mounted) setState(() {});
      if (controller!.value.hasError) {
        print('Camera Error: ${controller!.value.errorDescription}');
      }
    });

    try {
      await controller!.initialize();
    } on CameraException catch (e) {
      print(e);
    }
    if (mounted) setState(() {});
  }
}
