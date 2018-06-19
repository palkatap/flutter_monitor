import 'package:meta/meta.dart';

import 'package:charts_flutter/src/behaviors/chart_behavior.dart' show ChartBehavior, GestureType;
import 'package:charts_common/common.dart' as common
    show LinePointHighlighter, SelectionModelType, ChartBehavior, BaseChart, LifecycleListener, SelectionModelType;
import 'package:flutter/widgets.dart' show hashValues;
import 'package:meta/meta.dart' show immutable;
import 'my_highlighter_common.dart';

//import 'chart_behavior.dart' show ChartBehavior, GestureType;

/// Chart behavior that monitors the specified [SelectionModel] and darkens the
/// color for selected data.
///
/// This is typically used for bars and pies to highlight segments.
///
/// It is used in combination with SelectNearest to update the selection model
/// and expand selection out to the domain value.
@immutable
class MyLinePointHighlighter extends ChartBehavior<MyLinePointHighlighterCommon> {
  final desiredGestures = new Set<GestureType>();

  final common.SelectionModelType selectionModelType;

  /// Default radius of the dots if the series has no radius mapping function.
  ///
  /// When no radius mapping function is provided, this value will be used as
  /// is. [radiusPaddingPx] will not be added to [defaultRadiusPx].
  final double defaultRadiusPx;

  /// Additional radius value added to the radius of the selected data.
  ///
  /// This value is only used when the series has a radius mapping function
  /// defined.
  final double radiusPaddingPx;

  final bool showHorizontalFollowLine;

  final bool showVerticalFollowLine;

  MyLinePointHighlighter(
      {this.selectionModelType = common.SelectionModelType.info,
        this.defaultRadiusPx = 4.0,
        this.radiusPaddingPx = 0.5,
        this.showHorizontalFollowLine = false,
        this.showVerticalFollowLine = true});

  @override
  MyLinePointHighlighterCommon<D> createCommonBehavior<D>() =>
      new MyLinePointHighlighterCommon<D>(
          selectionModelType: selectionModelType,
          defaultRadiusPx: defaultRadiusPx,
          radiusPaddingPx: radiusPaddingPx,
          showHorizontalFollowLine: showHorizontalFollowLine,
          showVerticalFollowLine: showVerticalFollowLine);

  @override
  void updateCommonBehavior(MyLinePointHighlighterCommon commonBehavior) {}

  @override
  String get role => 'MyLinePointHighlighter-${selectionModelType.toString()}';

  @override
  bool operator ==(Object o) {
    return o is MyLinePointHighlighter &&
        defaultRadiusPx == o.defaultRadiusPx &&
        radiusPaddingPx == o.radiusPaddingPx &&
        showHorizontalFollowLine == o.showHorizontalFollowLine &&
        showVerticalFollowLine == o.showVerticalFollowLine &&
        selectionModelType == o.selectionModelType;
  }

  @override
  int get hashCode {
    return hashValues(selectionModelType, defaultRadiusPx, radiusPaddingPx,
        showHorizontalFollowLine, showVerticalFollowLine);
  }
}

