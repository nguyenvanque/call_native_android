import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp( MyApp());
}

const CHANNEL = "com.example.call_native_android.channel";
const KEY_NATIVE = "showNativeView";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter-Native Bridging',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new MyHomePage(title: 'Bridging Demo - Flutter Layer'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  static const platform = const MethodChannel(CHANNEL);
  final String title;

  MyHomePage({Key? key, required this.title}) : super(key: key) {
    platform.setMethodCallHandler(_handleMethod);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar:  AppBar(
        title:  Text(title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             RaisedButton(
              child: new Text('Move to Native World!'),
              onPressed: _showNativeView,
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> _showNativeView() async {
    await platform.invokeMethod(KEY_NATIVE);
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case "message":
        debugPrint(call.arguments);
        return new Future.value("");
    }
  }
}

