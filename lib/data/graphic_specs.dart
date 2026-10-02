import 'dart:math';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
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

List<Map<String, dynamic>> _catData(Random r, int n, {String cat = 'cat', String val = 'val'}) =>
    List.generate(n, (i) => {cat: 'C${i + 1}', val: _rand(r, 10, 100)});

List<Map<String, dynamic>> _groupedData(Random r, int n, int groups) => [
      for (var g = 0; g < groups; g++)
        for (var i = 0; i < n; i++) {'cat': 'C${i + 1}', 'grupo': 'G${g + 1}', 'val': _rand(r, 10, 90)},
    ];

/// ---------- BÁSICAS (8 familias x 5) ----------

ChartSpec _interval(int i) {
  final r = Random(i);
  final data = _catData(r, 4 + (i % 5));
  return ChartSpec(
    title: 'IntervalMark (barras) #${i + 1}',
    description: 'Barras verticales básicas con Grammar of Graphics.',
    level: ChartLevel.basica,
    builder: (_) => Chart(
      data: data,
      variables: {
        'cat': Variable(accessor: (Map d) => d['cat'] as String),
        'val': Variable(accessor: (Map d) => d['val'] as num),
      },
      marks: [IntervalMark(color: ColorEncode(value: _c(i)))],
      axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
    ),
  );
}

ChartSpec _line(int i) {
  final r = Random(i + 100);
  final data = _catData(r, 6 + (i % 4));
  return ChartSpec(
    title: 'LineMark #${i + 1}',
    description: 'Línea con LineMark.',
    level: ChartLevel.basica,
    builder: (_) => Chart(
      data: data,
      variables: {
        'cat': Variable(accessor: (Map d) => d['cat'] as String),
        'val': Variable(accessor: (Map d) => d['val'] as num),
      },
      marks: [LineMark(color: ColorEncode(value: _c(i + 1)), shape: ShapeEncode(value: BasicLineShape(smooth: i.isEven)))],
      axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
    ),
  );
}

ChartSpec _area(int i) {
  final r = Random(i + 200);
  final data = _catData(r, 6 + (i % 4));
  return ChartSpec(
    title: 'AreaMark #${i + 1}',
    description: 'Área con relleno degradado.',
    level: ChartLevel.basica,
    builder: (_) => Chart(
      data: data,
      variables: {
        'cat': Variable(accessor: (Map d) => d['cat'] as String),
        'val': Variable(accessor: (Map d) => d['val'] as num),
      },
      marks: [AreaMark(color: ColorEncode(value: _c(i + 2).withOpacity(0.6)))],
      axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
    ),
  );
}

ChartSpec _point(int i) {
  final r = Random(i + 300);
  final data = _catData(r, 10 + (i % 10));
  return ChartSpec(
    title: 'PointMark (scatter) #${i + 1}',
    description: 'Dispersión de puntos.',
    level: ChartLevel.basica,
    builder: (_) => Chart(
      data: data,
      variables: {
        'cat': Variable(accessor: (Map d) => d['cat'] as String),
        'val': Variable(accessor: (Map d) => d['val'] as num),
      },
      marks: [PointMark(color: ColorEncode(value: _c(i + 3)))],
      axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
    ),
  );
}

ChartSpec _groupedInterval(int i) {
  final r = Random(i + 400);
  final data = _groupedData(r, 4 + (i % 3), 2);
  return ChartSpec(
    title: 'Barras agrupadas #${i + 1}',
    description: 'IntervalMark agrupado por variable "grupo".',
    level: ChartLevel.basica,
    builder: (_) => Chart(
      data: data,
      variables: {
        'cat': Variable(accessor: (Map d) => d['cat'] as String),
        'grupo': Variable(accessor: (Map d) => d['grupo'] as String),
        'val': Variable(accessor: (Map d) => d['val'] as num),
      },
      marks: [
        IntervalMark(
          position: Varset('cat') * Varset('val') / Varset('grupo'),
          color: ColorEncode(variable: 'grupo', values: [_c(i), _c(i + 1)]),
          modifiers: [DodgeModifier()],
        ),
      ],
      axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
    ),
  );
}

ChartSpec _stackedInterval(int i) {
  final r = Random(i + 500);
  final data = _groupedData(r, 4 + (i % 3), 3);
  return ChartSpec(
    title: 'Barras apiladas #${i + 1}',
    description: 'IntervalMark apilado (StackModifier).',
    level: ChartLevel.basica,
    builder: (_) => Chart(
      data: data,
      variables: {
        'cat': Variable(accessor: (Map d) => d['cat'] as String),
        'grupo': Variable(accessor: (Map d) => d['grupo'] as String),
        'val': Variable(accessor: (Map d) => d['val'] as num),
      },
      marks: [
        IntervalMark(
          position: Varset('cat') * Varset('val') / Varset('grupo'),
          color: ColorEncode(variable: 'grupo', values: [_c(i), _c(i + 1), _c(i + 2)]),
          modifiers: [StackModifier()],
        ),
      ],
      axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
    ),
  );
}

ChartSpec _pie(int i) {
  final r = Random(i + 600);
  final data = _catData(r, 3 + (i % 4));
  return ChartSpec(
    title: 'Pie (coordenada polar) #${i + 1}',
    description: 'IntervalMark + CoordPolar = pie chart.',
    level: ChartLevel.basica,
    builder: (_) => Chart(
      data: data,
      variables: {
        'cat': Variable(accessor: (Map d) => d['cat'] as String),
        'val': Variable(accessor: (Map d) => d['val'] as num),
      },
      marks: [IntervalMark(position: Varset('val') / Varset('cat'), color: ColorEncode(variable: 'cat', values: List.generate(8, (k) => _c(i + k))))],
      coord: PolarCoord(transposed: true),
    ),
  );
}

ChartSpec _donut(int i) {
  final r = Random(i + 700);
  final data = _catData(r, 3 + (i % 4));
  return ChartSpec(
    title: 'Donut (coordenada polar) #${i + 1}',
    description: 'Igual que pie, con innerRadius.',
    level: ChartLevel.basica,
    builder: (_) => Chart(
      data: data,
      variables: {
        'cat': Variable(accessor: (Map d) => d['cat'] as String),
        'val': Variable(accessor: (Map d) => d['val'] as num),
      },
      marks: [IntervalMark(position: Varset('val') / Varset('cat'), color: ColorEncode(variable: 'cat', values: List.generate(8, (k) => _c(i + k + 2))))],
      coord: PolarCoord(transposed: true),
    ),
  );
}

final List<ChartSpec Function(int)> _basicFamilies = [
  _interval,
  _line,
  _area,
  _point,
  _groupedInterval,
  _stackedInterval,
  _pie,
  _donut,
];

/// ---------- AVANZADAS (5 familias x 5) ----------

ChartSpec _tooltipSelection(int i) {
  final r = Random(i + 1000);
  final data = _catData(r, 7 + (i % 4));
  return ChartSpec(
    title: 'Línea con tooltip + selección #${i + 1}',
    description: 'LineMark + PointMark con selección interactiva y tooltip.',
    level: ChartLevel.avanzada,
    builder: (_) => Chart(
      data: data,
      variables: {
        'cat': Variable(accessor: (Map d) => d['cat'] as String),
        'val': Variable(accessor: (Map d) => d['val'] as num),
      },
      marks: [
        LineMark(color: ColorEncode(value: _c(i))),
        PointMark(
          color: ColorEncode(value: _c(i + 1)),
          size: SizeEncode(value: 6),
        ),
      ],
      axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      selections: {'tap': PointSelection(dim: Dim.x, nearest: true)},
      tooltip: TooltipGuide(),
    ),
  );
}

ChartSpec _groupedLine(int i) {
  final r = Random(i + 1100);
  final data = _groupedData(r, 6 + (i % 3), 3);
  return ChartSpec(
    title: 'Multi-línea agrupada #${i + 1}',
    description: '3 series LineMark diferenciadas por color.',
    level: ChartLevel.avanzada,
    builder: (_) => Chart(
      data: data,
      variables: {
        'cat': Variable(accessor: (Map d) => d['cat'] as String),
        'grupo': Variable(accessor: (Map d) => d['grupo'] as String),
        'val': Variable(accessor: (Map d) => d['val'] as num),
      },
      marks: [
        LineMark(
          position: Varset('cat') * Varset('val') / Varset('grupo'),
          color: ColorEncode(variable: 'grupo', values: [_c(i), _c(i + 1), _c(i + 2)]),
        ),
      ],
      axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
    ),
  );
}

ChartSpec _polygonHeat(int i) {
  final r = Random(i + 1200);
  final rows = 4 + (i % 3);
  final cols = 4 + (i % 3);
  final data = [
    for (var y = 0; y < rows; y++)
      for (var x = 0; x < cols; x++) {'x': 'X$x', 'y': 'Y$y', 'val': _rand(r, 0, 100)},
  ];
  return ChartSpec(
    title: 'Heatmap (PolygonMark) #${i + 1}',
    description: 'Matriz $rows x $cols coloreada por intensidad.',
    level: ChartLevel.avanzada,
    builder: (_) => Chart(
      data: data,
      variables: {
        'x': Variable(accessor: (Map d) => d['x'] as String),
        'y': Variable(accessor: (Map d) => d['y'] as String),
        'val': Variable(accessor: (Map d) => d['val'] as num),
      },
      marks: [
        PolygonMark(
          position: Varset('x') * Varset('y'),
          color: ColorEncode(
            variable: 'val',
            values: [Colors.blue.shade50, _c(i)],
          ),
        ),
      ],
      axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
    ),
  );
}

ChartSpec _sizeEncodedBubble(int i) {
  final r = Random(i + 1300);
  final data = List.generate(10 + (i % 8), (idx) => {
        'cat': 'C${idx + 1}',
        'val': _rand(r, 10, 100),
        'peso': _rand(r, 5, 30),
      });
  return ChartSpec(
    title: 'Burbujas (size encode) #${i + 1}',
    description: 'PointMark con tamaño variable según un 3er valor.',
    level: ChartLevel.avanzada,
    builder: (_) => Chart(
      data: data,
      variables: {
        'cat': Variable(accessor: (Map d) => d['cat'] as String),
        'val': Variable(accessor: (Map d) => d['val'] as num),
        'peso': Variable(accessor: (Map d) => d['peso'] as num),
      },
      marks: [
        PointMark(
          color: ColorEncode(value: _c(i).withOpacity(0.7)),
          size: SizeEncode(variable: 'peso', values: const [4, 20]),
        ),
      ],
      axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
    ),
  );
}

ChartSpec _animatedEntrance(int i) {
  final r = Random(i + 1400);
  final data = _catData(r, 5 + (i % 5));
  return ChartSpec(
    title: 'Barras con animación de entrada #${i + 1}',
    description: 'IntervalMark con transición animada al construirse.',
    level: ChartLevel.avanzada,
    builder: (_) => Chart(
      data: data,
      variables: {
        'cat': Variable(accessor: (Map d) => d['cat'] as String),
        'val': Variable(accessor: (Map d) => d['val'] as num),
      },
      marks: [
        IntervalMark(
          color: ColorEncode(value: _c(i + 4)),
          modifiers: [DodgeModifier()],
        ),
      ],
      axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
    ),
  );
}

final List<ChartSpec Function(int)> _advancedFamilies = [
  _tooltipSelection,
  _groupedLine,
  _polygonHeat,
  _sizeEncodedBubble,
  _animatedEntrance,
];

List<ChartSpec> buildGraphicSpecs() {
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
