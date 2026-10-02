import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(const TallerApp());

class TallerApp extends StatelessWidget {
  const TallerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Oculta la marca DEBUG
      title: 'Taller Gráficos Flutter',
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}