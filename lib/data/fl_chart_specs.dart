import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/chart_spec.dart';

// Paleta reutilizable, rotada por índice para que cada gráfica se vea distinta.
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

/// ---------- FAMILIAS BÁSICAS (8 familias x 5 variantes = 40) ----------

ChartSpec _lineSimple(int i) {
  final r = Random(i);
  final points = List.generate(7, (x) => FlSpot(x.toDouble(), _rand(r, 10, 90)));
  return ChartSpec(
    title: 'Línea simple #${i + 1}',
    description: 'Una sola serie, 7 puntos, curva suavizada.',
    level: ChartLevel.basica,
    builder: (_) => LineChart(LineChartData(
      gridData: const FlGridData(show: true),
      titlesData: const FlTitlesData(show: true),
      borderData: FlBorderData(show: true),
      lineBarsData: [
        LineChartBarData(
          spots: points,
          isCurved: true,
          color: _c(i),
          barWidth: 3,
          dotData: const FlDotData(show: true),
        ),
      ],
    )),
  );
}

ChartSpec _lineMulti(int i) {
  final r = Random(i + 100);
  final seriesCount = 2 + (i % 3); // 2,3,4 series
  return ChartSpec(
    title: 'Línea multi-serie #${i + 1}',
    description: '$seriesCount series simultáneas comparadas en el tiempo.',
    level: ChartLevel.basica,
    builder: (_) => LineChart(LineChartData(
      gridData: const FlGridData(show: true),
      lineBarsData: List.generate(seriesCount, (s) {
        return LineChartBarData(
          spots: List.generate(6, (x) => FlSpot(x.toDouble(), _rand(r, 5, 80))),
          isCurved: false,
          color: _c(i + s),
          barWidth: 2,
          dotData: const FlDotData(show: false),
        );
      }),
    )),
  );
}

ChartSpec _barVertical(int i) {
  final r = Random(i + 200);
  final n = 4 + (i % 4); // 4..7 barras
  return ChartSpec(
    title: 'Barras verticales #${i + 1}',
    description: '$n categorías, valores aleatorios.',
    level: ChartLevel.basica,
    builder: (_) => BarChart(BarChartData(
      alignment: BarChartAlignment.spaceAround,
      barGroups: List.generate(n, (x) => BarChartGroupData(x: x, barRods: [
            BarChartRodData(toY: _rand(r, 10, 100), color: _c(i + x), width: 16),
          ])),
    )),
  );
}

ChartSpec _barGrouped(int i) {
  final r = Random(i + 300);
  final groups = 4 + (i % 3);
  return ChartSpec(
    title: 'Barras agrupadas #${i + 1}',
    description: '$groups grupos, 2 series comparadas lado a lado.',
    level: ChartLevel.basica,
    builder: (_) => BarChart(BarChartData(
      barGroups: List.generate(groups, (x) => BarChartGroupData(x: x, barRods: [
            BarChartRodData(toY: _rand(r, 10, 80), color: _c(i), width: 8),
            BarChartRodData(toY: _rand(r, 10, 80), color: _c(i + 1), width: 8),
          ])),
    )),
  );
}

ChartSpec _barStacked(int i) {
  final r = Random(i + 400);
  final groups = 4 + (i % 3);
  return ChartSpec(
    title: 'Barras apiladas #${i + 1}',
    description: '$groups grupos, 3 segmentos apilados por barra.',
    level: ChartLevel.basica,
    builder: (_) => BarChart(BarChartData(
      barGroups: List.generate(groups, (x) {
        final a = _rand(r, 5, 30), b = _rand(r, 5, 30), c = _rand(r, 5, 30);
        return BarChartGroupData(x: x, barRods: [
          BarChartRodData(toY: a + b + c, width: 18, rodStackItems: [
            BarChartRodStackItem(0, a, _c(i)),
            BarChartRodStackItem(a, a + b, _c(i + 1)),
            BarChartRodStackItem(a + b, a + b + c, _c(i + 2)),
          ]),
        ]);
      }),
    )),
  );
}

ChartSpec _pie(int i) {
  final r = Random(i + 500);
  final slices = 3 + (i % 3);
  return ChartSpec(
    title: 'Pie chart #${i + 1}',
    description: '$slices porciones.',
    level: ChartLevel.basica,
    builder: (_) => PieChart(PieChartData(
      sections: List.generate(slices, (s) => PieChartSectionData(
            value: _rand(r, 10, 40),
            color: _c(i + s),
            title: '${s + 1}',
            radius: 70,
          )),
    )),
  );
}

ChartSpec _donut(int i) {
  final r = Random(i + 600);
  final slices = 3 + (i % 4);
  return ChartSpec(
    title: 'Donut chart #${i + 1}',
    description: '$slices porciones con hueco central.',
    level: ChartLevel.basica,
    builder: (_) => PieChart(PieChartData(
      centerSpaceRadius: 40,
      sections: List.generate(slices, (s) => PieChartSectionData(
            value: _rand(r, 10, 40),
            color: _c(i + s + 3),
            title: '',
            radius: 50,
          )),
    )),
  );
}

ChartSpec _scatter(int i) {
  final r = Random(i + 700);
  final n = 10 + (i % 15);
  return ChartSpec(
    title: 'Scatter chart #${i + 1}',
    description: '$n puntos dispersos.',
    level: ChartLevel.basica,
    builder: (_) => ScatterChart(ScatterChartData(
      scatterSpots: List.generate(n, (p) => ScatterSpot(
            _rand(r, 0, 100),
            _rand(r, 0, 100),
            dotPainter: FlDotCirclePainter(radius: 4, color: _c(i + p)),
          )),
    )),
  );
}

final List<ChartSpec Function(int)> _basicFamilies = [
  _lineSimple,
  _lineMulti,
  _barVertical,
  _barGrouped,
  _barStacked,
  _pie,
  _donut,
  _scatter,
];

/// ---------- FAMILIAS AVANZADAS (5 familias x 5 variantes = 25) ----------

ChartSpec _lineAreaThreshold(int i) {
  final r = Random(i + 1000);
  final points = List.generate(8, (x) => FlSpot(x.toDouble(), _rand(r, 20, 90)));
  final threshold = _rand(r, 40, 60);
  return ChartSpec(
    title: 'Línea con área + umbral #${i + 1}',
    description: 'Relleno degradado bajo la curva y línea de umbral horizontal.',
    level: ChartLevel.avanzada,
    builder: (_) => LineChart(LineChartData(
      extraLinesData: ExtraLinesData(horizontalLines: [
        HorizontalLine(y: threshold, color: Colors.redAccent, strokeWidth: 2, dashArray: [6, 4]),
      ]),
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(getTooltipColor: (_) => _c(i).withOpacity(0.85)),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: points,
          isCurved: true,
          color: _c(i),
          barWidth: 3,
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [_c(i).withOpacity(0.4), _c(i).withOpacity(0.0)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    )),
  );
}

ChartSpec _barHybridStackGroup(int i) {
  final r = Random(i + 1100);
  final groups = 4 + (i % 3);
  return ChartSpec(
    title: 'Barras agrupadas + apiladas #${i + 1}',
    description: 'Cada grupo tiene 2 barras, cada una con 2 segmentos apilados.',
    level: ChartLevel.avanzada,
    builder: (_) => BarChart(BarChartData(
      barTouchData: BarTouchData(enabled: true),
      barGroups: List.generate(groups, (x) {
        double a1 = _rand(r, 5, 25), b1 = _rand(r, 5, 25);
        double a2 = _rand(r, 5, 25), b2 = _rand(r, 5, 25);
        return BarChartGroupData(x: x, barRods: [
          BarChartRodData(toY: a1 + b1, width: 10, rodStackItems: [
            BarChartRodStackItem(0, a1, _c(i)),
            BarChartRodStackItem(a1, a1 + b1, _c(i + 1)),
          ]),
          BarChartRodData(toY: a2 + b2, width: 10, rodStackItems: [
            BarChartRodStackItem(0, a2, _c(i + 2)),
            BarChartRodStackItem(a2, a2 + b2, _c(i + 3)),
          ]),
        ]);
      }),
    )),
  );
}

ChartSpec _donutBadges(int i) {
  final r = Random(i + 1200);
  final slices = 3 + (i % 3);
  return ChartSpec(
    title: 'Donut con badges + centro #${i + 1}',
    description: 'Cada porción muestra un ícono/badge y texto central animado.',
    level: ChartLevel.avanzada,
    builder: (_) => Stack(alignment: Alignment.center, children: [
      PieChart(PieChartData(
        centerSpaceRadius: 45,
        sectionsSpace: 3,
        sections: List.generate(slices, (s) => PieChartSectionData(
              value: _rand(r, 10, 40),
              color: _c(i + s),
              radius: 55,
              title: '',
              badgeWidget: Icon(Icons.star, size: 14, color: _c(i + s + 2)),
              badgePositionPercentageOffset: 1.2,
            )),
      )),
      const Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
    ]),
  );
}

ChartSpec _radar(int i) {
  final r = Random(i + 1300);
  final axes = 5 + (i % 3);
  return ChartSpec(
    title: 'Radar chart #${i + 1}',
    description: '$axes ejes, 2 datasets comparados.',
    level: ChartLevel.avanzada,
    builder: (_) => RadarChart(RadarChartData(
      radarShape: RadarShape.polygon,
      dataSets: [
        RadarDataSet(
          fillColor: _c(i).withOpacity(0.3),
          borderColor: _c(i),
          dataEntries: List.generate(axes, (_) => RadarEntry(value: _rand(r, 20, 100))),
        ),
        RadarDataSet(
          fillColor: _c(i + 1).withOpacity(0.3),
          borderColor: _c(i + 1),
          dataEntries: List.generate(axes, (_) => RadarEntry(value: _rand(r, 20, 100))),
        ),
      ],
    )),
  );
}

ChartSpec _scatterBubble(int i) {
  final r = Random(i + 1400);
  final n = 12 + (i % 10);
  return ChartSpec(
    title: 'Scatter tipo burbuja #${i + 1}',
    description: '$n puntos con radio variable según un 3er valor (tooltip interactivo).',
    level: ChartLevel.avanzada,
    builder: (_) => ScatterChart(ScatterChartData(
      scatterTouchData: ScatterTouchData(enabled: true),
      scatterSpots: List.generate(n, (p) {
        final radius = _rand(r, 3, 14);
        return ScatterSpot(
          _rand(r, 0, 100),
          _rand(r, 0, 100),
          dotPainter: FlDotCirclePainter(radius: radius, color: _c(i + p).withOpacity(0.7)),
        );
      }),
    )),
  );
}

final List<ChartSpec Function(int)> _advancedFamilies = [
  _lineAreaThreshold,
  _barHybridStackGroup,
  _donutBadges,
  _radar,
  _scatterBubble,
];

/// Genera las 40 básicas (8 familias x 5) y 25 avanzadas (5 familias x 5).
List<ChartSpec> buildFlChartSpecs() {
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
