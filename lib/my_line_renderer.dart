import 'dart:collection' show LinkedHashMap;
import 'dart:math' show Rectangle, Point;

import 'package:meta/meta.dart' show required;


import 'package:charts_common/common.dart'
    show SymbolRenderer, SeriesRendererConfig, LineSymbolRenderer,
    ImmutableSeries, domainAxisKey, measureAxisKey, DatumDetails, BaseCartesianRenderer,
    PointRendererConfig, PointRenderer, ChartCanvas, Color
;
import 'package:charts_common/src/chart/layout/layout_view.dart' show LayoutViewConfig;
import 'package:charts_common/src/chart/common/series_renderer_config.dart' show RendererAttributes;
import 'package:charts_common/src/chart/common/processed_series.dart' show MutableSeries;
import 'package:charts_common/src/chart/cartesian/axis/axis.dart' show ImmutableAxis;
import 'package:charts_common/src/data/series.dart' show AttributeKey;
import 'package:charts_common/src/chart/common/chart_canvas.dart' show getAnimatedColor;

/// Configuration for a line renderer.
class MyLineRendererConfig<D> extends LayoutViewConfig
    implements SeriesRendererConfig<D> {
  final String customRendererId;

  final SymbolRenderer symbolRenderer;

  final rendererAttributes = new RendererAttributes();

  /// Radius of points on the line, if [includePoints] is enabled.
  final double radiusPx;

  /// Stroke width of the line.
  final double strokeWidthPx;

  /// Dash pattern for the line.
  final List<int> dashPattern;

  /// Configures whether a line representing the data will be drawn.
  final bool includeLine;

  /// Configures whether points representing the data will be drawn.
  final bool includePoints;

  final bool stairLine;

  MyLineRendererConfig(
      {this.customRendererId,
        this.radiusPx = 3.5,
        double strokeWidthPx = 2.0,
        this.dashPattern,
        this.includeLine = true,
        this.includePoints = false,
        this.stairLine = false,
        SymbolRenderer symbolRenderer})
      : this.strokeWidthPx = strokeWidthPx,
        this.symbolRenderer = symbolRenderer ?? new LineSymbolRenderer();

  @override
  MyLineRenderer<D> build() {
    return new MyLineRenderer<D>(config: this, rendererId: customRendererId);
  }

}

const lineElementsKey = const AttributeKey<List<_LineRendererElement>>('LineRenderer.lineElements');

class MyLineRenderer<D> extends BaseCartesianRenderer<D> {
  final MyLineRendererConfig config;

  PointRenderer _pointRenderer;

  /// Store a map of series drawn on the chart, mapped by series name.
  ///
  /// [LinkedHashMap] is used to render the series on the canvas in the same
  /// order as the data was given to the chart.
  final _seriesLineMap =
  new LinkedHashMap<String, List<_AnimatedElements<D>>>();

  // Store a list of lines that exist in the series data.
  //
  // This list will be used to remove any [_AnimatedLine] that were rendered in
  // previous draw cycles, but no longer have a corresponding datum in the new
  // data.
  final _currentKeys = <String>[];

  factory MyLineRenderer({String rendererId, MyLineRendererConfig config}) {
    return new MyLineRenderer._internal(
        rendererId: rendererId ?? 'line',
        config: config ?? new MyLineRendererConfig());
  }

  MyLineRenderer._internal({String rendererId, this.config})
      : super(
      rendererId: rendererId,
      layoutPositionOrder: 10,
      symbolRenderer: config.symbolRenderer) {
    _pointRenderer = new PointRenderer<D>(
        config: new PointRendererConfig<D>(radiusPx: this.config.radiusPx));
  }

  @override
  void layout(Rectangle<int> componentBounds, Rectangle<int> drawAreaBounds) {
    super.layout(componentBounds, drawAreaBounds);

    if (config.includePoints) {
      _pointRenderer.layout(componentBounds, drawAreaBounds);
    }
  }

  @override
  void configureSeries(List<MutableSeries<D>> seriesList) {
    assignMissingColors(seriesList, emptyCategoryUsesSinglePalette: false);

    if (config.includePoints) {
      _pointRenderer.configureSeries(seriesList);
    }
  }

  @override
  void preprocessSeries(List<MutableSeries<D>> seriesList) {
    seriesList.forEach((MutableSeries<D> series) {
      var elements = <_LineRendererElement<D>>[];

      var strokeWidthPxFn = series.strokeWidthPxFn;

      if (series.dashPattern == null) {
        series.dashPattern = config.dashPattern;
      }

      var details = new _LineRendererElement<D>();

      // Since we do not currently support segments for lines, just grab the
      // stroke width from the first datum for each series.
      //
      // TODO: Support stroke width per datum with line segments.
      if (series.data.length > 0 && strokeWidthPxFn != null) {
        details.strokeWidthPx = strokeWidthPxFn(0).toDouble();
      } else {
        details.strokeWidthPx = this.config.strokeWidthPx;
      }

      elements.add(details);

      series.setAttr(lineElementsKey, elements);
    });

    if (config.includePoints) {
      _pointRenderer.preprocessSeries(seriesList);
    }
  }

  void update(List<ImmutableSeries<D>> seriesList, bool isAnimatingThisDraw) {
    _currentKeys.clear();

    // List of final points for the previous line in a stack.
    List<_DatumPoint<D>> previousPointList;

    // List of initial points for the previous line in a stack, animated in from
    // the measure axis.
    List<_DatumPoint<D>> previousInitialPointList;

    seriesList.forEach((ImmutableSeries<D> series) {
      var lineKey = series.id;

      // TODO: Handle changes in data color, pattern, or other
      // attributes by configuring a list of line segments for the series,
      // instead of just one big line that contains all the points.
      var elementsList = _seriesLineMap.putIfAbsent(lineKey, () => []);

      var detailsList = series.getAttr(lineElementsKey);
      _LineRendererElement details = detailsList[0];

      // If we already have an AnimatingLine for that index, use it.
      _AnimatedElements<D> animatingElements;
      if (elementsList.length > 0) {
        animatingElements = elementsList[0];

        previousInitialPointList = animatingElements.line.currentPoints;
      } else {
        // Create a new line and have it animate in from axis.
        final line = _getLineElement(
            series, details, previousInitialPointList, true);

        // Create the line element.
        final animatingLine = new _AnimatedLine<D>(
            key: lineKey, overlaySeries: series.overlaySeries)
          ..setNewTarget(line);

        animatingElements = new _AnimatedElements<D>()
          ..line = animatingLine;

        elementsList.add(animatingElements);

        previousInitialPointList = line.points;
      }

      // Create a new line using the final point locations.
      final lineElem = _getLineElement(series, details, previousPointList, false);

      animatingElements.line.setNewTarget(lineElem);

      // Save the line points for the current series so that we can use them in
      // the area skirt for the next stacked series.
      previousPointList = lineElem.points;
    });

    // Animate out lines that don't exist anymore.
    _seriesLineMap.forEach((String key, List<_AnimatedElements<D>> elements) {
      for (var element in elements) {
        if (element.line != null &&
            _currentKeys.contains(element.line.key) != true) {
          element.line.animateOut();
        }
      }
    });

    if (config.includePoints) {
      _pointRenderer.update(seriesList, isAnimatingThisDraw);
    }
  }

  /// Creates a [_LineRendererElement] and a [_AreaRendererElement] for a given
  /// segment of a series.
  ///
  /// [details] represents the element details for a line segment. Until
  /// b/70576908 is implemented, there is only one segment for every series.
  ///
  /// [previousPointList] contains the points for the line below this series in
  /// the stack, if stacking is enabled. It forms the bottom edges for the area
  /// skirt.
  ///
  /// [initializeFromZero] controls whether we generate elements with measure
  /// values of 0, or using series data. This should be true when calculating
  /// point positions to animate in from the measure axis.
  _LineRendererElement _getLineElement(
      ImmutableSeries<D> series,
      _LineRendererElement details,
      List previousPointList,
      bool initializeFromZero) {
    var domainAxis = series.getAttr(domainAxisKey) as ImmutableAxis<D>;
    var domainFn = series.domainFn;
    var measureAxis = series.getAttr(measureAxisKey) as ImmutableAxis<num>;
    var measureFn = series.measureFn;
    var measureOffsetFn = series.measureOffsetFn;
    var colorFn = series.colorFn;
    var lineKey = series.id;
    var dashPattern = series.dashPattern;

    // Create a new line using the final point locations.
    var pointList = <_DatumPoint<D>>[];

    // TODO: Use the first datum until we break out line segments.
    Color color = colorFn(0);

    for (var index = 0; index < series.data.length; index++) {
      final datum = series.data[index];

      // TODO: Animate from the nearest lines in the stack.
      final measure = !initializeFromZero ? measureFn(index) : 0.0;
      final measureOffset = !initializeFromZero ? measureOffsetFn(index) : 0.0;

      final datumPoint = _getPoint(datum, domainFn(index), series, domainAxis,
          measure, measureOffset, measureAxis);

      // Only add the point if it is within the draw area bounds.
      if (datumPoint.x != null &&
          datumPoint.x >= drawBounds.left &&
          datumPoint.x <= drawBounds.right) {
        pointList.add(datumPoint);
      }
    }

    // Update the set of lines that still exist in the series data.
    _currentKeys.add(lineKey);

    // Get the line element we are going to to set up.
    final lineElement = new _LineRendererElement<D>()
      ..points = pointList
      ..color = color
      ..dashPattern = dashPattern
      ..measureAxisPosition = measureAxis.getLocation(0.0)
      ..strokeWidthPx = details.strokeWidthPx;

    return lineElement;
  }

  void paint(ChartCanvas canvas, double animationPercent) {
    // Clean up the lines that no longer exist.
    if (animationPercent == 1.0) {
      final keysToRemove = <String>[];

      _seriesLineMap.forEach((String key, List<_AnimatedElements<D>> elements) {
        elements.removeWhere(
                (_AnimatedElements<D> element) => element.animatingOut);

        if (elements.isEmpty) {
          keysToRemove.add(key);
        }
      });

      keysToRemove.forEach((String key) => _seriesLineMap.remove(key));
    }

    _seriesLineMap.forEach((String key, List<_AnimatedElements<D>> elements) {
      elements
          .map<_LineRendererElement<D>>(
              (_AnimatedElements<D> animatingElement) =>
              animatingElement.line?.getCurrentLine(animationPercent))
          .forEach((_LineRendererElement line) {
        if (line != null) {
          _drawLine(canvas, line);
        }
      });
    });

    if (config.includePoints) {
      _pointRenderer.paint(canvas, animationPercent);
    }
  }

  List<List<_DatumPoint<dynamic>>> getLineSegments(_LineRendererElement line) {
    List<List<_DatumPoint<dynamic>>> segments = List();
    List<_DatumPoint<dynamic>> l = List();
    int i = 0;
    for (i = 0; i < line.points.length; i++) {
      if (line.points[i].y == null) {
        if (l.isNotEmpty) {
          segments.add(l);
          l = List();
        }
      }
      else {
        l.add(line.points[i]);
      }
    }
    if (l.isNotEmpty) {
      segments.add(l);
    }
    return segments;
  }

  void _drawLine(ChartCanvas canvas, _LineRendererElement line) {
    var lineSegments = getLineSegments(line);
    lineSegments.forEach((l) {
      List<Point> points = l;
      if (config.stairLine) {
        Point previousPoint = l[0];
        final pointList = new List<Point>();
        pointList.add(previousPoint);
        for (var index = 1; index < l.length; index++) {
          final currPoint = l[index];
          if (previousPoint != null && previousPoint.y != null && currPoint.y != null && previousPoint.y != currPoint.y) {
            if (previousPoint.y != null) {
              pointList.add(_DatumPoint<D>.from(previousPoint, (currPoint.x + previousPoint.x)/2, previousPoint.y));
            }
            if (currPoint.y != null) {
              pointList.add(_DatumPoint<D>.from(previousPoint, (currPoint.x + previousPoint.x)/2, currPoint.y));
            }
          }
          pointList.add(currPoint);
          previousPoint = currPoint;
        }
        points = pointList;
      }
      canvas.drawLine(
          dashPattern: line.dashPattern,
          points: points,
          stroke: line.color,
          strokeWidthPx: line.strokeWidthPx);
    });
  }

  _DatumPoint<D> _getPoint(
      dynamic datum,
      D domainValue,
      ImmutableSeries<D> series,
      ImmutableAxis<D> domainAxis,
      num measureValue,
      num measureOffsetValue,
      ImmutableAxis<num> measureAxis) {
    final domainPosition = domainAxis.getLocation(domainValue);

    final measurePosition = measureValue == null ? null :  measureAxis.getLocation(measureValue + measureOffsetValue);

    return new _DatumPoint<D>(
        datum: datum,
        domain: domainValue,
        series: series,
        x: domainPosition,
        y: measurePosition);
  }

  @override
  List<DatumDetails<D>> getNearestDatumDetailPerSeries(
      Point<double> chartPoint) {
    final nearest = <DatumDetails<D>>[];

    // Was it even in the drawArea?
    if (!componentBounds.containsPoint(chartPoint)) {
      return nearest;
    }

    _seriesLineMap.values.forEach((List<_AnimatedElements<D>> seriesSegments) {
      _DatumPoint<D> nearestPoint;
      double nearestDomainDistance = 10000.0;
      double nearestMeasureDistance = 10000.0;

      seriesSegments.forEach((_AnimatedElements<D> segment) {
        if (segment.overlaySeries) {
          return;
        }

        segment.line._currentLine.points.forEach((Point p) {
          // Don't look at points not in the drawArea.
          if (p.x < componentBounds.left || p.x > componentBounds.right) {
            return;
          }

          final domainDistance = (p.x - chartPoint.x).abs();
          final measureDistance = p.y == null ? 10000.0 : (p.y - chartPoint.y).abs();
          if ((domainDistance < nearestDomainDistance) ||
              ((domainDistance == nearestDomainDistance &&
                  measureDistance < nearestMeasureDistance))) {
            nearestPoint = p;
            nearestDomainDistance = domainDistance;
            nearestMeasureDistance = measureDistance;
          }
        });
      });

      // Found a point, add it to the list.
      if (nearestPoint != null) {
        nearest.add(new DatumDetails<D>(
            datum: nearestPoint.datum,
            domain: nearestPoint.domain,
            series: nearestPoint.series,
            domainDistance: nearestDomainDistance,
            measureDistance: nearestMeasureDistance));
      }
    });

    // Note: the details are already sorted by domain & measure distance in
    // base chart.

    return nearest;
  }
}

class _DatumPoint<D> extends Point<double> {
  final dynamic datum;
  final D domain;
  final ImmutableSeries<D> series;

  _DatumPoint({this.datum, this.domain, this.series, double x, double y})
      : super(x, y);

  factory _DatumPoint.from(_DatumPoint<D> other, [double x, double y]) {
    return new _DatumPoint<D>(
        datum: other.datum,
        domain: other.domain,
        series: other.series,
        x: x ?? other.x,
        y: y ?? other.y);
  }
}

/// Rendering information for the line portion of a series.
class _LineRendererElement<D> {
  List<_DatumPoint<D>> points;
  Color color;
  List<int> dashPattern;
  double measureAxisPosition;
  double strokeWidthPx;

  _LineRendererElement<D> clone() {
    return new _LineRendererElement<D>()
      ..points = new List<_DatumPoint<D>>.from(points)
      ..color = color != null ? new Color.fromOther(color: color) : null
      ..dashPattern =
      dashPattern != null ? new List<int>.from(dashPattern) : null
      ..measureAxisPosition = measureAxisPosition
      ..strokeWidthPx = strokeWidthPx;
  }

  void updateAnimationPercent(_LineRendererElement previous,
      _LineRendererElement target, double animationPercent) {
    Point lastPoint;

    int pointIndex;
    for (pointIndex = 0; pointIndex < target.points.length; pointIndex++) {
      var targetPoint = target.points[pointIndex];

      // If we have more points than the previous line, animate in the new point
      // by starting its measure position at the last known official point.
      // TODO: Can this be done in setNewTarget instead?
      _DatumPoint<D> previousPoint;
      if (previous.points.length - 1 >= pointIndex) {
        previousPoint = previous.points[pointIndex];
        lastPoint = previousPoint;
      } else {
        previousPoint =
        new _DatumPoint<D>.from(targetPoint, targetPoint.x, lastPoint.y);
      }

      var x = ((targetPoint.x - previousPoint.x) * animationPercent) + previousPoint.x;

      var y = (targetPoint.y == null || previousPoint.y == null) ? null :
        ((targetPoint.y - previousPoint.y) * animationPercent) + previousPoint.y;

      if (points.length - 1 >= pointIndex) {
        points[pointIndex] = new _DatumPoint<D>.from(targetPoint, x, y);
      } else {
        points.add(new _DatumPoint<D>.from(targetPoint, x, y));
      }
    }

    // Removing extra points that don't exist anymore.
    if (pointIndex < points.length) {
      points.removeRange(pointIndex, points.length);
    }

    color = getAnimatedColor(previous.color, target.color, animationPercent);

    strokeWidthPx =
    (((target.strokeWidthPx - previous.strokeWidthPx) * animationPercent) +
        previous.strokeWidthPx);
  }
}

/// Animates the line element of a series between different states.
class _AnimatedLine<D> {
  final String key;
  final bool overlaySeries;

  _LineRendererElement<D> _previousLine;
  _LineRendererElement<D> _targetLine;
  _LineRendererElement<D> _currentLine;

  // Flag indicating whether this line is being animated out of the chart.
  bool animatingOut = false;

  _AnimatedLine({@required this.key, @required this.overlaySeries});

  /// Animates a line that was removed from the series out of the view.
  ///
  /// This should be called in place of "setNewTarget" for lines that represent
  /// data that has been removed from the series.
  ///
  /// Animates the height of the line down to the measure axis position
  /// (position of 0).
  void animateOut() {
    var newTarget = _currentLine.clone();

    // Set the target measure value to the axis position for all points.
    // TODO: Animate to the nearest lines in the stack.
    var newPoints = <_DatumPoint<D>>[];
    for (var index = 0; index < newTarget.points.length; index++) {
      var targetPoint = newTarget.points[index];

      newPoints.add(new _DatumPoint<D>.from(targetPoint, targetPoint.x,
          newTarget.measureAxisPosition.roundToDouble()));
    }

    newTarget.points = newPoints;

    // Animate the stroke width to 0 so that we don't get a lingering line after
    // animation is done.
    newTarget.strokeWidthPx = 0.0;

    setNewTarget(newTarget);
    animatingOut = true;
  }

  void setNewTarget(_LineRendererElement<D> newTarget) {
    animatingOut = false;
    _currentLine ??= newTarget.clone();
    _previousLine = _currentLine.clone();
    _targetLine = newTarget;
  }

  _LineRendererElement<D> getCurrentLine(double animationPercent) {
    if (animationPercent == 1.0 || _previousLine == null) {
      _currentLine = _targetLine;
      _previousLine = _targetLine;
      return _currentLine;
    }

    _currentLine.updateAnimationPercent(
        _previousLine, _targetLine, animationPercent);

    return _currentLine;
  }

  /// Returns the [points] of the current target element, without updating
  /// animation state.
  List<_DatumPoint<D>> get currentPoints => _currentLine?.points;
}

/// Rendering information for the area skirt portion of a series.
class _AnimatedElements<D> {
  _AnimatedLine<D> line;

  bool get animatingOut {
    return (line == null || line.animatingOut);
  }

  bool get overlaySeries {
    return (line == null || line.overlaySeries);
  }
}
