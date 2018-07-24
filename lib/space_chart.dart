import 'package:flutter/material.dart';
import 'space_chart_plot.dart';
import 'space_constants.dart';
import 'space_utils.dart';

import 'protobuf/monitor.pb.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SpaceChartWidget extends StatefulWidget {
  final SpaceChartState state = new SpaceChartState();
  final Guidis g;
  final List<PlotType> availablePlots = new List();
  final List<PlotType> visiblePlots = new List();

  factory SpaceChartWidget.withData(Guidis g) {
    return SpaceChartWidget._internal(g: g);
  }

  SpaceChartWidget._internal({@required this.g}) {
    g.displayRules.clear();
//  g.displayRules[0].displayRule = DISPLAY_RULE_NEVER;
    g.displayRules.add(new DisplayRule()
      ..chartTypeId = CHART_TYPE_MV
      ..displayRule = DISPLAY_RULE_ALWAYS);
    g.displayRules.add(new DisplayRule()
      ..chartTypeId = CHART_TYPE_SIGMA
      ..displayRule = DISPLAY_RULE_ALWAYS);
    g.displayRules.add(new DisplayRule()
      ..chartTypeId = CHART_TYPE_RANGE
      ..displayRule = DISPLAY_RULE_ALWAYS);
    g.displayRules.add(new DisplayRule()
      ..chartTypeId = CHART_TYPE_EWMA_MEAN
      ..displayRule = DISPLAY_RULE_ALWAYS);
    g.displayRules.add(new DisplayRule()
      ..chartTypeId = CHART_TYPE_EWMA_S
      ..displayRule = DISPLAY_RULE_ALWAYS);

    state.showSpec = true;
    state.showCl = true;
    state.showAl = true;
    state.showZones = true;

    state.scaleBySpec = false;

    g.displayRules.forEach((rule) {
      var plotType = plotTypeFromId(rule.chartTypeId);
      if (plotType != null) {
        availablePlots.add(plotType);
        if (rule.displayRule == DISPLAY_RULE_ALWAYS) {
          visiblePlots.add(plotType);
        }
      }
    });
  }

  @override
  _SpaceChartWidgetState createState() => new _SpaceChartWidgetState();

}

class _SpaceChartWidgetState extends State<SpaceChartWidget> {
  int tempState = 0;
  charts.SelectionModelConfig<num> selectionChangedConfig;
  List<SpacePlotWidget> visiblePlots;

  _SpaceChartWidgetState() {
    selectionChangedConfig  = new charts.SelectionModelConfig(
      type: charts.SelectionModelType.info,
      listener: _onSelectionChanged,
    );
  }

  List<SpacePlotWidget> _getVisiblePlots() {
    return widget.visiblePlots.map((plotType) {
      return new SpacePlotWidget.withData(
        widget.g,
        state: widget.state,
        plotType: plotType,
        selectionModels: [selectionChangedConfig],
      );
//      return new Text(plotType.toString());
    }).toList();
  }

  void _toggleSigma() {
    setState(() {
      tempState++;
      if (tempState > 10) {
        tempState = 0;
      }
      switch (tempState) {
        case 0: widget.state.showCl = !widget.state.showCl;
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    visiblePlots = _getVisiblePlots();
    return new Scaffold(
      appBar: new AppBar(title: new Text("Hello")),
      body: new Padding(
          padding: const EdgeInsets.all(4.0),
          child: new ListView(
            children: visiblePlots,
            itemExtent: 150.0,
            padding: EdgeInsets.only(),
          ),
      ),
      floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.refresh), onPressed: _toggleSigma),
    );
  }

  _onSelectionChanged(charts.SelectionModel<num> model) {
    print("onSelectionChanged " + model.toString());
    var selectedEntries = model.selectedDatum;
    int idx;
    if (selectedEntries != null && selectedEntries.length > 0) {
      var sel = selectedEntries[0];
      idx = sel.index;
    }
    if (idx != null) {
      visiblePlots.forEach((p) {
        p.selectionModels[0];
      });
    }
//    visiblePlots.forEach((p) {
//      p.
//    });
  }
}
