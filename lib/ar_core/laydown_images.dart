import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class AutoDetectAndImageOnPlane extends StatefulWidget {
  const AutoDetectAndImageOnPlane({super.key});

  @override
  _AutoDetectAndImageOnPlaneState createState() =>
      _AutoDetectAndImageOnPlaneState();
}

class _AutoDetectAndImageOnPlaneState extends State<AutoDetectAndImageOnPlane> {
  ArCoreController? arCoreController;
  ArCoreNode? node;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auto Detect and Image on Plane'),
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
    // Remove the previously added node, if any
    if (node != null) {
      arCoreController?.removeNode(nodeName: node!.name);
    }

    // Lay down an image on the detected plane
    _addImageOnPlane(plane);
  }

  Future _addImageOnPlane(ArCorePlane plane) async {
    final ByteData textureBytes = await rootBundle.load('assets/earth.jpg');
    final material = ArCoreMaterial(
      color: const Color.fromARGB(120, 66, 134, 244),
      textureBytes: textureBytes.buffer.asUint8List(),
    );




  }

  @override
  void dispose() {
    arCoreController?.dispose();
    super.dispose();
  }
}
