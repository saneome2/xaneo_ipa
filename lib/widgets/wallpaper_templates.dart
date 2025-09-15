import 'package:flutter/material.dart';

// Базовый шаблон обоев
abstract class WallpaperTemplate extends StatelessWidget {
  final bool isDarkTheme;
  
  const WallpaperTemplate({
    super.key,
    required this.isDarkTheme,
  });
}

// Однотонные обои
class SolidWallpaper extends WallpaperTemplate {
  final Color color;

  const SolidWallpaper({
    super.key,
    required super.isDarkTheme,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
      ),
    );
  }
}

// Градиентные обои
class GradientWallpaper extends WallpaperTemplate {
  final List<Color> colors;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;

  const GradientWallpaper({
    super.key,
    required super.isDarkTheme,
    required this.colors,
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: begin,
          end: end,
        ),
      ),
    );
  }
}

// Обои с паттерном точек
class DottedWallpaper extends WallpaperTemplate {
  final Color backgroundColor;
  final Color dotColor;
  final double dotSize;
  final double spacing;

  const DottedWallpaper({
    super.key,
    required super.isDarkTheme,
    required this.backgroundColor,
    required this.dotColor,
    this.dotSize = 2.0,
    this.spacing = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: CustomPaint(
        painter: DottedPatternPainter(
          dotColor: dotColor,
          dotSize: dotSize,
          spacing: spacing,
        ),
      ),
    );
  }
}

// Обои с геометрическим паттерном
class GeometricWallpaper extends WallpaperTemplate {
  final Color backgroundColor;
  final Color patternColor;
  final double opacity;

  const GeometricWallpaper({
    super.key,
    required super.isDarkTheme,
    required this.backgroundColor,
    required this.patternColor,
    this.opacity = 0.1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: CustomPaint(
        painter: GeometricPatternPainter(
          patternColor: patternColor.withOpacity(opacity),
        ),
      ),
    );
  }
}

// Кастомные паинтеры для паттернов
class DottedPatternPainter extends CustomPainter {
  final Color dotColor;
  final double dotSize;
  final double spacing;

  DottedPatternPainter({
    required this.dotColor,
    required this.dotSize,
    required this.spacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = dotColor
      ..style = PaintingStyle.fill;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(
          Offset(x, y),
          dotSize / 2,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class GeometricPatternPainter extends CustomPainter {
  final Color patternColor;

  GeometricPatternPainter({
    required this.patternColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = patternColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    const spacing = 40.0;
    
    // Рисуем диагональные линии
    for (double i = -size.height; i < size.width; i += spacing) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + size.height, size.height),
        paint,
      );
    }
    
    for (double i = spacing; i < size.width + size.height; i += spacing) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i - size.height, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Предустановленные обои
class WallpaperPresets {
  static List<WallpaperTemplate> getDarkWallpapers() {
    return [
      // Чёрные обои
      const SolidWallpaper(
        isDarkTheme: true,
        color: Colors.black,
      ),
      // Тёмно-серые обои
      const SolidWallpaper(
        isDarkTheme: true,
        color: Color(0xFF1C1C1E),
      ),
      // Градиент от тёмно-синего к чёрному
      const GradientWallpaper(
        isDarkTheme: true,
        colors: [
          Color(0xFF000051),
          Colors.black,
        ],
      ),
      // Градиент от тёмно-фиолетового к чёрному
      const GradientWallpaper(
        isDarkTheme: true,
        colors: [
          Color(0xFF2D1B69),
          Colors.black,
        ],
      ),
      // Обои с точками
      const DottedWallpaper(
        isDarkTheme: true,
        backgroundColor: Colors.black,
        dotColor: Color(0xFF333333),
        dotSize: 1.5,
        spacing: 25.0,
      ),
      // Геометрические обои
      const GeometricWallpaper(
        isDarkTheme: true,
        backgroundColor: Colors.black,
        patternColor: Color(0xFF333333),
        opacity: 0.15,
      ),
    ];
  }

  static List<WallpaperTemplate> getLightWallpapers() {
    return [
      // Белые обои
      const SolidWallpaper(
        isDarkTheme: false,
        color: Colors.white,
      ),
      // Светло-серые обои
      const SolidWallpaper(
        isDarkTheme: false,
        color: Color(0xFFF2F2F7),
      ),
      // Градиент от голубого к белому
      const GradientWallpaper(
        isDarkTheme: false,
        colors: [
          Color(0xFFE3F2FD),
          Colors.white,
        ],
      ),
      // Градиент от розового к белому
      const GradientWallpaper(
        isDarkTheme: false,
        colors: [
          Color(0xFFFCE4EC),
          Colors.white,
        ],
      ),
      // Обои с точками
      const DottedWallpaper(
        isDarkTheme: false,
        backgroundColor: Colors.white,
        dotColor: Color(0xFFE0E0E0),
        dotSize: 1.5,
        spacing: 25.0,
      ),
      // Геометрические обои
      const GeometricWallpaper(
        isDarkTheme: false,
        backgroundColor: Colors.white,
        patternColor: Color(0xFFE0E0E0),
        opacity: 0.3,
      ),
    ];
  }

  static List<WallpaperTemplate> getAllWallpapers(bool isDarkTheme) {
    return isDarkTheme ? getDarkWallpapers() : getLightWallpapers();
  }
}
