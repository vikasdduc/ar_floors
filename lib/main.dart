import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/ar_core/augmented_images.dart';
import 'package:insta_clone/ar_core/laydown_images.dart';
import 'package:insta_clone/ar_flutter/cloud_ar_view.dart';
import 'package:insta_clone/ar_flutter/simple_ar_view.dart';
import 'package:insta_clone/language_converter/langconvt_class.dart';
import 'package:insta_clone/state/auth/backend/authenticator.dart';
import 'package:insta_clone/state/auth/email_link_signin.dart';
import 'ar_core/ar_core.dart';
import 'ar_core/auto_detect_plane.dart';
import 'ar_core/image_object.dart';
import 'ar_core/matri_3d.dart';
import 'ar_core/remote_object.dart';
import 'ar_core/runtime_materials.dart';
import 'ar_core/texture_and_rotation.dart';
import 'ar_flutter/kotlininvoke.dart';
import 'firebase_options.dart';
// //import 'com.facebook.FacebookSdk';
//
// import 'dart:developer' as devtools show log;
//
// extension Log on Object {
//   void log() => devtools.log(toString());
// }

// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   //WebView.platform = SurfaceAndroidWebView();
//  // WebView.platform = WebWebViewPlatform();
//   runApp(
//      MaterialApp(
//       theme: ThemeData(useMaterial3: true),
//       home: WebViewApp(),
//     ),
//   );
// }
//
// class WebViewApp extends StatefulWidget {
//   const WebViewApp({super.key});
//
//   @override
//   State<WebViewApp> createState() => _WebViewAppState();
// }
//
// class _WebViewAppState extends State<WebViewApp> {
//   late final WebViewController controller;
//
//   @override
//   void initState() {
//     super.initState();
//     controller = WebViewController()
//       ..loadRequest(
//         Uri.parse('https://flutter.dev'),
//       );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Flutter WebView'),
//       ),
//       body: WebViewWidget(
//         controller: controller,
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// void main() => runApp(
//     WebView.platform = WebWebViewPlatform();
//     const MyApp());
//
// class MyApp extends StatelessWidget {
//
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           useMaterial3: true,
//         ),
//         home: const MyStatefulWidget());
//   }
// }
//
// class MyStatefulWidget extends StatefulWidget {
//   const MyStatefulWidget({super.key});
//
//   @override
//   State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
// }
//
// class _MyStatefulWidgetState extends State<MyStatefulWidget> {
//   late final WebViewController controller;
//   var loadingPercentage = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..loadRequest(
//         Uri.dataFromString("https://lookerstudio.google.com/embed/reporting/0B_U5RNpwhcE6QXg4SXFBVGUwMjg/page/6zXD")
//         // Uri.dataFromString('''<html>
//         //     <head><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>
//         //     <body><iframe src="https://www.youtube.com/embed/PAOAjOR6K_Q"
//         //     title="YouTube video player" frameborder="0"></iframe></body></html>''',
//         //     mimeType: 'text/html'),
//         //   <iframe width="600" height="450"
//         // src="https://lookerstudio.google.com/embed/reporting/0B_U5RNpwhcE6QXg4SXFBVGUwMjg/page/6zXD"
//         // frameborder="0" style="border:0" allowfullscreen sandbox="allow-storage-access-by-user-activation allow-scripts allow-same-origin allow-popups allow-popups-to-escape-sandbox"></iframe>
//       );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Flutter WebView example'),
//         ),
//         body: WebViewWidget(
//           controller: controller,
//         ));
//   }
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
        'languageConverter': (context) => const AiLanguageConverter(),
        // 'emaillink': (context) => EmailLinkSignInSection(),
        // 'simpleShapes': (context) => ARCorePage(),
        // 'kotlin': (context) => RandomNumber(),
        // 'RemoteObject': (context) => RemoteObject(),
        // 'AugmentedPage': (context) => AugmentedPage(),
        // 'AutoDetectAndImageOnPlane': (context) => AutoDetectAndImageOnPlane(),
        // 'ImageObjectScreen': (context) => ImageObjectScreen(),
        // 'AutoDetectPlane': (context) => AutoDetectPlane(),
        // 'Matrix3DRenderingPage': (context) => Matrix3DRenderingPage(),
        // 'RuntimeMaterials': (context) => RuntimeMaterials(),
        // 'ObjectWithTextureAndRotation': (context) => ObjectWithTextureAndRotation(),
        //
        // 'ObjectsOnPlanesWidget': (context) =>  ObjectsOnPlanesWidget(),
        // 'CloudAnchorWidget': (context) =>  CloudAnchorWidget(),

        // <iframe width="600" height="450" src="https://lookerstudio.google.com/embed/reporting/0B_U5RNpwhcE6QXg4SXFBVGUwMjg/page/6zXD" frameborder="0" style="border:0" allowfullscreen sandbox="allow-storage-access-by-user-activation allow-scripts allow-same-origin allow-popups allow-popups-to-escape-sandbox"></iframe>



      },
      darkTheme: ThemeData.dark(),
      theme: ThemeData(),
      // darkTheme: ThemeData(
      //     brightness: Brightness.dark,
      //     primarySwatch: Colors.blueGrey,
      //     indicatorColor: Colors.blueGrey),
      // theme: ThemeData(
      //   brightness: Brightness.dark,
      //   primarySwatch: Colors.blue,
      // ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      //home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Language Converter'),
          actions: [
            IconButton(
                onPressed: (){
                  Navigator.pushNamed(context, 'languageConverter');
                       // Navigator.pushNamed(context, 'emaillink');
                },
                icon: const Icon(Icons.perm_camera_mic_rounded))
          ],
        ),
        body: Center(
          child:
          Column(
            children: [
              // TextButton(
              //     onPressed: () async {
              //       final result = await Authenticator().loginWithGoogle();
              //       //result.log();
              //     },
              //     child: const Text(
              //       'Sign In with Google',
              //     )),
              // TextButton(
              //     onPressed: () async {
              //       final result = await Authenticator().loginWithFacebook();
              //       //result.log();
              //     },
              //     child: const Text(
              //       'Sign In with FaceBook',
              //     )),
              // TextButton(
              //     onPressed: () {
              //       Navigator.pushNamed(context, 'kotlin');
              //     },
              //     child: const Text(
              //       'Kotlin channel',
              //     )),
              //
              // TextButton(
              //     onPressed: () {
              //       Navigator.pushNamed(context, 'simpleShapes');
              //     },
              //     child: const Text(
              //       'Simple Shapes',
              //     )),
              // TextButton(
              //     onPressed: () {
              //       Navigator.pushNamed(context, 'RemoteObject');
              //     },
              //     child: const Text(
              //       'Remote Object',
              //     )),
              // TextButton(
              //     onPressed: () {
              //       Navigator.pushNamed(context, 'AugmentedPage');
              //     },
              //     child: const Text(
              //       'Augmented Images',
              //     )),
              // TextButton(
              //     onPressed: () {
              //       Navigator.pushNamed(context, 'AutoDetectAndImageOnPlane');
              //     },
              //     child: const Text(
              //       'AutoDetect And ImageOnPlane',
              //     )),
              // TextButton(
              //     onPressed: () {
              //       Navigator.pushNamed(context, 'ImageObjectScreen');
              //     },
              //     child: const Text(
              //       'Image Object Screen',
              //     )),
              // TextButton(
              //     onPressed: () {
              //       Navigator.pushNamed(context, 'AutoDetectPlane');
              //     },
              //     child: const Text(
              //       'Auto Detect Plane',
              //     )),
              // TextButton(
              //     onPressed: () {
              //       Navigator.pushNamed(context, 'Matrix3DRenderingPage');
              //     },
              //     child: const Text(
              //       'Matrix3D RenderingPage',
              //     )),
              // TextButton(
              //     onPressed: () {
              //       Navigator.pushNamed(context, 'RuntimeMaterials');
              //     },
              //     child: const Text(
              //       'Runtime Materials',
              //     )),
              // TextButton(
              //     onPressed: () {
              //       Navigator.pushNamed(context, 'ObjectWithTextureAndRotation');
              //     },
              //     child: const Text(
              //       'Object With TextureAndRotation',
              //     )),
              // IconButton(
              //     onPressed: (){
              //       Navigator.pushNamed(context, 'ObjectsOnPlanesWidget');
              //     },
              //     icon: const Icon(Icons.camera, size: 30,),),
              //
              // IconButton(
              //   onPressed: (){
              //     Navigator.pushNamed(context, 'CloudAnchorWidget');
              //   },
              //   icon: const Icon(Icons.ac_unit, size: 30,),)

            ],
          ),
        ));
  }
}
