import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class RandomNumber extends StatefulWidget {
  const RandomNumber({super.key,});

  @override
  State<RandomNumber> createState() => _RandomNumberState();
}

class _RandomNumberState extends State<RandomNumber> {
  String _theme = '';
  static const events = EventChannel('example.com/channel');

  @override
  void initState() {
    super.initState();
    events.receiveBroadcastStream().listen(_onEvent);
  }

  void _onEvent(Object? event) {
    setState(() {
      _theme = event == true ? 'dark' : 'light';
    });
  }
  String real = '';
  int _counter = 0;
  String _count = '';
  static const platform = MethodChannel('example.com/channel');

  Future<void> _findColorTheme() async {
    bool isDarkMode;
    try {
      isDarkMode = await platform.invokeMethod('isDarkMode');
    } on PlatformException catch (e) {
      isDarkMode = false;
      print('PlatformException: ${e.code} ${e.message}');
    }
    setState(() {
      _theme = isDarkMode ? 'dark' : 'light';
    });
  }

  Future<void> _generateRandomNumber() async {
    String realString;

    // int random;
    // String sting;

    try {
      var arguments = {
        'len': 3,
        'prefix': 'fl_',
      };

      // random = await platform.invokeMethod('getRandomNumber');
      // sting = await platform.invokeMethod('getRandomString');
        realString = await platform.invokeMethod('getRandomString', arguments);
      //print(sting.runtimeType);
    } on PlatformException catch (e) {
      realString = '' ;
      // sting = '';
      // random = 0;
    }
    setState(() {
      real = realString;
      // _count = sting;
      // _counter = random;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('invoke'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Kotlin generates the following theme  :',
            ),
            Text(
             // _theme,
               //   '$_counter   $_count'
                  ' $_theme',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _findColorTheme,
        //_generateRandomNumber,
        tooltip: 'Generate',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}