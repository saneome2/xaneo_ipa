#!/usr/bin/env python3
"""
Автоматический скрипт для создания инвертированных версий изображений
для светлой темы Flutter приложения.

Использование:
python image_inverter.py

Скрипт:
1. Находит все изображения в assets/img/
2. Инвертирует цвета каждого изображения
3. Сохраняет результат в assets/img/light/ с суффиксом '_light'
"""

import os
import sys
from pathlib import Path
from PIL import Image, ImageOps
import argparse

# Поддерживаемые форматы изображений
SUPPORTED_FORMATS = {'.png', '.jpg', '.jpeg', '.gif', '.bmp', '.tiff', '.webp'}

def invert_image_colors(image_path, output_path):
    """
    Инвертирует цвета изображения и сохраняет результат.

    Args:
        image_path (str): Путь к исходному изображению
        output_path (str): Путь для сохранения инвертированного изображения
    """
    try:
        # Открываем изображение
        with Image.open(image_path) as img:
            # Обрабатываем разные режимы изображений
            if img.mode == 'RGBA':
                # Для изображений с прозрачностью инвертируем только RGB каналы
                r, g, b, a = img.split()
                rgb_img = Image.merge('RGB', (r, g, b))
                inverted_rgb = ImageOps.invert(rgb_img)
                r_inv, g_inv, b_inv = inverted_rgb.split()
                inverted_img = Image.merge('RGBA', (r_inv, g_inv, b_inv, a))
            elif img.mode == 'LA':
                # Для grayscale с прозрачностью
                l, a = img.split()
                inverted_l = ImageOps.invert(l)
                inverted_img = Image.merge('LA', (inverted_l, a))
            elif img.mode == 'P':
                # Для palette изображений конвертируем в RGB сначала
                rgb_img = img.convert('RGB')
                inverted_img = ImageOps.invert(rgb_img)
            else:
                # Конвертируем в RGB для других режимов
                rgb_img = img.convert('RGB')
                inverted_img = ImageOps.invert(rgb_img)

            # Создаем папку для вывода если не существует
            output_path.parent.mkdir(parents=True, exist_ok=True)

            # Сохраняем с тем же форматом
            inverted_img.save(output_path, quality=95)

            print(f"✅ Инвертировано: {image_path} → {output_path}")
            return True

    except Exception as e:
        print(f"❌ Ошибка обработки {image_path}: {str(e)}")
        return False

def process_images(source_dir, target_dir, force=False):
    """
    Обрабатывает все изображения в исходной папке.

    Args:
        source_dir (Path): Исходная папка с изображениями
        target_dir (Path): Целевая папка для инвертированных изображений
        force (bool): Принудительно перезаписывать существующие файлы
    """
    if not source_dir.exists():
        print(f"❌ Исходная папка не найдена: {source_dir}")
        return

    # Находим все изображения, исключая папку назначения и файлы с _light
    image_files = []
    for ext in SUPPORTED_FORMATS:
        # Ищем только в исходной папке, исключая подпапки
        for img_file in source_dir.glob(f"*{ext}"):
            if img_file.is_file():
                # Пропускаем файлы, которые уже имеют суффикс _light
                if '_light' not in img_file.stem:
                    image_files.append(img_file)

    if not image_files:
        print(f"⚠️  Изображения не найдены в папке: {source_dir}")
        print("   Убедитесь, что файлы не имеют суффикса '_light' в имени")
        return

    print(f"🔍 Найдено изображений: {len(image_files)}")
    print(f"📁 Исходная папка: {source_dir}")
    print(f"📁 Целевая папка: {target_dir}")
    print("-" * 50)

    processed = 0
    skipped = 0

    for image_path in sorted(image_files):
        # Получаем относительный путь от исходной папки
        relative_path = image_path.relative_to(source_dir)

        # Создаем имя файла с суффиксом _light
        stem = relative_path.stem
        suffix = relative_path.suffix
        light_filename = f"{stem}_light{suffix}"

        # Полный путь для сохранения
        output_path = target_dir / light_filename

        # Проверяем, существует ли уже файл
        if output_path.exists() and not force:
            print(f"⏭️  Пропущено (уже существует): {output_path}")
            skipped += 1
            continue

        # Инвертируем изображение
        if invert_image_colors(image_path, output_path):
            processed += 1
        else:
            skipped += 1

    print("-" * 50)
    print(f"📊 Результаты:")
    print(f"   ✅ Обработано: {processed}")
    print(f"   ⏭️  Пропущено: {skipped}")
    print(f"   📁 Сохранено в: {target_dir}")

def main():
    parser = argparse.ArgumentParser(
        description="Автоматическое создание инвертированных изображений для светлой темы",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Примеры использования:
  python image_inverter.py                    # Обработка с параметрами по умолчанию
  python image_inverter.py --force           # Принудительное перезаписывание
  python image_inverter.py --source ./assets/img --target ./assets/img/light

Поддерживаемые форматы: PNG, JPG, JPEG, GIF, BMP, TIFF, WebP
        """
    )

    parser.add_argument(
        '--source', '-s',
        type=str,
        default='./assets/img',
        help='Папка с исходными изображениями (по умолчанию: ./assets/img)'
    )

    parser.add_argument(
        '--target', '-t',
        type=str,
        default='./assets/img/light',
        help='Папка для сохранения инвертированных изображений (по умолчанию: ./assets/img/light)'
    )

    parser.add_argument(
        '--force', '-f',
        action='store_true',
        help='Принудительно перезаписывать существующие файлы'
    )

    args = parser.parse_args()

    # Проверяем наличие Pillow
    try:
        import PIL
        print(f"🖼️  Используется Pillow версии: {PIL.__version__}")
    except ImportError:
        print("❌ Ошибка: Pillow не установлен!")
        print("Установите командой: pip install Pillow")
        sys.exit(1)

    print("🎨 Автоматическая инверсия изображений для Flutter")
    print("=" * 50)

    # Преобразуем пути
    source_dir = Path(args.source)
    target_dir = Path(args.target)

    # Проверяем, что целевая папка не является подпапкой исходной
    source_abs = source_dir.resolve()
    target_abs = target_dir.resolve()

    if target_abs.is_relative_to(source_abs):
        print("⚠️  Предупреждение: Целевая папка находится внутри исходной!")
        print("   Это может привести к повторной обработке файлов.")
        print("   Рекомендуется использовать отдельную папку для результатов.")
        print()

    # Обрабатываем изображения
    process_images(source_dir, target_dir, args.force)

    print("\n" + "=" * 50)
    print("✨ Готово! Инвертированные изображения созданы.")
    print("📝 Не забудьте добавить их в pubspec.yaml если необходимо.")

if __name__ == "__main__":
    main()
