import 'dart:math';
import 'package:flutter/material.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart' as charts;
import '../models/chart_spec.dart';

const _palette = [
  Color(0xFF2563EB),
  Color(0xFFF97316),
  Color(0xFF16A34A),
  Color(0xFFDB2777),
  Color(0xFF7C3AED),
  Color(0xFFEAB308),
  Color(0xFF0D9488),
  Color(0xFFDC2626),
];

Color _c(int i) => _palette[i % _palette.length];
charts.Color _cc(int i) {
  final c = _c(i);
  return charts.Color(r: c.red, g: c.green, b: c.blue);
}

double _rand(Random r, double min, double max) => min + r.nextDouble() * (max - min);

class _Point {
  final String label;
  final double value;
  _Point(this.label, this.value);
}

class _TimePoint {
  final DateTime time;
  final double value;
  _TimePoint(this.time, this.value);
}

class _XY {
  final double x;
  final double y;
  _XY(this.x, this.y);
}

List<_Point> _series(Random r, int n, {double min = 10, double max = 100}) =>
    List.generate(n, (i) => _Point('C${i + 1}', _rand(r, min, max)));

/// ---------- BÁSICAS (8 familias x 5) ----------

ChartSpec _bar(int i) {
  final r = Random(i);
  final data = _series(r, 4 + (i % 5));
  return ChartSpec(
    title: 'Barras verticales #${i + 1}',
    description: 'charts.BarChart simple.',
    level: ChartLevel.basica,
    builder: (_) => charts.BarChart(
      [
        charts.Series<_Point, String>(
          id: 'Serie',
          domainFn: (p, _) => p.label,
          measureFn: (p, _) => p.value,
          data: data,
          colorFn: (_, __) => _cc(i),
        ),
      ],
      animate: true,
    ),
  );
}

ChartSpec _barHorizontal(int i) {
  final r = Random(i + 100);
  final data = _series(r, 4 + (i % 4));
  return ChartSpec(
    title: 'Barras horizontales #${i + 1}',
    description: 'BarChart con vertical:false.',
    level: ChartLevel.basica,
    builder: (_) => charts.BarChart(
      [
        charts.Series<_Point, String>(
          id: 'Serie',
          domainFn: (p, _) => p.label,
          measureFn: (p, _) => p.value,
          data: data,
          colorFn: (_, __) => _cc(i + 1),
        ),
      ],
      animate: true,
      vertical: false,
    ),
  );
}

ChartSpec _line(int i) {
  final r = Random(i + 200);
  final data = _series(r, 6 + (i % 4));
  return ChartSpec(
    title: 'Línea #${i + 1}',
    description: 'charts.LineChart simple.',
    level: ChartLevel.basica,
    builder: (_) => charts.LineChart(
      [
        charts.Series<_Point, num>(
          id: 'Serie',
          domainFn: (_, index) => index ?? 0,
          measureFn: (p, _) => p.value,
          data: data,
          colorFn: (_, __) => _cc(i + 2),
        ),
      ],
      animate: true,
    ),
  );
}

ChartSpec _lineMulti(int i) {
  final r = Random(i + 300);
  final n = 6 + (i % 3);
  final s1 = _series(r, n);
  final s2 = _series(r, n);
  return ChartSpec(
    title: 'Multi-línea #${i + 1}',
    description: '2 series LineChart comparadas.',
    level: ChartLevel.basica,
    builder: (_) => charts.LineChart(
      [
        charts.Series<_Point, num>(id: 'A', domainFn: (_, index) => index ?? 0, measureFn: (p, _) => p.value, data: s1, colorFn: (_, __) => _cc(i)),
        charts.Series<_Point, num>(id: 'B', domainFn: (_, index) => index ?? 0, measureFn: (p, _) => p.value, data: s2, colorFn: (_, __) => _cc(i + 3)),
      ],
      animate: true,
    ),
  );
}

ChartSpec _pie(int i) {
  final r = Random(i + 400);
  final data = _series(r, 3 + (i % 4), min: 10, max: 60);
  return ChartSpec(
    title: 'Pie chart #${i + 1}',
    description: 'charts.PieChart con etiquetas.',
    level: ChartLevel.basica,
    builder: (_) => charts.PieChart<String>(
      [
        charts.Series<_Point, String>(
          id: 'Serie',
          domainFn: (p, _) => p.label,
          measureFn: (p, _) => p.value,
          data: data,
          colorFn: (_, idx) => _cc(i + (idx ?? 0)),
          labelAccessorFn: (p, _) => p.label,
        ),
      ],
      animate: true,
      defaultRenderer: charts.ArcRendererConfig(arcRendererDecorators: [charts.ArcLabelDecorator()]),
    ),
  );
}

ChartSpec _donut(int i) {
  final r = Random(i + 500);
  final data = _series(r, 3 + (i % 4), min: 10, max: 60);
  return ChartSpec(
    title: 'Donut chart #${i + 1}',
    description: 'PieChart con arco interno (donut).',
    level: ChartLevel.basica,
    builder: (_) => charts.PieChart<String>(
      [
        charts.Series<_Point, String>(
          id: 'Serie',
          domainFn: (p, _) => p.label,
          measureFn: (p, _) => p.value,
          data: data,
          colorFn: (_, idx) => _cc(i + (idx ?? 0) + 2),
        ),
      ],
      animate: true,
      defaultRenderer: charts.ArcRendererConfig(arcWidth: 40),
    ),
  );
}

ChartSpec _timeSeries(int i) {
  final r = Random(i + 600);
  final n = 6 + (i % 5);
  final base = DateTime(2026, 1, 1);
  final data = List.generate(n, (idx) => _TimePoint(base.add(Duration(days: idx * 3)), _rand(r, 10, 100)));
  return ChartSpec(
    title: 'Serie temporal #${i + 1}',
    description: 'TimeSeriesChart con fechas reales.',
    level: ChartLevel.basica,
    builder: (_) => charts.TimeSeriesChart(
      [
        charts.Series<_TimePoint, DateTime>(
          id: 'Serie',
          domainFn: (d, _) => d.time,
          measureFn: (d, _) => d.value,
          data: data,
          colorFn: (_, __) => _cc(i + 4),
        ),
      ],
      animate: true,
    ),
  );
}

ChartSpec _scatter(int i) {
  final r = Random(i + 700);
  final n = 10 + (i % 10);
  final data = List.generate(n, (idx) => _XY(_rand(r, 0, 100), _rand(r, 0, 100)));
  return ChartSpec(
    title: 'Dispersión #${i + 1}',
    description: 'ScatterPlotChart.',
    level: ChartLevel.basica,
    builder: (_) => charts.ScatterPlotChart(
      [
        charts.Series<_XY, num>(
          id: 'Serie',
          domainFn: (p, _) => p.x,
          measureFn: (p, _) => p.y,
          data: data,
          colorFn: (_, __) => _cc(i + 5),
        ),
      ],
      animate: true,
    ),
  );
}

final List<ChartSpec Function(int)> _basicFamilies = [
  _bar,
  _barHorizontal,
  _line,
  _lineMulti,
  _pie,
  _donut,
  _timeSeries,
  _scatter,
];

/// ---------- AVANZADAS (5 familias x 5) ----------

ChartSpec _groupedBar(int i) {
  final r = Random(i + 1000);
  final n = 4 + (i % 3);
  final s1 = _series(r, n, min: 10, max: 60);
  final s2 = _series(r, n, min: 10, max: 60);
  return ChartSpec(
    title: 'Barras agrupadas #${i + 1}',
    description: '2 series BarChart lado a lado (grouped).',
    level: ChartLevel.avanzada,
    builder: (_) => charts.BarChart(
      [
        charts.Series<_Point, String>(id: 'A', domainFn: (p, _) => p.label, measureFn: (p, _) => p.value, data: s1, colorFn: (_, __) => _cc(i)),
        charts.Series<_Point, String>(id: 'B', domainFn: (p, _) => p.label, measureFn: (p, _) => p.value, data: s2, colorFn: (_, __) => _cc(i + 1)),
      ],
      animate: true,
      barGroupingType: charts.BarGroupingType.grouped,
    ),
  );
}

ChartSpec _stackedBar(int i) {
  final r = Random(i + 1100);
  final n = 4 + (i % 3);
  final s1 = _series(r, n, min: 5, max: 30);
  final s2 = _series(r, n, min: 5, max: 30);
  final s3 = _series(r, n, min: 5, max: 30);
  return ChartSpec(
    title: 'Barras apiladas #${i + 1}',
    description: '3 series BarChart apiladas (stacked).',
    level: ChartLevel.avanzada,
    builder: (_) => charts.BarChart(
      [
        charts.Series<_Point, String>(id: 'A', domainFn: (p, _) => p.label, measureFn: (p, _) => p.value, data: s1, colorFn: (_, __) => _cc(i)),
        charts.Series<_Point, String>(id: 'B', domainFn: (p, _) => p.label, measureFn: (p, _) => p.value, data: s2, colorFn: (_, __) => _cc(i + 1)),
        charts.Series<_Point, String>(id: 'C', domainFn: (p, _) => p.label, measureFn: (p, _) => p.value, data: s3, colorFn: (_, __) => _cc(i + 2)),
      ],
      animate: true,
      barGroupingType: charts.BarGroupingType.stacked,
    ),
  );
}

ChartSpec _lineWithArea(int i) {
  final r = Random(i + 1200);
  final data = _series(r, 7 + (i % 4));
  return ChartSpec(
    title: 'Línea con área rellena #${i + 1}',
    description: 'LineChart con includeArea + selección al tocar.',
    level: ChartLevel.avanzada,
    builder: (_) => charts.LineChart(
      [
        charts.Series<_Point, num>(
          id: 'Serie',
          domainFn: (_, index) => index ?? 0,
          measureFn: (p, _) => p.value,
          data: data,
          colorFn: (_, __) => _cc(i + 3),
        ),
      ],
      animate: true,
      defaultRenderer: charts.LineRendererConfig(includeArea: true, stacked: false),
      behaviors: [charts.SelectNearest(), charts.LinePointHighlighter()],
    ),
  );
}

ChartSpec _barWithLegend(int i) {
  final r = Random(i + 1300);
  final n = 4 + (i % 3);
  final s1 = _series(r, n, min: 10, max: 60);
  final s2 = _series(r, n, min: 10, max: 60);
  return ChartSpec(
    title: 'Barras con leyenda + tooltip #${i + 1}',
    description: 'BarChart con leyenda interactiva y comportamiento de selección.',
    level: ChartLevel.avanzada,
    builder: (_) => charts.BarChart(
      [
        charts.Series<_Point, String>(id: 'Norte', domainFn: (p, _) => p.label, measureFn: (p, _) => p.value, data: s1, colorFn: (_, __) => _cc(i)),
        charts.Series<_Point, String>(id: 'Sur', domainFn: (p, _) => p.label, measureFn: (p, _) => p.value, data: s2, colorFn: (_, __) => _cc(i + 4)),
      ],
      animate: true,
      behaviors: [charts.SeriesLegend(position: charts.BehaviorPosition.bottom)],
    ),
  );
}

ChartSpec _timeSeriesRange(int i) {
  final r = Random(i + 1400);
  final n = 8 + (i % 6);
  final base = DateTime(2026, 1, 1);
  final data = List.generate(n, (idx) => _TimePoint(base.add(Duration(days: idx * 5)), _rand(r, 20, 100)));
  return ChartSpec(
    title: 'Serie temporal con selección #${i + 1}',
    description: 'TimeSeriesChart con SelectNearest y línea guía.',
    level: ChartLevel.avanzada,
    builder: (_) => charts.TimeSeriesChart(
      [
        charts.Series<_TimePoint, DateTime>(
          id: 'Serie',
          domainFn: (d, _) => d.time,
          measureFn: (d, _) => d.value,
          data: data,
          colorFn: (_, __) => _cc(i + 6),
        ),
      ],
      animate: true,
      behaviors: [charts.ChartTitle('Tendencia'), charts.LinePointHighlighter()],
    ),
  );
}

final List<ChartSpec Function(int)> _advancedFamilies = [
  _groupedBar,
  _stackedBar,
  _lineWithArea,
  _barWithLegend,
  _timeSeriesRange,
];

List<ChartSpec> buildCommunityChartsSpecs() {
  final List<ChartSpec> specs = [];
  for (final family in _basicFamilies) {
    for (var v = 0; v < 5; v++) {
      specs.add(family(specs.length + v));
    }
  }
  for (final family in _advancedFamilies) {
    for (var v = 0; v < 5; v++) {
      specs.add(family(specs.length + v));
    }
  }
  return specs;
}
