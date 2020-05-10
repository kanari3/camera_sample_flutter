import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';

class AndpadCameraScreen extends StatefulWidget {
  @override
  _MultiImagePickerScreenState createState() => new _MultiImagePickerScreenState();
}

class _MultiImagePickerScreenState extends State<AndpadCameraScreen> {

  MethodChannel _methodChannel = MethodChannel('package.name/sample');

  @override
  void initState() {
    super.initState();
  }

  final _channel = MethodChannel('hello_ios');
  String _message = 'Push Button';

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
                 _launchNativeScreen();
              },
            ),
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


