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
              onPressed: (){
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
      final String result = await _methodChannel.invokeMethod('test', "parameters");
      // 戻り値を使って処理を行う

    } on PlatformException catch (e) {
      // 必要に応じてエラー処理
    }

  }

}
