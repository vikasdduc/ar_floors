import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:http/http.dart' as http;
import 'dart:io';

import '../controller/ar_controller.dart';
//import 'package:https/https.dart' as http;

class ImageObjectScreen extends StatefulWidget {
  @override
  _ImageObjectScreenState createState() => _ImageObjectScreenState();
}

class _ImageObjectScreenState extends State<ImageObjectScreen> {
  FirebaseManager firebaseManager = FirebaseManager();
  ArCoreController? arCoreController;
  ArCoreNode? node;
  int planeCount = 0;

  //getImageUrl
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('image on plane'),
      ),
      body: ArCoreView(
        onArCoreViewCreated: _onArCoreViewCreated,
        enableUpdateListener: true,
      ),

    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController?.onPlaneDetected = _handleOnPlaneDetected;
  }

  void _handleOnPlaneDetected(ArCorePlane plane) {
    planeCount++;
    if (node != null) {
      arCoreController?.removeNode(nodeName: node!.name);
    }
    _addImage(plane);
  }

  Future _addImage(ArCorePlane plane) async {
    final bytes = (await rootBundle.load('assets/tilePhoto.png')).buffer.asUint8List();
    final imageWidth = 0.5;
    node = ArCoreNode(
      image: ArCoreImage(bytes: bytes, width: 500, height: 500),
      position: //plane.centerPose!.translation +
          vector.Vector3(planeCount * imageWidth, -0.1, 0.0),
      rotation: vector.Vector4(1.0, 0.0, 0.0, -plane.centerPose!.rotation[3]),
    );
    arCoreController?.addArCoreNodeWithAnchor(node!);
  }

  @override
  void dispose() {
    arCoreController?.dispose();
    super.dispose();
  }
}
