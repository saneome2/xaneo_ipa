import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:ui' as ui;
import '../l10n/app_localizations.dart';

class AvatarCropper extends StatefulWidget {
  final File imageFile;
  final Function(File) onCropped;
  final VoidCallback onCancel;

  const AvatarCropper({
    super.key,
    required this.imageFile,
    required this.onCropped,
    required this.onCancel,
  });

  @override
  State<AvatarCropper> createState() => _AvatarCropperState();
}

class _AvatarCropperState extends State<AvatarCropper> {
  bool _imageLoaded = false;
  double _offsetX = 0.0; // Смещение по горизонтали
  double _offsetY = 0.0; // Смещение по вертикали
  double _scale = 1.0;   // Масштаб изображения
  double _baseScale = 1.0; // Базовый масштаб для расчетов
  double _autoScale = 1.0; // Автоматический масштаб для сброса
  bool _isFlippedHorizontally = false; // Горизонтальное отражение
  int _rotationDegrees = 0; // Поворот в градусах: 0, 90, 180, 270
  bool _isPortraitImage = false; // Портретная ориентация изображения (9:16)
  double _displayHeight = 0.0; // Высота отображения изображения

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  /// Загружаем изображение для отображения
  Future<void> _loadImage() async {
    try {
      // Загружаем изображение для получения его размеров
      final imageStream = widget.imageFile.readAsBytesSync();
      final codec = await ui.instantiateImageCodec(imageStream);
      final frame = await codec.getNextFrame();
      final image = frame.image;
      
      setState(() {
        _imageLoaded = true;
        
        // Вычисляем автоматический масштаб
        // Диаметр круга = ширина экрана
        // Нужно чтобы высота изображения = диаметру круга
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final screenWidth = MediaQuery.of(context).size.width;
          final screenHeight = MediaQuery.of(context).size.height;
          
          // Получаем размеры изображения
          final imageWidth = image.width.toDouble();
          final imageHeight = image.height.toDouble();
          final imageAspectRatio = imageWidth / imageHeight;
          
          // Определяем ориентацию изображения
          _isPortraitImage = imageAspectRatio < 1.0; // Высота больше ширины
          
          // Вычисляем как изображение будет отображаться с BoxFit.contain
          double displayWidth, displayHeight;
          final screenAspectRatio = screenWidth / screenHeight;
          
          if (imageAspectRatio > screenAspectRatio) {
            // Изображение шире экрана - ограничиваем по ширине
            displayWidth = screenWidth;
            displayHeight = displayWidth / imageAspectRatio;
          } else {
            // Изображение выше экрана - ограничиваем по высоте  
            displayHeight = screenHeight;
            displayWidth = displayHeight * imageAspectRatio;
          }
          
          // Автоматический масштаб зависит от ориентации изображения
          double autoScale;
          if (_isPortraitImage) {
            // Для портретных изображений: диаметр_круга / ширина_отображения
            autoScale = screenWidth / displayWidth;
          } else {
            // Для ландшафтных изображений: диаметр_круга / высота_отображения
            autoScale = screenWidth / displayHeight;
          }
          
          setState(() {
            _autoScale = autoScale.clamp(1.0, 3.0);
            _scale = _autoScale;
            _baseScale = _scale;
            _displayHeight = displayHeight;
          });
        });
      });
    } catch (e) {
      print('❌ Ошибка загрузки изображения: $e');
      setState(() {
        _imageLoaded = true;
      });
    }
  }
  
  /// Обрезаем изображение по круглой области
  Future<void> _cropImage() async {
    try {
      // Загружаем изображение
      final imageStream = widget.imageFile.readAsBytesSync();
      final codec = await ui.instantiateImageCodec(imageStream);
      final frame = await codec.getNextFrame();
      final originalImage = frame.image;
      
      // Получаем размеры экрана
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      
      // Диаметр круга = ширина экрана
      final circleDiameter = screenWidth;
      
      // Размеры оригинального изображения
      final originalWidth = originalImage.width.toDouble();
      final originalHeight = originalImage.height.toDouble();
      
      // Вычисляем размеры отображения изображения БЕЗ поворота
      final imageAspectRatio = originalWidth / originalHeight;
      final screenAspectRatio = screenWidth / screenHeight;
      
      double displayWidth, displayHeight;
      if (imageAspectRatio > screenAspectRatio) {
        displayWidth = screenWidth;
        displayHeight = displayWidth / imageAspectRatio;
      } else {
        displayHeight = screenHeight;
        displayWidth = displayHeight * imageAspectRatio;
      }
      
      // Создаем холст для результата (размером с круг)
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);
      
      // Создаем круглую маску
      final clipPath = Path()
        ..addOval(Rect.fromLTWH(0, 0, circleDiameter, circleDiameter));
      canvas.clipPath(clipPath);
      
      // Применяем все трансформации в том же порядке, что и при отображении
      canvas.save();
      
      // 1. Переносим в центр круга
      canvas.translate(circleDiameter / 2, circleDiameter / 2);
      
      // 2. Применяем смещения (как при отображении)
      canvas.translate(_offsetX, _offsetY);
      
      // 3. Применяем поворот
      if (_rotationDegrees != 0) {
        canvas.rotate(_rotationDegrees * 3.14159 / 180);
      }
      
      // 4. Применяем масштабирование и отражение
      canvas.scale(_isFlippedHorizontally ? -_scale : _scale, _scale);
      
      // 5. Позиционируем изображение относительно центра
      canvas.translate(-displayWidth / 2, -displayHeight / 2);
      
      // Рисуем изображение в его исходном размере
      canvas.drawImageRect(
        originalImage,
        Rect.fromLTWH(0, 0, originalWidth, originalHeight),
        Rect.fromLTWH(0, 0, displayWidth, displayHeight),
        Paint(),
      );
      
      canvas.restore();
      
      // Создаем финальное изображение
      final picture = recorder.endRecording();
      final croppedImage = await picture.toImage(
        circleDiameter.toInt(), 
        circleDiameter.toInt()
      );
      
      // Конвертируем в байты
      final byteData = await croppedImage.toByteData(format: ui.ImageByteFormat.png);
      final bytes = byteData!.buffer.asUint8List();
      
      // Сохраняем
      final tempDir = Directory.systemTemp;
      final tempFile = File('${tempDir.path}/cropped_avatar_${DateTime.now().millisecondsSinceEpoch}.png');
      await tempFile.writeAsBytes(bytes);
      
      widget.onCropped(tempFile);
      
    } catch (e) {
      print('❌ Ошибка обрезки изображения: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ошибка при обрезке изображения'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: widget.onCancel,
        ),
        title: Text(
          l10n.avatarCropperTitle,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Inter',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          // Кнопка сброса позиции и масштаба
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              setState(() {
                _offsetX = 0.0;
                _offsetY = 0.0;
                _scale = _autoScale;
                _baseScale = _autoScale;
                _isFlippedHorizontally = false;
                _rotationDegrees = 0; // Сбрасываем поворот
              });
            },
            tooltip: 'Сбросить к автомасштабу',
          ),
          TextButton(
            onPressed: _imageLoaded ? _cropImage : null,
            child: Text(
              l10n.doneButton,
              style: TextStyle(
                color: _imageLoaded ? Colors.white : Colors.grey,
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: _imageLoaded
          ? Column(
              children: [
                // Основная область просмотра изображения
                Expanded(
                  child: GestureDetector(
                    onScaleStart: (details) {
                      // Запоминаем базовый масштаб в начале жеста
                      _baseScale = _scale;
                    },
                    onScaleUpdate: (details) {
                      setState(() {
                        // Максимум = автомасштаб × 3.0 (то есть в UI будет от 100% до 300%)
                        // Если автомасштаб 2.22 (222%), то максимум = 2.22 × 3 = 6.66 (в UI 300%)
                        _scale = (_baseScale * details.scale).clamp(_autoScale, _autoScale * 3.0);
                        
                        // Перемещение по X и Y с ограничениями по краям изображения
                        double newOffsetX = _offsetX + details.focalPointDelta.dx;
                        double newOffsetY = _offsetY + details.focalPointDelta.dy;
                        
                        // НЕ поворачиваем вектор движения - свайпы должны быть естественными
                        // Пользователь свайпает вправо -> изображение движется вправо (независимо от поворота)
                        
                        // Если масштаб больше автомасштаба, разрешаем перемещение по обеим осям
                        if (_scale > _autoScale) {
                          // Получаем размеры экрана
                          final screenWidth = MediaQuery.of(context).size.width;
                          
                          // Вычисляем, насколько изображение увеличено относительно автомасштаба
                          final scaleRatio = _scale / _autoScale;
                          
                          // Вычисляем ограничения в зависимости от ориентации изображения
                          double normalMaxOffsetX, normalMaxOffsetY;
                          final circleDiameter = screenWidth;
                          
                          if (_isPortraitImage) {
                            // Портретное изображение: при автомасштабе подогнано по ширине
                            // X: можно двигать только если увеличили больше автомасштаба
                            final scaledImageWidth = screenWidth * _scale;
                            normalMaxOffsetX = (_scale > _autoScale) ? (scaledImageWidth - screenWidth) / 2 : 0.0;
                            
                            // Y: вычисляем ограничения используя реальные размеры отображения
                            // _displayHeight уже содержит правильную высоту отображения изображения
                            final scaledDisplayHeight = _displayHeight * _scale;
                            // Максимальное смещение = (высота_отображения - диаметр_круга) / 2
                            normalMaxOffsetY = (scaledDisplayHeight - circleDiameter) / 2;
                          } else {
                            // Ландшафтное изображение: при автомасштабе подогнано по высоте
                            normalMaxOffsetX = (screenWidth * _scale - screenWidth) / 2;
                            final currentImageHeight = circleDiameter * scaleRatio;
                            normalMaxOffsetY = (currentImageHeight - circleDiameter) / 2;
                          }
                          
                          // Применяем ограничения в зависимости от поворота
                          if (_rotationDegrees == 90 || _rotationDegrees == 270) {
                            // При повороте на 90/270° оси меняются местами
                            newOffsetX = newOffsetX.clamp(-normalMaxOffsetY, normalMaxOffsetY); // X получает ограничения Y
                            newOffsetY = newOffsetY.clamp(-normalMaxOffsetX, normalMaxOffsetX); // Y получает ограничения X
                          } else {
                            // Обычная ориентация (0° или 180°)
                            newOffsetX = newOffsetX.clamp(-normalMaxOffsetX, normalMaxOffsetX);
                            newOffsetY = newOffsetY.clamp(-normalMaxOffsetY, normalMaxOffsetY);
                          }
                        } else if (_scale > 1.0) {
                          // При автомасштабе > 1.0 разрешаем только перемещение по основной оси
                          final screenWidth = MediaQuery.of(context).size.width;
                          
                          // Вычисляем ограничения в зависимости от ориентации изображения
                          double normalMaxOffsetX;
                          
                          if (_isPortraitImage) {
                            // Портретное изображение: X с ограничениями, Y с ограничениями
                            final screenWidth = MediaQuery.of(context).size.width;
                            
                            // X: можно двигать только если увеличили больше автомасштаба
                            double normalMaxOffsetX = 0.0;
                            if (_scale > _autoScale) {
                              final scaledImageWidth = screenWidth * _scale;
                              normalMaxOffsetX = (scaledImageWidth - screenWidth) / 2;
                            }
                            
                            // Y: ограничения чтобы кружочек не выходил за края изображения
                            final scaledDisplayHeight = _displayHeight * _scale;
                            final normalMaxOffsetY = (scaledDisplayHeight - screenWidth) / 2; // Круг = ширина экрана
                            
                            if (_rotationDegrees == 90 || _rotationDegrees == 270) {
                              // При повороте оси меняются: Y получает ограничения X, X получает ограничения Y
                              newOffsetY = newOffsetY.clamp(-normalMaxOffsetX, normalMaxOffsetX);
                              newOffsetX = newOffsetX.clamp(-normalMaxOffsetY, normalMaxOffsetY);
                            } else {
                              // Обычная ориентация: X с ограничениями, Y с ограничениями
                              newOffsetX = newOffsetX.clamp(-normalMaxOffsetX, normalMaxOffsetX);
                              newOffsetY = newOffsetY.clamp(-normalMaxOffsetY, normalMaxOffsetY);
                            }
                          } else {
                            // Ландшафтное изображение: стандартная логика
                            normalMaxOffsetX = (screenWidth * _scale - screenWidth) / 2;
                            
                            if (_rotationDegrees == 90 || _rotationDegrees == 270) {
                              newOffsetY = newOffsetY.clamp(-normalMaxOffsetX, normalMaxOffsetX);
                              newOffsetX = 0.0;
                            } else {
                              newOffsetX = newOffsetX.clamp(-normalMaxOffsetX, normalMaxOffsetX);
                              newOffsetY = 0.0;
                            }
                          }
                        } else {
                          // При масштабе автомасштаба (100%) логика зависит от ориентации
                          
                          if (_isPortraitImage) {
                            // Портретное изображение: X заблокирован при автомасштабе, Y с ограничениями
                            final screenWidth = MediaQuery.of(context).size.width;
                            
                            // Y: ограничения чтобы кружочек не выходил за края изображения
                            final scaledDisplayHeight = _displayHeight * _scale;
                            final maxOffsetY = (scaledDisplayHeight - screenWidth) / 2; // Круг = ширина экрана
                            
                            if (_rotationDegrees == 90 || _rotationDegrees == 270) {
                              // При повороте: Y заблокирован, X с ограничениями
                              newOffsetY = 0.0;
                              newOffsetX = newOffsetX.clamp(-maxOffsetY, maxOffsetY);
                            } else {
                              // Обычная ориентация: X заблокирован, Y с ограничениями
                              newOffsetX = 0.0;
                              newOffsetY = newOffsetY.clamp(-maxOffsetY, maxOffsetY);
                            }
                          } else {
                            // Ландшафтное изображение: при автомасштабе движения нет
                            newOffsetX = 0.0;
                            newOffsetY = 0.0;
                          }
                        }
                        
                        _offsetX = newOffsetX;
                        _offsetY = newOffsetY;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.black,
                      child: Stack(
                        children: [
                          // Изображение
                          Positioned.fill(
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..translate(_offsetX, _offsetY) // Смещение по X и Y
                                ..rotateZ(_rotationDegrees * 3.14159 / 180) // Поворот в радианах
                                ..scale(_isFlippedHorizontally ? -_scale : _scale, _scale), // Масштабирование с отражением
                              child: Image.file(
                                widget.imageFile,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          
                          // Круглая область поверх изображения
                          Positioned.fill(
                            child: CustomPaint(
                              painter: CircleOverlayPainter(),
                            ),
                          ),
                          
                          // Правая панель с инструментами
                          _buildToolsPanel(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
    );
  }
  
  /// Строим правую панель с инструментами
  Widget _buildToolsPanel() {
    return Positioned(
      right: 4,
      top: 0,
      bottom: 0,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildToolButton({
                'icon': Icons.flip,
                'onPressed': () {
                  setState(() {
                    _isFlippedHorizontally = !_isFlippedHorizontally;
                  });
                },
                'tooltip': 'Зеркальное отражение',
                'isActive': _isFlippedHorizontally,
              }),
              const SizedBox(height: 8),
              _buildToolButton({
                'icon': Icons.rotate_90_degrees_ccw,
                'onPressed': () {
                  setState(() {
                    _rotationDegrees = (_rotationDegrees + 90) % 360;
                    // Сбрасываем смещения при повороте
                    _offsetX = 0.0;
                    _offsetY = 0.0;
                  });
                },
                'tooltip': 'Поворот на 90°',
                'isActive': _rotationDegrees != 0,
              }),
            ],
          ),
        ),
      ),
    );
  }

  /// Строим кнопку инструмента
  Widget _buildToolButton(Map<String, dynamic> tool) {
    final isActive = tool['isActive'] ?? false;
    
    return Tooltip(
      message: tool['tooltip'],
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: tool['onPressed'],
          borderRadius: BorderRadius.circular(22),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: isActive 
                ? Colors.white.withOpacity(0.3)
                : Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Icon(
              tool['icon'],
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}

/// Кастомный painter для отрисовки круглой области по центру экрана
class CircleOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Диаметр круга равен ширине экрана
    final diameter = size.width;
    final radius = diameter / 2;
    
    // Центр экрана
    final center = Offset(size.width / 2, size.height / 2);
    
    // Создаем путь для затемнения вокруг круга
    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addOval(Rect.fromCircle(center: center, radius: radius))
      ..fillType = PathFillType.evenOdd;
    
    // Рисуем затемнение вокруг круга
    final overlayPaint = Paint()
      ..color = Colors.black.withOpacity(0.6);
    canvas.drawPath(path, overlayPaint);
    
    // Рисуем белую границу круга
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, radius, borderPaint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
