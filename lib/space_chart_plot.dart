import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_common/src/data/series.dart' show TypedAccessorFn;

import 'my_line_chart.dart';
import 'my_line_renderer.dart';
import 'my_line_point_highlighter.dart';
import 'space_constants.dart';
import 'space_utils.dart';

import 'protobuf/monitor.pb.dart';

typedef bool MissingValue(ChartPoint p);
typedef num GetChartValue(Sample p);


class SpacePlotWidget extends StatelessWidget {
  static const SERIES_VALUE = "value";
  static const SERIES_SPEC = "SPEC ";
  static const SERIES_CL = "CL ";
  static const SERIES_AL = "AL ";
  static const SERIES_ZONE = "ZONE ";
  static const SERIES_EXT_SPEC = "EXT_SPEC ";

  final List<charts.Series<ChartPoint, int>> seriesList;
  final bool animate;
  final Guidis g;
  final SpaceChartState state;
  final PlotType plotType;

  /// Creates a [LineChart] with sample data and no transition.
  factory SpacePlotWidget.withData(Guidis g, {SpaceChartState state, PlotType plotType}) {
    var plotTyp = plotType ?? PlotType.mv;
    var spaceChartState = state ?? new SpaceChartState();
    return new SpacePlotWidget._internal(
      g,
      _createData(g, spaceChartState, plotTyp),
      spaceChartState,
      plotTyp,
      animate: true,
    );
  }

  SpacePlotWidget._internal(
      this.g,
      this.seriesList,
      this.state,
      this.plotType,
      {this.animate});

  static List<charts.Series<ChartPoint, int>> _createData(Guidis g, SpaceChartState state, PlotType plotType) {
    int i = 0;
    List<ChartPoint> samples = g.samples.map((s) {
      return ChartPoint(i++, s);
    }).toList();

    List<charts.Series<ChartPoint, int>> series = new List();
    TypedAccessorFn<ChartPoint, num> measureFn;
    int idxUcl;
    int idxCl;
    int idxLcl;
    int idxUal;
    int idxLal;
    switch (plotType) {
      case PlotType.mv:
        idxUcl = LIMIT_MV_UCL;
        idxCl = LIMIT_MV_CENTER;
        idxLcl = LIMIT_MV_LCL;
        idxUal = LIMIT_MV_UAL;
        idxLal = LIMIT_MV_LAL;
        measureFn = (ChartPoint p, _) => p.smp.extMv;
        break;
      case PlotType.sigma:
        idxUcl = LIMIT_S_UCL;
        idxCl = LIMIT_S_CENTER;
        idxLcl = LIMIT_S_LCL;
        idxUal = LIMIT_SIGMA_UAL;
        idxLal = LIMIT_SIGMA_LAL;
        measureFn = (ChartPoint p, _) => p.smp.extSigma;
        break;
      case PlotType.range:
        idxUcl = LIMIT_R_UCL;
        idxCl = LIMIT_R_CENTER;
        idxLcl = LIMIT_R_LCL;
        idxUal = LIMIT_RANGE_UAL;
        idxLal = LIMIT_RANGE_LAL;
        measureFn = (ChartPoint p, _) => p.smp.extMax - p.smp.extMin;
        break;
      case PlotType.ewmaMv:
        idxUcl = LIMIT_EWMA_MV_UCL;
        idxCl = LIMIT_EWMA_MV_CENTER;
        idxLcl = LIMIT_EWMA_MV_LCL;
        measureFn = (ChartPoint p, _) => p.smp.ewmaMv;
        break;
      case PlotType.ewmaS:
        idxUcl = LIMIT_EWMA_S_UCL;
        idxCl = LIMIT_EWMA_S_CENTER;
        idxLcl = LIMIT_EWMA_S_LCL;
        measureFn = (ChartPoint p, _) => p.smp.ewmaS;
        break;
      case PlotType.ewmaR:
        idxUcl = LIMIT_EWMA_R_UCL;
        idxCl = LIMIT_EWMA_R_CENTER;
        idxLcl = LIMIT_EWMA_R_LCL;
        measureFn = (ChartPoint p, _) => p.smp.ewmaR;
        break;
      case PlotType.ma:
        idxUcl = LIMIT_MA_MV_UCL;
        idxCl = LIMIT_MA_MV_CENTER;
        idxLcl = LIMIT_MA_MV_LCL;
        measureFn = (ChartPoint p, _) => p.smp.maMv;
        break;
      case PlotType.ms:
        idxUcl = LIMIT_MS_MV_UCL;
        idxCl = LIMIT_MS_MV_CENTER;
        idxLcl = LIMIT_MS_MV_LCL;
        measureFn = (ChartPoint p, _) => p.smp.msMv;
        break;
      default:
        print("??????????????");
        break;
    }
    series.add(
        new charts.Series<ChartPoint, int>(
          id: SERIES_VALUE,
          colorFn: (_, __) => charts.MaterialPalette.black,
          domainFn: (ChartPoint p, x) => x,
          measureFn: measureFn,
//        measureUpperBoundFn: (ChartPoint p, _) => 20.0, //p.smp.extMv + 1,
          data: samples,
        )
          ..setAttribute(charts.rendererIdKey, 'value'));
    if (state.showSpec && plotType == PlotType.mv) {
      series.add(_getUSLSeries(samples));
      series.add(_getLSLSeries(samples));
      series.add(_getTgtSeries(samples));
    }
    if (state.showCl) {
      series.add(_getCLSeries(samples, idxUcl));
      series.add(_getCLSeries(samples, idxCl));
      series.add(_getCLSeries(samples, idxLcl));
    }
    if (state.showZones && plotType == PlotType.mv) {
      series.add(_getZoneSeries(samples, 0));
      series.add(_getZoneSeries(samples, 1));
      series.add(_getZoneSeries(samples, 2));
      series.add(_getZoneSeries(samples, 3));
    }
    if (state.showAl) {
      if (idxUal != null) {
        series.add(_getALSeries(samples, idxUal));
      }
      if (idxLal != null) {
        series.add(_getALSeries(samples, idxLal));
      }
    }
    return series;
  }

  static charts.Series<ChartPoint, int> _getValueSeries(List<ChartPoint> samples, PlotType plotType) {
    var series = new charts.Series<ChartPoint, int>(
      id: SERIES_SPEC + "USL",
      colorFn: (_, __) => charts.Color(r: 255, g: 78, b: 0),
      domainFn: (ChartPoint p, x) => x,
      measureFn: (ChartPoint p, _) => getSpecValue(p.smp, 0),
      data: samples,
    );
    return series;
  }

  static charts.Series<ChartPoint, int> _getUSLSeries(List<ChartPoint> samples) {
    var series = new charts.Series<ChartPoint, int>(
      id: SERIES_SPEC + "USL",
      colorFn: (_, __) => charts.Color(r: 255, g: 78, b: 0),
      domainFn: (ChartPoint p, x) => x,
      measureFn: (ChartPoint p, _) => getSpecValue(p.smp, 0),
      data: samples,
    );
    return series;
  }

  static charts.Series<ChartPoint, int> _getTgtSeries(List<ChartPoint> samples) {
    var series = new charts.Series<ChartPoint, int>(
      id: SERIES_SPEC + "Target",
      dashPattern: [4, 4],
      colorFn: (_, __) => charts.Color(r: 255, g: 78, b: 0),
      domainFn: (ChartPoint p, x) => x,
      measureFn: (ChartPoint p, _) => getSpecValue(p.smp, 1),
      data: samples,
    );
    return series;
  }

  static charts.Series<ChartPoint, int> _getLSLSeries(List<ChartPoint> samples) {
    var series = new charts.Series<ChartPoint, int>(
      id: SERIES_SPEC + "LSL",
      colorFn: (_, __) => charts.Color(r: 255, g: 78, b: 0),
      domainFn: (ChartPoint p, x) => x,
      measureFn: (ChartPoint p, _) => getSpecValue(p.smp, 2),
      data: samples,
    );
    return series;
  }

  static charts.Series<ChartPoint, int> _getCLSeries(List<ChartPoint> samples, int limitIdx) {
    var series = new charts.Series<ChartPoint, int>(
      id: SERIES_CL + limitIdx.toString(),
      dashPattern: isClCenterLine(limitIdx) ? [4, 4] : null,
      colorFn: (_, __) => charts.Color(r: 70, g: 0, b: 230),
      domainFn: (ChartPoint p, x) => x,
      measureFn: (ChartPoint p, _) => getLimitValue(limitIdx, p.smp),
      data: samples,
    );
    return series;
  }

  static charts.Series<ChartPoint, int> _getALSeries(List<ChartPoint> samples, int limitIdx) {
    var series = new charts.Series<ChartPoint, int>(
      id: SERIES_AL + limitIdx.toString(),
      dashPattern: [2, 2],
      colorFn: (_, __) => charts.Color(r: 0, g: 160, b: 230),
//      colorFn: (_, __) => charts.MaterialPalette.lime.shadeDefault,
      domainFn: (ChartPoint p, x) => x,
      measureFn: (ChartPoint p, _) => getLimitValue(limitIdx, p.smp),
      data: samples,
    );
    return series;
  }

  static charts.Series<ChartPoint, int> _getZoneSeries(List<ChartPoint> samples, int zoneIdx) {
    var limitIdx = zoneIdx < 2 ? LIMIT_MV_UCL : LIMIT_MV_LCL;
    var zoneFactor = zoneIdx % 2 == 0 ? 2 / 3.0 : 1 / 3.0;
    var series = new charts.Series<ChartPoint, int>(
      id: SERIES_ZONE + zoneIdx.toString(),
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
    );
    return series;
  }

  bool _scaleBy(charts.Series<ChartPoint, int> s) {
    if (s.id.startsWith(SERIES_VALUE)) {
      return state.scaleByValues;
    }
    if (s.id.startsWith(SERIES_CL)) {
      return state.scaleByCl;
    }
    if (s.id.startsWith(SERIES_ZONE)) {
      return state.scaleByCl;
    }
    if (s.id.startsWith(SERIES_AL)) {
      return state.scaleByAl;
    }
    if (s.id.startsWith(SERIES_SPEC)) {
      return state.scaleBySpec;
    }
    if (s.id.startsWith(SERIES_EXT_SPEC)) {
      return state.scaleByCl; // TODO scaleBySpec?
    }
    return false;
  }

  charts.NumericExtents _getYRange() {
    double min;
    double max;
    _getVisibleSeries().forEach((s) {
//      print("series " + s.id);
      if (s.data != null && s.measureFn != null && _scaleBy(s)) {
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

  List<charts.Series<ChartPoint, int>> _getVisibleSeries() {
    List<charts.Series<ChartPoint, int>> visibleSeries = new List();
    seriesList.forEach((s) {
      if (s.id.startsWith(SERIES_VALUE)) {
        visibleSeries.add(s);
      }
      if (s.id.startsWith(SERIES_CL) && state.showCl) {
        visibleSeries.add(s);
      }
      if (s.id.startsWith(SERIES_ZONE) && state.showCl) {
        visibleSeries.add(s);
      }
      if (s.id.startsWith(SERIES_AL) && state.showAl) {
        visibleSeries.add(s);
      }
      if (s.id.startsWith(SERIES_SPEC) && state.showSpec) {
        visibleSeries.add(s);
      }
      if (s.id.startsWith(SERIES_EXT_SPEC) && state.showExtSpec) {
        visibleSeries.add(s);
      }
    });
    return visibleSeries;
  }

  @override
  Widget build(BuildContext context) {
//    return new DecoratedBox(
//      decoration: new BoxDecoration(
//        color: Color(0xff0000ff),
//        border: Border.all(color: new Color(0x80ff0000), width: 5.0)
//      ),
//      position: DecorationPosition.background,
//      child:
//    ),
  return new ClipRect(
    child:
//    return
      new SpaceChart(
        _getVisibleSeries(),
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
            viewport: _getYRange(),
            tickProviderSpec: new charts.BasicNumericTickProviderSpec(zeroBound: false)),
        customSeriesRenderers: [
          new MyLineRendererConfig(
              strokeWidthPx: 1.0,
              includeLine: true,
              includePoints: true,
              radiusPx: 3.0,
              stairLine: false,
              customRendererId: 'value'),
        ],

        /// This is an OrdinalAxisSpec to match up with BarChart's default
        /// ordinal domain axis (use NumericAxisSpec or DateTimeAxisSpec for
        /// other charts).
        domainAxis: new charts.NumericAxisSpec(
          // Make sure that we draw the domain axis line.
            showAxisLine: false,
            // But don't draw anything else.
            renderSpec: new charts.NoneRenderSpec()),

      )
  );
  }
}


class ChartPoint {
  final int pos;
  final Sample smp;

  ChartPoint(this.pos, this.smp);
}

