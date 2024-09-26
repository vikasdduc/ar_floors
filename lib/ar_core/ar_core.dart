
import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ARCorePage extends StatefulWidget {
  const ARCorePage({Key? key}) : super(key: key);

  @override
  State<ARCorePage> createState() => _ARCorePageState();
}

class _ARCorePageState extends State<ARCorePage> {
  late ArCoreController arCoreController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello World'),
      ),
      body: ArCoreView(
        onArCoreViewCreated: _onArCoreViewCreated,
      ),
    );
  }
  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController.onPlaneDetected = _handleOnPlaneDetected;

    // _addSphere(arCoreController);
    // _addCylindre(arCoreController);
    // _addCube(arCoreController);
  }

  _handleOnPlaneDetected(ArCorePlane plane) async {
    final bytes =
    (await rootBundle.load('assets/earth.jpg')).buffer.asUint8List();
    // Add an image node to the plane
    final node = ArCoreNode(
      image: ArCoreImage(bytes: bytes, width: 100, height: 100),
      position: plane.centerPose?.translation,
      rotation: plane.centerPose?.rotation,
    );
    arCoreController.addArCoreNode(node);
  }
  void _addSphere(ArCoreController controller) {
    final material = ArCoreMaterial(
        color: const Color.fromARGB(120, 66, 134, 244));
    final sphere = ArCoreSphere(
      materials: [material],
      radius: 0.1,
    );
    final node = ArCoreNode(
      shape: sphere,
      position: vector.Vector3(0, 0, -1.5),
    );
    controller.addArCoreNode(node);
  }

  void _addCylindre(ArCoreController controller) {
    final material = ArCoreMaterial(
      color: Colors.red,
      reflectance: 1.0,
    );
    final cylindre = ArCoreCylinder(
      materials: [material],
      radius: 0.5,
      height: 0.3,
    );
    final node = ArCoreNode(
      shape: cylindre,
      position: vector.Vector3(0.0, -0.5, -2.0),
    );
    controller.addArCoreNode(node);
  }

  void _addCube(ArCoreController controller) {
    final material = ArCoreMaterial(
      color: Color.fromARGB(120, 66, 134, 244),
      metallic: 1.0,
    );
    final cube = ArCoreCube(
      materials: [material],
      size: vector.Vector3(0.5, 0.5, 0.5),
    );
    final node = ArCoreNode(
      shape: cube,
      position: vector.Vector3(-0.5, 0.5, -3.5),
    );
    controller.addArCoreNode(node);
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}

