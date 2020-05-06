
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Capture extends StatefulWidget {
  @override
  _CaptureState createState() => _CaptureState();
}

class _CaptureState extends State<Capture> {
  CameraController controller;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    availableCameras().then((cameras) {
      CameraDescription rearCamera = cameras.firstWhere(
              (desc) => desc.lensDirection == CameraLensDirection.back, orElse: () => null);
      if (rearCamera == null) {
        return;
      }

      controller = CameraController(rearCamera, ResolutionPreset.high);
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget preview;

    if (!_isReady()) {
      preview = Container();
    } else {
      preview = Container(
          child: Center(
              child: AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: CameraPreview(controller))
          )
      );
    }
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text("Camera"),
        ),
        body:
        Column(
            children: <Widget>[
              Expanded(
                child: preview,
              ),
              IconButton(
                  icon: Icon(Icons.camera_alt),
                  tooltip: 'Capture',
                  onPressed: () { _onPressedCaptureIcon(); }
              ),
            ]
        )
    );
  }

  bool _isReady() {
    return controller != null && controller.value.isInitialized;
  }

  _onPressedCaptureIcon() {
    _takePicture().then((String filePath) {
      _showSnackBar('Picture saved to $filePath');
    }).catchError((e) {
      _showSnackBar(e);
    });
  }

  Future<String> _takePicture() async {
    if (!_isReady()) {
      throw("Camera controller is not initialized.");
    }

    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${_timestamp()}.jpg';

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      throw("Camera is already pending.");
    }

    await controller.takePicture(filePath);

    return filePath;
  }

  String _timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void _showSnackBar(String text) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(text),
    ));
  }
}

