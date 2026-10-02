import 'package:flutter/material.dart';

enum ChartLevel { basica, avanzada }

/// Representa UNA gráfica dentro de la galería de una librería.
/// El [builder] construye el widget de la gráfica ya armado (con su data).
class ChartSpec {
  final String title;
  final String description;
  final ChartLevel level;
  final Widget Function(BuildContext context) builder;

  const ChartSpec({
    required this.title,
    required this.description,
    required this.level,
    required this.builder,
  });
}
