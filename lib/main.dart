import 'package:flutter/material.dart';
import 'multi.dart';
import 'normal.dart';
import 'simple_camera.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    routes: <String, WidgetBuilder> {
      '/capture': (BuildContext context) => Capture(),
      '/multi': (BuildContext context) => MultiImagePickerScreen(),
      '/normal': (BuildContext context) => ImagePickerView(),

    },
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[

            RaisedButton(
              child: const Text("simple camera use `Camera`"),
              onPressed: () {
                Navigator.of(context).pushNamed("/capture");
              },
            ),
            RaisedButton(
              child: const Text("use multi image picker`"),
              onPressed: () {
                Navigator.of(context).pushNamed("/multi");
              },
            ),
            RaisedButton(
              child: const Text("popular image picker`"),
              onPressed: () {
                Navigator.of(context).pushNamed("/normal");
              },
            ),

          ],
        ),
      )
    );
  }
}
