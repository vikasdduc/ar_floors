import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class AutoDetectPlane extends StatefulWidget {
  @override
  _AutoDetectPlaneState createState() => _AutoDetectPlaneState();
}

class _AutoDetectPlaneState extends State<AutoDetectPlane> {
  ArCoreController? arCoreController;
  ArCoreNode? node;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Plane detect handler'),
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
    if (node != null) {
      arCoreController?.removeNode(nodeName: node!.name);
    }
    _addImage(plane);
  }

  Future _addImage(ArCorePlane plane) async {
    final bytes = (await rootBundle.load('assets/tilePhoto.png')).buffer.asUint8List();

    node = ArCoreNode(
      image: ArCoreImage(bytes: bytes, width: 500, height: 500),
      position: plane.centerPose!.translation + vector.Vector3(0.0, -0.1, 0.0),
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

