import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/models/ar_anchor.dart';
import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
import 'package:flutter/services.dart';
 import 'package:http/http.dart' as http;
// import 'package:get/get_core/src/get_main.dart';
// import 'package:uniwood_quote_flutter/models/room_model.dart';
import 'package:vector_math/vector_math_64.dart';
import 'dart:math';


class ObjectsOnPlanesWidget extends StatefulWidget {

  const ObjectsOnPlanesWidget({Key? key,}) : super(key: key);
  @override
  _ObjectsOnPlanesWidgetState createState() => _ObjectsOnPlanesWidgetState();
}

class _ObjectsOnPlanesWidgetState extends State<ObjectsOnPlanesWidget> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;

  List<ARNode> nodes = [];
  List<ARAnchor> anchors = [];

  //ARNode? webObjectNode;

  String? newTileImage;

  @override
  void initState() async {
    super.initState();
    final response = await http.get(Uri.parse('https://firebasestorage.googleapis.com/v0/b/instaclone-ed42d.appspot.com/o/sapele.png?alt=media&token=3a285f5f-ca22-4f97-aea3-3bcac02576b3'));
    print("newTileImage response.. ${response}");
  }

  @override
  void dispose() {
    super.dispose();
    arSessionManager!.dispose();
    arAnchorManager!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Anchors & Objects on Planes'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // _roomController.totalArea.value;
              // _roomController.length.value;
              // _roomController.width.value;
              // Get.back(
              //   // result: _roomController.totalArea.value
              // ); // Navigate back to the previous screen
            },
          ),
        ),
        body: Stack(
            children: [
              ARView(
                onARViewCreated: onARViewCreated,
                planeDetectionConfig: PlaneDetectionConfig.horizontal,
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: onRemoveEverything,
                          child: const Text("Remove Everything")),
                    ]),
              )
            ]));
  }

  Future<void> onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) async {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    this.arAnchorManager = arAnchorManager;

    this.arSessionManager!.onInitialize(
      showAnimatedGuide: false,
      showFeaturePoints: false,
      showPlanes: true,
      customPlaneTexturePath: "assets/tilePhoto.png",
      //widget.tileImage,
      showWorldOrigin: false,
    );
    this.arObjectManager!.onInitialize();
    this.arSessionManager!.onPlaneOrPointTap = onPlaneOrPointTapped;
    this.arObjectManager!.onNodeTap = onNodeTapped;
    this.arObjectManager!.onPanStart = onPanStart;
    //this.arSessionManager!.planeDetectionConfig;
    // if (nodes.length == 4) {
    //   double totalArea1 = await calculateAreaBetweenNodes();
    //   print("area1 init2 ... ${totalArea1.toString()}");
    //   _roomController.setTotalArea(totalArea1);
    // }
    //httpClient = HttpClient();
    //_downloadFile(url , fileName);
  }

  // Future<File> _downloadFile(String url, String filename) async {
  //   var request = await httpClient.getUrl(Uri.parse(url));
  //   var response = await request.close();
  //   var bytes = await consolidateHttpClientResponseBytes(response);
  //   String dir = (await getApplicationDocumentsDirectory()).path;
  //   File file = new File('$dir/$filename');
  //   await file.writeAsBytes(bytes);
  //   print("Downloading finished, path: " + '$dir/$filename');
  //   return file;
  // }

  bool handlePans() {
    return true;
  }

  Future<void> onPanStart(String nodeName) async {
    Future<Matrix4?>? camerapose = this.arSessionManager?.getCameraPose();

    print("new node tapped with camerapose ... ${camerapose}");
  }

  Future<void> onRemoveEverything() async {
    nodes.forEach((node) {
      this.arObjectManager?.removeNode(node);
    });
    anchors.forEach((anchor) {
      this.arAnchorManager!.removeAnchor(anchor);
    });
    nodes = [];
    anchors = [];
  }

  Future<void> onNodeTapped(List<String> nodes) async {
    var number = nodes.length;
    this.arSessionManager!.onError("Tapped $number node(s)");
  }

  Future<void> onPlaneOrPointTapped(
      List<ARHitTestResult> hitTestResults) async {
    var singleHitTestResult = hitTestResults.firstWhere(
            (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane);

    if (singleHitTestResult != null) {
      var newNode = ARNode(
          type: NodeType.webGLB,
          //localGLTF2,
          uri:
          //"https://firebasestorage.googleapis.com/v0/b/instaclone-ed42d.appspot.com/o/Hammerhead%20shark.glb?alt=media&token=72218bf0-6c5b-45c4-a4ae-43561e6ffbf5",
          //"https://www.uniwoodproducts.com/wp-content/uploads/2021/03/heder_about_us.jpg",
          //"https://firebasestorage.googleapis.com/v0/b/ar-quote-dev.appspot.com/o/products%2F0h3ChzeaIcFi4FsXmxWz%2FtilePhoto?alt=media&token=34f0e7e6-7152-47aa-b8c1-7656ece77ffb",
          "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Box/glTF-Binary/Box.glb",
         // "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.uniwoodproducts.com%2F&psig=AOvVaw2EKoQDRyWauXhhedzbKBBM&ust=1694675700517000&source=images&cd=vfe&opi=89978449&ved=2ahUKEwihz7CKhaeBAxX5SGwGHR7wAVgQjRx6BAgAEAw"
          //"models/chicken/Chicken_01.gltf",
          scale: Vector3(0.05, 0.05, 0.05),
          transformation: singleHitTestResult.worldTransform);

      bool? didAddWebNode = await this.arObjectManager?.addNode(
        newNode,
      );
      if (didAddWebNode!) {
        this.nodes.add(newNode);
        print("new node added with position... ${newNode.position}");
        print("new node added with transform... ${newNode.transform}");
        if (nodes.length == 4) {
          //double totalArea = await
          await calculateAreaBetweenNodes();

        }
      }
    }
  }

  Future<void> addAnchorToPlane() async {

  }

  Future<double> calculateAreaBetweenNodes() async {
    Vector3 nodeA = nodes[0].position;
    Vector3 nodeB = nodes[1].position;
    Vector3 nodeC = nodes[2].position;
    Vector3 nodeD = nodes[3].position;

    double? distanceAB1 =
    await this.arSessionManager?.getDistanceBetweenVectors(nodeA, nodeB);
    double? distanceBC1 =
    await this.arSessionManager?.getDistanceBetweenVectors(nodeB, nodeC);
    double? distanceCD1 =
    await this.arSessionManager?.getDistanceBetweenVectors(nodeC, nodeD);
    double? distanceDA1 =
    await this.arSessionManager?.getDistanceBetweenVectors(nodeD, nodeA);
    double? distanceBD =
    await this.arSessionManager?.getDistanceBetweenVectors(nodeB, nodeD);

    Vector3 crossProduct1 = (nodeB - nodeA).cross(nodeC - nodeA);
    Vector3 crossProduct2 = (nodeC - nodeA).cross(nodeD - nodeA);

    double areaQuadi = 0.5 * (crossProduct1.length + crossProduct2.length);

    print('areaQuadi between nodes....: $areaQuadi m2');

    print(
        'distanceAB1 between nodes AB in cm: ${(distanceAB1! * 100).toStringAsFixed(2)}');
    print('distanceAB1 between nodes BC: $distanceBC1');
    print('distanceBD between nodes BD: $distanceBD');
    print('Distance between nodes AB1: $distanceAB1');

    double distanceAB = nodeA.distanceTo(nodeB);
    double distanceBC = nodeB.distanceTo(nodeC);
    print('Distance between nodes AB: $distanceAB');
    print('Distance between nodes BC: $distanceBC');

    double? lengthAB = (distanceAB1) * 100;
    double? widthBC = (distanceBC1!) * 100;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Area in Sqm : ${(areaQuadi).toStringAsFixed(2)} Sqm'),
      ),
    );

    return areaQuadi;
  }

  // Future<void> onWebObjectAtOriginButtonPressed() async {
  //   if (this.webObjectNode != null) {
  //     this.arObjectManager.removeNode(this.webObjectNode);
  //     this.webObjectNode = null;
  //   } else {
  //     var newNode = ARNode(
  //         type: NodeType.webGLB,
  //         uri:
  //         "https://firebasestorage.googleapis.com/v0/b/stridenseek.appspot.com/o/files%2FAR_Models%2FAlien.glb?alt=media&token=fffd9db1-dcc5-4dae-bb1f-95d7ea867817",
  //         scale: Vector3(0.2, 0.2, 0.2));
  //     bool didAddWebNode = await this.arObjectManager.addNode(newNode);
  //     this.webObjectNode = (didAddWebNode) ? newNode : null;
  //   }
  // }

}

