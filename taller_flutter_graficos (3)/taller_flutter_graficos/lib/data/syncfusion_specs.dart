import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
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
double _rand(Random r, double min, double max) => min + r.nextDouble() * (max - min);

class _Point {
  final String x;
  final double y;
  _Point(this.x, this.y);
}

List<_Point> _series(Random r, int n, {double min = 10, double max = 100}) =>
    List.generate(n, (i) => _Point('C${i + 1}', _rand(r, min, max)));

/// ---------- BÁSICAS (8 familias x 5) ----------

ChartSpec _line(int i) {
  final r = Random(i);
  final data = _series(r, 6 + (i % 4));
  return ChartSpec(
    title: 'Línea #${i + 1}',
    description: 'SfCartesianChart con LineSeries.',
    level: ChartLevel.basica,
    builder: (_) => SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      series: <CartesianSeries<_Point, String>>[
        LineSeries<_Point, String>(
          dataSource: data,
          xValueMapper: (p, _) => p.x,
          yValueMapper: (p, _) => p.y,
          color: _c(i),
          markerSettings: const MarkerSettings(isVisible: true),
        ),
      ],
    ),
  );
}

ChartSpec _spline(int i) {
  final r = Random(i + 100);
  final data = _series(r, 7 + (i % 3));
  return ChartSpec(
    title: 'Spline #${i + 1}',
    description: 'Curva suavizada con SplineSeries.',
    level: ChartLevel.basica,
    builder: (_) => SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      series: <CartesianSeries<_Point, String>>[
        SplineSeries<_Point, String>(
          dataSource: data,
          xValueMapper: (p, _) => p.x,
          yValueMapper: (p, _) => p.y,
          color: _c(i + 1),
        ),
      ],
    ),
  );
}

ChartSpec _column(int i) {
  final r = Random(i + 200);
  final data = _series(r, 4 + (i % 5));
  return ChartSpec(
    title: 'Columnas #${i + 1}',
    description: 'ColumnSeries vertical.',
    level: ChartLevel.basica,
    builder: (_) => SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      series: <CartesianSeries<_Point, String>>[
        ColumnSeries<_Point, String>(
          dataSource: data,
          xValueMapper: (p, _) => p.x,
          yValueMapper: (p, _) => p.y,
          color: _c(i + 2),
        ),
      ],
    ),
  );
}

ChartSpec _bar(int i) {
  final r = Random(i + 300);
  final data = _series(r, 4 + (i % 4));
  return ChartSpec(
    title: 'Barras horizontales #${i + 1}',
    description: 'BarSeries (horizontal).',
    level: ChartLevel.basica,
    builder: (_) => SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      series: <CartesianSeries<_Point, String>>[
        BarSeries<_Point, String>(
          dataSource: data,
          xValueMapper: (p, _) => p.x,
          yValueMapper: (p, _) => p.y,
          color: _c(i + 3),
        ),
      ],
    ),
  );
}

ChartSpec _area(int i) {
  final r = Random(i + 400);
  final data = _series(r, 6 + (i % 3));
  return ChartSpec(
    title: 'Área #${i + 1}',
    description: 'AreaSeries con relleno.',
    level: ChartLevel.basica,
    builder: (_) => SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      series: <CartesianSeries<_Point, String>>[
        AreaSeries<_Point, String>(
          dataSource: data,
          xValueMapper: (p, _) => p.x,
          yValueMapper: (p, _) => p.y,
          color: _c(i + 4).withOpacity(0.6),
          borderColor: _c(i + 4),
          borderWidth: 2,
        ),
      ],
    ),
  );
}

ChartSpec _stepLine(int i) {
  final r = Random(i + 500);
  final data = _series(r, 6 + (i % 3));
  return ChartSpec(
    title: 'Escalonada #${i + 1}',
    description: 'StepLineSeries.',
    level: ChartLevel.basica,
    builder: (_) => SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      series: <CartesianSeries<_Point, String>>[
        StepLineSeries<_Point, String>(
          dataSource: data,
          xValueMapper: (p, _) => p.x,
          yValueMapper: (p, _) => p.y,
          color: _c(i + 5),
        ),
      ],
    ),
  );
}

ChartSpec _scatter(int i) {
  final r = Random(i + 600);
  final data = _series(r, 10 + (i % 10));
  return ChartSpec(
    title: 'Dispersión #${i + 1}',
    description: 'ScatterSeries.',
    level: ChartLevel.basica,
    builder: (_) => SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      series: <CartesianSeries<_Point, String>>[
        ScatterSeries<_Point, String>(
          dataSource: data,
          xValueMapper: (p, _) => p.x,
          yValueMapper: (p, _) => p.y,
          color: _c(i + 6),
        ),
      ],
    ),
  );
}

ChartSpec _stackedColumn(int i) {
  final r = Random(i + 700);
  final n = 4 + (i % 4);
  final a = _series(r, n);
  final b = _series(r, n);
  return ChartSpec(
    title: 'Columnas apiladas #${i + 1}',
    description: '2 series en StackedColumnSeries.',
    level: ChartLevel.basica,
    builder: (_) => SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      series: <CartesianSeries<_Point, String>>[
        StackedColumnSeries<_Point, String>(
          dataSource: a,
          xValueMapper: (p, _) => p.x,
          yValueMapper: (p, _) => p.y,
          color: _c(i),
        ),
        StackedColumnSeries<_Point, String>(
          dataSource: b,
          xValueMapper: (p, _) => p.x,
          yValueMapper: (p, _) => p.y,
          color: _c(i + 1),
        ),
      ],
    ),
  );
}

final List<ChartSpec Function(int)> _basicFamilies = [
  _line,
  _spline,
  _column,
  _bar,
  _area,
  _stepLine,
  _scatter,
  _stackedColumn,
];

/// ---------- AVANZADAS (5 familias x 5) ----------

ChartSpec _doughnutLegend(int i) {
  final r = Random(i + 1000);
  final n = 3 + (i % 4);
  final data = _series(r, n, min: 10, max: 60);
  return ChartSpec(
    title: 'Doughnut interactivo #${i + 1}',
    description: 'Leyenda + tooltip + explode al tocar.',
    level: ChartLevel.avanzada,
    builder: (_) => SfCircularChart(
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <CircularSeries<_Point, String>>[
        DoughnutSeries<_Point, String>(
          dataSource: data,
          xValueMapper: (p, _) => p.x,
          yValueMapper: (p, _) => p.y,
          pointColorMapper: (p, idx) => _c(i + idx),
          explode: true,
          explodeIndex: 0,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        ),
      ],
    ),
  );
}

ChartSpec _pyramid(int i) {
  final r = Random(i + 1100);
  final n = 4 + (i % 3);
  final data = _series(r, n, min: 20, max: 100)
    ..sort((a, b) => b.y.compareTo(a.y));
  return ChartSpec(
    title: 'Pirámide #${i + 1}',
    description: 'SfPyramidChart, embudo de conversión invertido.',
    level: ChartLevel.avanzada,
    builder: (_) => SfPyramidChart(
      legend: Legend(isVisible: true),
      series: PyramidSeries<_Point, String>(
        dataSource: data,
        xValueMapper: (p, _) => p.x,
        yValueMapper: (p, _) => p.y,
        pointColorMapper: (p, idx) => _c(i + idx),
        dataLabelSettings: const DataLabelSettings(isVisible: true),
      ),
    ),
  );
}

ChartSpec _funnel(int i) {
  final r = Random(i + 1200);
  final n = 4 + (i % 3);
  final data = _series(r, n, min: 20, max: 100)
    ..sort((a, b) => b.y.compareTo(a.y));
  return ChartSpec(
    title: 'Embudo #${i + 1}',
    description: 'SfFunnelChart de conversión.',
    level: ChartLevel.avanzada,
    builder: (_) => SfFunnelChart(
      legend: Legend(isVisible: true),
      series: FunnelSeries<_Point, String>(
        dataSource: data,
        xValueMapper: (p, _) => p.x,
        yValueMapper: (p, _) => p.y,
        pointColorMapper: (p, idx) => _c(i + idx + 2),
        dataLabelSettings: const DataLabelSettings(isVisible: true),
      ),
    ),
  );
}

ChartSpec _dualAxisCombo(int i) {
  final r = Random(i + 1300);
  final n = 5 + (i % 3);
  final colData = _series(r, n, min: 20, max: 90);
  final lineData = _series(r, n, min: 0, max: 10);
  return ChartSpec(
    title: 'Combo columnas + línea #${i + 1}',
    description: 'Dos series (Column + Line) con trackball interactivo.',
    level: ChartLevel.avanzada,
    builder: (_) => SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      trackballBehavior: TrackballBehavior(enable: true),
      series: <CartesianSeries<_Point, String>>[
        ColumnSeries<_Point, String>(
          dataSource: colData,
          xValueMapper: (p, _) => p.x,
          yValueMapper: (p, _) => p.y,
          color: _c(i).withOpacity(0.7),
        ),
        LineSeries<_Point, String>(
          dataSource: lineData,
          xValueMapper: (p, _) => p.x,
          yValueMapper: (p, _) => p.y,
          color: _c(i + 3),
          width: 3,
        ),
      ],
    ),
  );
}

ChartSpec _stackedAreaZoom(int i) {
  final r = Random(i + 1400);
  final n = 6 + (i % 4);
  final a = _series(r, n, min: 5, max: 40);
  final b = _series(r, n, min: 5, max: 40);
  final c = _series(r, n, min: 5, max: 40);
  return ChartSpec(
    title: 'Área apilada + zoom #${i + 1}',
    description: '3 series StackedAreaSeries con zoom/pan habilitado.',
    level: ChartLevel.avanzada,
    builder: (_) => SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      zoomPanBehavior: ZoomPanBehavior(enablePinching: true, enablePanning: true),
      series: <CartesianSeries<_Point, String>>[
        StackedAreaSeries<_Point, String>(dataSource: a, xValueMapper: (p, _) => p.x, yValueMapper: (p, _) => p.y, color: _c(i).withOpacity(0.7)),
        StackedAreaSeries<_Point, String>(dataSource: b, xValueMapper: (p, _) => p.x, yValueMapper: (p, _) => p.y, color: _c(i + 1).withOpacity(0.7)),
        StackedAreaSeries<_Point, String>(dataSource: c, xValueMapper: (p, _) => p.x, yValueMapper: (p, _) => p.y, color: _c(i + 2).withOpacity(0.7)),
      ],
    ),
  );
}

final List<ChartSpec Function(int)> _advancedFamilies = [
  _doughnutLegend,
  _pyramid,
  _funnel,
  _dualAxisCombo,
  _stackedAreaZoom,
];

List<ChartSpec> buildSyncfusionSpecs() {
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
