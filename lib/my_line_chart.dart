import 'package:charts_flutter/flutter.dart';
import 'package:charts_flutter/src/cartesian_chart.dart' as cartesian;
import 'package:charts_flutter/src/base_chart_state.dart' as baseState;
import 'package:charts_flutter/src/behaviors/chart_behavior.dart' as chBehavior;
import 'package:charts_common/src/chart/common/processed_series.dart';
import 'package:charts_common/common.dart' as common;
import 'my_line_renderer.dart';


class SpaceChart extends cartesian.CartesianChart<num> {
  common.LineChart _chart;
  List<common.Series> _seriesList;

  SpaceChart(
      this._seriesList, {
        bool animate,
        Duration animationDuration,
        common.AxisSpec domainAxis,
        common.AxisSpec primaryMeasureAxis,
        common.AxisSpec secondaryMeasureAxis,
        MyLineRendererConfig<num> defaultRenderer,
        List<common.SeriesRendererConfig<num>> customSeriesRenderers,
        List<chBehavior.ChartBehavior> behaviors,
        List<SelectionModelConfig<num>> selectionModels,
        common.RTLSpec rtlSpec,
        LayoutConfig layoutConfig,
        bool defaultInteractions: true,
      }) : super(
    _seriesList,
    animate: animate,
    animationDuration: animationDuration,
    domainAxis: domainAxis,
    primaryMeasureAxis: primaryMeasureAxis,
    secondaryMeasureAxis: secondaryMeasureAxis,
    defaultRenderer: defaultRenderer,
    customSeriesRenderers: customSeriesRenderers,
    behaviors: behaviors,
    selectionModels: selectionModels,
    rtlSpec: rtlSpec,
    layoutConfig: layoutConfig,
    defaultInteractions: defaultInteractions,
  );

  @override
  common.LineChart createCommonChart(baseState.BaseChartState chartState) {
    _chart = new common.LineChart(layoutConfig: layoutConfig?.commonLayoutConfig);
    return _chart;
  }

  selectPoint(String seriesId, num domainValue) {
    var selectionModel = _chart.getSelectionModel(SelectionModelType.info);

    final selectedData = <SeriesDatum<num>>[];
    final selectedSeries = <MutableSeries<num>>[];

//    selectedSeries.addAll(_seriesList.where((MutableSeries<D> series) => selectedDataMap.keys.contains(series.id)));
//    var processedSeriesList = new List<MutableSeries<D>>.from(
//        seriesList.map((Series<dynamic, D> series) => makeSeries(series)));

    selectionModel.updateSelection(selectedData, selectedSeries, notifyListeners: false);
  }
}

