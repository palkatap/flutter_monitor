import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/services.dart' show rootBundle;
import 'package:charts_common/common.dart' show SelectNearest;
import 'package:charts_common/src/data/series.dart' show TypedAccessorFn;

import 'dart:typed_data';
import 'my_line_chart.dart';
import 'my_line_renderer.dart';
import 'my_line_point_highlighter.dart';
import 'space_constants.dart';

import 'protobuf/monitor.pbserver.dart';

typedef bool MissingValue(ChartPoint p);
typedef num GetChartValue(Sample p);

//void main() {
//  final assetKey = "assets/protobuf/blob_161_0_2811.blob";
//  final Future<ByteData> future = rootBundle.load(assetKey);
//  future.then((data) {
//    var buffer = data.buffer;
//    Guidis g = new Guidis.fromBuffer(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
//    print(g);
//  });
//
//  runApp(new MyApp());
//}

void main() async {
  final assetKey = "assets/protobuf/blob_161_0_2811.blob";
  final Future<ByteData> future = rootBundle.load(assetKey);
  final data = await future;
  var buffer = data.buffer;
  Guidis g = new Guidis.fromBuffer(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  print(g);

  runApp(new MyApp(g));
}

//ByteData getAsset(String assetKey) {
//  final Future<ByteData> future = rootBundle.load(assetKey);
//  final data = (await future);
//  return data;
//}

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
      home: new MyHomePage(g, title: 'Monitor Demo Home Page'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      body: new DashPatternLineChart.withData(widget.g),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

/// Example of a line chart rendered with dash patterns.
class DashPatternLineChart extends StatelessWidget {
  final List<charts.Series<ChartPoint, int>> seriesList;
  final bool animate;
  final Guidis g;

  /// Creates a [LineChart] with sample data and no transition.
  factory DashPatternLineChart.withData(Guidis g) {
    return new DashPatternLineChart(
      g,
      _createData(g),
      animate: false,
    );
  }

  DashPatternLineChart(this.g, this.seriesList, {this.animate});

  static List<charts.Series<ChartPoint, int>> _createData(Guidis g) {
    int i = 0;
    List<ChartPoint> samples = g.samples.map((s) {
      return ChartPoint(i++, s);
    }).toList();
//    String limEn = samples[2].smp.limitEnable;
//    limEn = "NN" + limEn.substring(2);
//    samples[2].smp.limitEnable = limEn;

    return [
      new charts.Series<ChartPoint, int>(
        id: 'value',
        colorFn: (_, __) => charts.MaterialPalette.black,
        domainFn: (ChartPoint p, x) => x,
        measureFn: (ChartPoint p, _) => transform(p.smp.extMv),
//        measureUpperBoundFn: (ChartPoint p, _) => 20.0, //p.smp.extMv + 1,
        data: samples,
      )
        ..setAttribute(charts.rendererIdKey, 'value'),

//      getUSLSeries(samples),
//      getLSLSeries(samples),
//      getTgtSeries(samples),
      getCLSeries(samples, LIMIT_MV_LCL),
      getCLSeries(samples, LIMIT_MV_CENTER),
      getCLSeries(samples, LIMIT_MV_UCL),
      getZoneSeries(samples, 0),
      getZoneSeries(samples, 1),
      getZoneSeries(samples, 2),
      getZoneSeries(samples, 3),
    ];
  }

  static charts.Series<ChartPoint, int> getUSLSeriesTest(List<ChartPoint> samples) {
    List<ChartPoint> s = samples.sublist(0, 2);
    var series = new charts.Series<ChartPoint, int>(
      id: "USL",
      colorFn: (_, __) => charts.Color(r: 255, g: 78, b: 0),
      domainFn: (ChartPoint p, x) => x,
      measureFn: (ChartPoint p, x) => x < 1 ? 100 : 110,
      data: s,
    )
//      ..setAttribute(charts.rendererIdKey, 'SPEC')
    ;
    return series;
  }

  static charts.Series<ChartPoint, int> getUSLSeries(List<ChartPoint> samples) {
    var series = new charts.Series<ChartPoint, int>(
      id: "USL",
      colorFn: (_, __) => charts.Color(r: 255, g: 78, b: 0),
      domainFn: (ChartPoint p, x) => x,
      measureFn: (ChartPoint p, _) => getSpecValue(p.smp, 0),
      data: samples,
    )
//      ..setAttribute(charts.rendererIdKey, 'SPEC')
    ;
    return series;
  }

  static charts.Series<ChartPoint, int> getTgtSeries(List<ChartPoint> samples) {
    var series = new charts.Series<ChartPoint, int>(
      id: "Target",
      dashPattern: [4, 4],
      colorFn: (_, __) => charts.Color(r: 255, g: 78, b: 0),
      domainFn: (ChartPoint p, x) => x,
      measureFn: (ChartPoint p, _) => getSpecValue(p.smp, 1),
      data: samples,
    )
//      ..setAttribute(charts.rendererIdKey, 'SPEC')
    ;
    return series;
  }

  static charts.Series<ChartPoint, int> getLSLSeries(List<ChartPoint> samples) {
    var series = new charts.Series<ChartPoint, int>(
      id: "LSL",
      colorFn: (_, __) => charts.Color(r: 255, g: 78, b: 0),
      domainFn: (ChartPoint p, x) => x,
      measureFn: (ChartPoint p, _) => getSpecValue(p.smp, 2),
      data: samples,
    )
//      ..setAttribute(charts.rendererIdKey, 'SPEC')
    ;
    return series;
  }

  static charts.Series<ChartPoint, int> getCLSeries(List<ChartPoint> samples, int limitIdx) {
    var series = new charts.Series<ChartPoint, int>(
      id: 'CL ' + limitIdx.toString(),
      dashPattern: isClCenterLine(limitIdx) ? [4, 4] : null,
      colorFn: (_, __) => charts.Color(r: 70, g: 0, b: 230),
      domainFn: (ChartPoint p, x) => x,
      measureFn: (ChartPoint p, _) => getLimitValue(limitIdx, p.smp),
      data: samples,
    )
    // Configure our custom bar target renderer for this series.
//      ..setAttribute(charts.rendererIdKey, 'CL')
    ;
    return series;
  }

  static charts.Series<ChartPoint, int> getALSeries(List<ChartPoint> samples, int limitIdx) {
    var series = new charts.Series<ChartPoint, int>(
      id: 'AL ' + limitIdx.toString(),
      dashPattern: [2, 2],
      colorFn: (_, __) => charts.Color(r: 0, g: 160, b: 230),
//      colorFn: (_, __) => charts.MaterialPalette.lime.shadeDefault,
      domainFn: (ChartPoint p, x) => x,
      measureFn: (ChartPoint p, _) => getLimitValue(limitIdx, p.smp),
      data: samples,
    )
//      ..setAttribute(charts.rendererIdKey, 'AL')
    ;
    return series;
  }

  static charts.Series<ChartPoint, int> getZoneSeries(List<ChartPoint> samples, int zoneIdx) {
    var limitIdx = zoneIdx < 2 ? LIMIT_MV_UCL : LIMIT_MV_LCL;
    var zoneFactor = zoneIdx % 2 == 0 ? 2 / 3.0 : 1 / 3.0;
    var series = new charts.Series<ChartPoint, int>(
      id: 'Zone ' + zoneIdx.toString(),
      dashPattern: [4, 4],
      colorFn: (_, __) => charts.Color(r: 0, g: 230, b: 185),
      domainFn: (ChartPoint p, x) => x,
      measureFn: (ChartPoint p, _) {
        var lim = getLimitValue(limitIdx, p.smp);
        var cl = getLimitValue(LIMIT_MV_CENTER, p.smp);
        if (lim == null || cl == null) {
          return null;
        }
        return cl + (lim - cl) * zoneFactor;
      },
      data: samples,
    )
//      ..setAttribute(charts.rendererIdKey, 'Zone')
    ;
    return series;
  }

  @override
  Widget build(BuildContext context) {
    return new MyLineChart(
        seriesList,
        animate: animate,
        behaviors: [
          new charts.SelectNearest(),
          new MyLinePointHighlighter()
        ],
        defaultInteractions: false,
        defaultRenderer: new MyLineRendererConfig(
          strokeWidthPx: 1.0,
          includeLine: true,
          includePoints: false,
          stairLine: true,
        ),
        primaryMeasureAxis: new charts.NumericAxisSpec(
            viewport: getYRange(seriesList),
            tickProviderSpec: new charts.BasicNumericTickProviderSpec(zeroBound: false)),
        customSeriesRenderers: [
          new MyLineRendererConfig(
              strokeWidthPx: 1.0,
              includeLine: true,
              includePoints: true,
              radiusPx: 3.0,
              stairLine: false,
              customRendererId: 'value'),
        ]
    );
  }

}

charts.NumericExtents getYRange(List<charts.Series<ChartPoint, int>> series) {
  double min;
  double max;
  series.forEach((s) {
//    print("series " + s.id);
    if (s.data != null && s.measureFn != null) {
      for (int i = 0; i < s.data.length; i++) {
        double y = s.measureFn(i);
//        print("value " + i.toString() + " = " + (y == null ? "null" : y.toString()));
        if (y != null) {
          if (min == null || min > y) {
            min = y;
          }
          if (max == null || max < y) {
            max = y;
          }
        }
      }
    }
  });
  if (min != null && max != null && min == max) {
    max = min + 1.0;
  }
  min ??= 0.0;
  max ??= 1.0;
  double range = max - min;
  min -= range * 0.1;
  max += range * 0.1;
  return new charts.NumericExtents(min, max);
}

class ChartPoint {
  final int pos;
  final Sample smp;

  ChartPoint(this.pos, this.smp);
}

double transform(double v) {
  return v;
//  if (v == null) {
//    return null;
//  }
//  double d = v * 5.0 + 10.0;
//  return d;
}
bool isClCenterLine(int limIdx) {
  switch (limIdx) {
    case LIMIT_MV_CENTER: return true;
    case LIMIT_S_CENTER: return true;
    case LIMIT_R_CENTER: return true;
    case LIMIT_RAW_CENTER: return true;
    case LIMIT_MA_MV_CENTER: return true;
    case LIMIT_EWMA_MV_CENTER: return true;
    case LIMIT_EWMA_S_CENTER: return true;
    case LIMIT_EWMA_R_CENTER: return true;
    case LIMIT_MS_MV_CENTER: return true;
  }
  return false;
}

double getSpecValue(Sample s, specLimIdx) {
  var specValue;
  if (specLimIdx == 0) {
    specValue = s.specLimitEnable[0] == 'Y' ? s.specUpper : null;
  }
  if (specLimIdx == 2) {
    specValue = s.specLimitEnable[1] == 'Y' ? s.specLower : null;
  }
  if (specLimIdx == 1) {
    specValue = s.specTargetOrigin == "V" ? s.specTarget : null;
  }
  return specValue == null ? null : transform(specValue);
}

double getLimitValue(int limIdx, Sample s) {
  double lim;
  switch (limIdx) {
    case LIMIT_MV_LCL: lim = s.mvLcl; break;
    case LIMIT_MV_LAL: lim = s.mvLal; break;
    case LIMIT_MV_CENTER: lim = s.mvCenter; break;
    case LIMIT_MV_UAL: lim = s.mvUal; break;
    case LIMIT_MV_UCL: lim = s.mvUcl; break;

    case LIMIT_SIGMA_LCL: lim = s.sLcl; break;
    case LIMIT_SIGMA_LAL: lim = s.sLal; break;
    case LIMIT_SIGMA_CENTER: lim = s.sCenter; break;
    case LIMIT_SIGMA_UAL: lim = s.sUal; break;
    case LIMIT_SIGMA_UCL: lim = s.sUcl; break;

    case LIMIT_RANGE_LCL: lim = s.rLcl; break;
    case LIMIT_RANGE_LAL: lim = s.rLal; break;
    case LIMIT_RANGE_CENTER: lim = s.rCenter; break;
    case LIMIT_RANGE_UAL: lim = s.rUal; break;
    case LIMIT_RANGE_UCL: lim = s.rUcl; break;

    case LIMIT_RAW_LCL: lim = s.rawLcl; break;
    case LIMIT_RAW_LAL: lim = s.rawLal; break;
    case LIMIT_RAW_CENTER: lim = s.rawCenter; break;
    case LIMIT_RAW_UAL: lim = s.rawUal; break;
    case LIMIT_RAW_UCL: lim = s.rawUcl; break;

    case LIMIT_MA_MV_LCL: lim = s.maMvLcl; break;
    case LIMIT_MA_MV_CENTER: lim = s.maMvCenter; break;
    case LIMIT_MA_MV_UCL: lim = s.maMvUcl; break;

    case LIMIT_EWMA_MV_LCL: lim = s.ewmaMvLcl; break;
    case LIMIT_EWMA_MV_CENTER: lim = s.ewmaMvCenter; break;
    case LIMIT_EWMA_MV_UCL: lim = s.ewmaMvUcl; break;

    case LIMIT_EWMA_S_LCL: lim = s.ewmaSLcl; break;
    case LIMIT_EWMA_S_CENTER: lim = s.ewmaSCenter; break;
    case LIMIT_EWMA_S_UCL: lim = s.ewmaSUcl; break;

    case LIMIT_EWMA_R_LCL: lim = s.ewmaRLcl; break;
    case LIMIT_EWMA_R_CENTER: lim = s.ewmaRCenter; break;
    case LIMIT_EWMA_R_UCL: lim = s.ewmaRUcl; break;

    case LIMIT_MS_MV_LCL: lim = s.msMvLcl; break;
    case LIMIT_MS_MV_CENTER: lim = s.msMvCenter; break;
    case LIMIT_MS_MV_UCL: lim = s.msMvUcl; break;

    default: return null;
  }
  bool masterFlag = true;
  bool enableFlag = true;
  String limEn = s.limitEnable;
  if (LIMIT_ALL < limEn.length) {
    masterFlag = limEn[LIMIT_ALL] == 'Y';
  }
  if (limIdx < limEn.length) {
    enableFlag = masterFlag && limEn[limIdx] == 'Y';
  }
  if (!enableFlag) {
    return null;
  }
  return transform(lim);
}
