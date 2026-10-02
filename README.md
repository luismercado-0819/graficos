# Taller: Gráficos en Flutter

## Cómo correrlo
```bash
flutter pub get
flutter run
```
(No pude compilarlo aquí porque este entorno no tiene acceso a pub.dev ni al SDK de Flutter — pruébalo en tu máquina y si algo de la API de una versión de librería cambió, lo ajustamos.)

## Estado actual
- ✅ **fl_chart**: 40 básicas + 25 avanzadas
- ✅ **syncfusion_flutter_charts**: 40 básicas + 25 avanzadas
- ✅ **graphic**: 40 básicas + 25 avanzadas
- ✅ **community_charts_flutter**: 40 básicas + 25 avanzadas (reemplaza a `mp_chart`, que no soporta null-safety y choca con Dart moderno)

## Cómo está armado
Cada gráfica es un `ChartSpec` (título, descripción, nivel, y un builder que arma el widget).
En `lib/data/fl_chart_specs.dart` hay "familias" de gráficas (línea, barras, pie, radar, scatter...)
y cada familia se instancia 5 veces con datos/tamaños/colores distintos → variedad real sin
duplicar código a mano. Para agregar otra librería: crear `lib/data/<libreria>_specs.dart` con
la misma función `buildXSpecs() -> List<ChartSpec>` y un tile más en `home_screen.dart`.

## Entregables del taller (recuerda subirlos)
- [ ] PDF con nombres del grupo
- [ ] Link a código fuente en GitHub
- [ ] Link a video en YouTube (demo corriendo)
