import 'package:flutter/material.dart';
import '../models/chart_spec.dart';

/// Pantalla reutilizable: recibe el nombre de la librería y su lista de
/// ChartSpec (40 básicas + 25 avanzadas) y las muestra en tabs + lista.
class ChartGalleryScreen extends StatelessWidget {
  final String libraryName;
  final List<ChartSpec> specs;

  const ChartGalleryScreen({
    super.key,
    required this.libraryName,
    required this.specs,
  });

  @override
  Widget build(BuildContext context) {
    final basicas = specs.where((s) => s.level == ChartLevel.basica).toList();
    final avanzadas = specs.where((s) => s.level == ChartLevel.avanzada).toList();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(libraryName),
          bottom: TabBar(tabs: [
            Tab(text: 'Básicas (${basicas.length})'),
            Tab(text: 'Avanzadas (${avanzadas.length})'),
          ]),
        ),
        body: TabBarView(children: [
          _ChartList(specs: basicas),
          _ChartList(specs: avanzadas),
        ]),
      ),
    );
  }
}

class _ChartList extends StatelessWidget {
  final List<ChartSpec> specs;
  const _ChartList({required this.specs});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: specs.length,
      itemBuilder: (context, index) {
        final spec = specs[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(spec.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(spec.description, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                const SizedBox(height: 12),
                SizedBox(height: 220, child: spec.builder(context)),
              ],
            ),
          ),
        );
      },
    );
  }
}
