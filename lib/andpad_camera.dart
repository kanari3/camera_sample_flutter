import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';

class AndpadCameraScreen extends StatefulWidget {
  @override
  _MultiImagePickerScreenState createState() => new _MultiImagePickerScreenState();
}

class _MultiImagePickerScreenState extends State<AndpadCameraScreen> {

  MethodChannel _methodChannel = MethodChannel('package.name/sample');

  MethodChannel androidChannel = const MethodChannel('samples.flutter.dev/battery');

  // Get battery level.
  String _batteryLevel = 'Unknown battery level.';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      print("pppp01");
      final int result = await androidChannel.invokeMethod('getBatteryLevel');
      print("pppp02");
      batteryLevel = 'Battery level at $result % .';
      print("pppp03");
    } on PlatformException catch (e) {
      print("pppp04");

      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: <Widget>[
            Center(child: Text('黒板カメラ')),
            RaisedButton(
              child: Text("Pick images"),
              onPressed: ()  {
//                 _launchNativeScreen();
                _getBatteryLevel();
              },
            ),

            Text(_batteryLevel),

          ],
        ),
      ),
    );
  }


  // ネイティブへのメッセージ送信＞画面遷移
  Future<Null> _launchNativeScreen() async {
    // ネイティブ側へメッセージを送信
    try {
      print("とらい");
      final String result = await _methodChannel.invokeMethod('test', "だーとから");
      // 戻り値を使って処理を行う
      print("せいじょー");
      print(result.toString());


    } on PlatformException catch (e) {
      // 必要に応じてエラー処理
      print("えらー");
      print(e.toString());
    }

  }

}


