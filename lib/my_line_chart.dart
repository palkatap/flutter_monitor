import 'package:charts_flutter/flutter.dart';
import 'package:charts_flutter/src/cartesian_chart.dart' as cartesian;
import 'package:charts_flutter/src/base_chart_state.dart' as baseState;
import 'package:charts_flutter/src/behaviors/chart_behavior.dart' as chBehavior;
import 'package:charts_common/common.dart' as common;
import 'my_line_renderer.dart';


class MyLineChart extends cartesian.CartesianChart<num> {
  MyLineChart(
      List<common.Series> seriesList, {
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
    seriesList,
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
  common.LineChart createCommonChart(baseState.BaseChartState chartState) =>
      new common.LineChart(layoutConfig: layoutConfig?.commonLayoutConfig);

  @override
  void addDefaultInteractions(List<chBehavior.ChartBehavior> behaviors) {
    super.addDefaultInteractions(behaviors);

    behaviors.add(new LinePointHighlighter());
  }
}

