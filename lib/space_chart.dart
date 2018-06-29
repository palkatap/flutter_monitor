import 'package:flutter/material.dart';
import 'space_chart_plot.dart';
import 'space_constants.dart';
import 'space_utils.dart';

import 'protobuf/monitor.pb.dart';

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

  List<Widget> _getVisiblePlots() {
    return widget.visiblePlots.map((plotType) {
      return new SpacePlotWidget.withData(widget.g, state: widget.state, plotType: plotType,);
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
    return new Scaffold(
      appBar: new AppBar(title: new Text("Hello")),
      body: new Padding(
          padding: const EdgeInsets.all(4.0),
          child: new ListView(
            children: _getVisiblePlots(),
            itemExtent: 150.0,
          ),
      ),
      floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.refresh), onPressed: _toggleSigma),
    );
  }
}
