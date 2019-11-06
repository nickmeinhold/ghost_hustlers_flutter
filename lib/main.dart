import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform =
      const MethodChannel('co.enspyr.ghost_hustlers_flutter/unity');

  String statusText = 'Waiting...';

  void _loadUnity() async {
    try {
      await platform.invokeMethod('showUnity');
    } on PlatformException catch (e) {
      print("Failed to load Unity: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(statusText),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadUnity,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
