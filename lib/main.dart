import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'space_chart.dart';

import 'dart:typed_data';

import 'protobuf/monitor.pb.dart';

void main() async {
  final assetKey = "assets/protobuf/blob_161_0_2811.blob";
  final Future<ByteData> future = rootBundle.load(assetKey);
  final data = await future;
  var buffer = data.buffer;
  Guidis g = new Guidis.fromBuffer(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  print(g);

  runApp(new MyApp(g));
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Guidis g;

  MyApp(this.g) : super();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'SPACE Monitor',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
//      home: new MyHomePage(g, title: 'Monitor Demo Home Page'),
      home: const MyHomePageFire(title: 'Monitor Firebase'),
    );
  }
}

class MyHomePageFire extends StatelessWidget {
  const MyHomePageFire({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text(title)),
      body: new StreamBuilder(
          stream: Firestore.instance.collection('fluttermon').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('Loading...');
            return new ListView.builder(
                itemCount: snapshot.data.documents.length,
                padding: const EdgeInsets.only(top: 10.0),
                itemExtent: 25.0,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.documents[index];
                  return new Text(" ${ds['ch_id']} ${ds['ckc_id']}");
                }
            );
          }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage(this.g, {Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final Guidis g;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return new SpaceChartWidget.withData(widget.g);
//    return new Scaffold(
//      appBar: new AppBar(
//        // Here we take the value from the MyHomePage object that was created by
//        // the App.build method, and use it to set our appbar title.
//        title: new Text(widget.title),
//      ),
//      body: new SpacePlotWidget.withData(widget.g),
////      floatingActionButton: new FloatingActionButton(
////        onPressed: _incrementCounter,
////        tooltip: 'Increment',
////        child: new Icon(Icons.add),
////      ),
//    );
  }
}


