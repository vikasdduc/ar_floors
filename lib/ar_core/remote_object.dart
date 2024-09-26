import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class RemoteObject extends StatefulWidget {
  @override
  _RemoteObjectState createState() => _RemoteObjectState();
}

class _RemoteObjectState extends State<RemoteObject> {
  ArCoreController? arCoreController;

  String? objectSelected;
  List<ArCoreNode> nodes = [];
  //late ArCoreNode lineNode;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Object on plane detected'),
      ),
      body: ArCoreView(
        onArCoreViewCreated: _onArCoreViewCreated,
        enableTapRecognizer: true,
        // type: ArCoreViewType,
      ),

    );
  }


  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController?.onNodeTap = (name) => onTapHandler(name);
    arCoreController?.enablePlaneRenderer;
    //arCoreController?.addArCoreNodeWithAnchor(node) =
    arCoreController?.onPlaneTap = _handleOnPlaneTap;
    arCoreController?.addArCoreNode(lineNode);
  }

  ArCoreNode lineNode = ArCoreNode(
    shape: ArCoreCylinder(
      materials: [ArCoreMaterial(color: Colors.green)],
      height: 0.005,
      radius: 0.001,
    ),
  );

  void _addBoxNode(ArCoreHitTestResult plane) {
    final BoxNode = ArCoreReferenceNode(
      name: "Box",
      //object3DFileName: ,
      objectUrl:
      "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Box/glTF/Box.gltf",
      position: plane.pose.translation,
      rotation: plane.pose.rotation,
      scale: plane.pose.translation.xyz
    );

    nodes.add(BoxNode);

    arCoreController?.addArCoreNodeWithAnchor(BoxNode);

  }


  void _handleOnPlaneTap(List<ArCoreHitTestResult> hits) {

    final hit = hits.first;
    _addBoxNode(hit);

  }

  void onTapHandler(String name) {
    print("Flutter: onNodeTap");
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Row(
          children: <Widget>[
            Text('Remove $name?'),
            IconButton(
                icon: Icon(
                  Icons.delete,
                ),
                onPressed: () {
                  arCoreController?.removeNode(nodeName: name);
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );

  }

  @override
  void dispose() {
    arCoreController?.dispose();
    super.dispose();
  }
}

// class RemoteObject extends StatefulWidget {
//   @override
//   _RemoteObjectState createState() => _RemoteObjectState();
// }
//
// class _RemoteObjectState extends State<RemoteObject> {
//   ArCoreController? arCoreController;
//
//   String? objectSelected;
//   List<ArCoreNode> nodes = [];
//   List<ArCorePlane> planes = [];
//   //late ArCoreNode lineNode;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Custom Object on plane detected'),
//         ),
//         body: ArCoreView(
//           onArCoreViewCreated: _onArCoreViewCreated,
//           enableTapRecognizer: true,
//           enableUpdateListener: true,
//          // type: ArCoreViewType,
//         ),
//
//     );
//   }
//
//
//   void _onArCoreViewCreated(ArCoreController controller) {
//     arCoreController = controller;
//     arCoreController?.onNodeTap = (name) => onTapHandler(name);
//     arCoreController?.enablePlaneRenderer;
//    // arCoreController?.onPlaneDetected = _handleOnPlaneDetected;
//     //arCoreController?.addArCoreNodeWithAnchor(node) =
//     arCoreController?.onPlaneTap = _handleOnPlaneTap;
//    // arCoreController?.addArCoreNode(lineNode);
//   }
//
//   // ArCoreNode lineNode = ArCoreNode(
//   //   shape: ArCoreCylinder(
//   //     materials: [ArCoreMaterial(color: Colors.green)],
//   //     height: 0.005,
//   //     radius: 0.001,
//   //   ),
//   // );
//
//    void _addBoxNode(ArCoreHitTestResult plane) async{
//     print("add box node run");
//     final BoxNode = await ArCoreReferenceNode(
//         name: "Box",
//         //object3DFileName: ,
//         objectUrl:
//             "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Box/glTF/Box.gltf",
//         position: plane.pose.translation,
//         rotation: plane.pose.rotation,
//         scale:  vector.Vector3(0.05,0.05,0.05)
//     );
//     nodes.add(BoxNode);
//
//
//
//    // arCoreController?.addArCoreNodeWithAnchor(BoxNode, parentNodeName: 'tilePhoto');
//
//   }
//
//   // void _handleOnPlaneDetected(ArCorePlane plane) async {
//   //
//   //   print("handle on plane detected ${plane}");
//   //
//   //    if(plane != null){
//   //      print("handle on plane detected inside ${plane}");
//   //     await  _addTile(plane.centerPose?.translation);
//   //      planes.add(plane);
//   //    }
//   //   // if (nodes != null) {
//   //   //   arCoreController?.removeNode(nodeName: nodes.name);
//   //   // }
//   //   // _addTile(plane);
//   // }
//
//
//   void _handleOnPlaneTap(List<ArCoreHitTestResult> hits) async {
//
//     //final ByteData bytes = await rootBundle.load('assets/tilePhoto.png');
//
//     // final tile = ArCoreImage(
//     //     bytes: bytes.buffer.asUint8List(),
//     //     width: 300,
//     //     height: 50);
//     //
//     // var tileNode = ArCoreNode(
//     //     name: 'tilePhoto',
//     //     image: tile,
//     //     position: vector.Vector3(1,-1,2)
//     // );
//
//     print('taped on plane');
//     final hit = hits.first;
//     _addBoxNode(hit);
//     // if(planes != null ){
//     //
//     // }
//
//   }
//
// //   Future _addTile(plane) async {
// //     print("palne ${plane}");
// //      final ByteData bytes = await rootBundle.load('assets/tilePhoto.png');
// //
// // final tile = ArCoreImage(
// //   bytes: bytes.buffer.asUint8List(),
// //       width: 300,
// //       height: 50);
// //
// //   var tileNode = ArCoreNode(
// //     name: 'tilePhoto',
// //     image: tile,
// //     position: vector.Vector3(1,-1,2)
// // );
// //
// //      //arCoreController?.addArCoreNodeWithAnchor(tileNode, parentNodeName:plane.centerPose);
// //
// //   }
//
//   void onTapHandler(String name) {
//     print("Flutter: onNodeTap");
//     showDialog<void>(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         content: Row(
//           children: <Widget>[
//             Text('Remove $name?'),
//             IconButton(
//                 icon: Icon(
//                   Icons.delete,
//                 ),
//                 onPressed: () {
//                   arCoreController?.removeNode(nodeName: name);
//                   Navigator.pop(context);
//                 })
//           ],
//         ),
//       ),
//     );
//
//   }
//
//   @override
//   void dispose() {
//     arCoreController?.dispose();
//     super.dispose();
//   }
// }
