from PIL import Image

def resize_image(input_path, output_path, new_width=512):
    try:
        # Открываем изображение
        img = Image.open(input_path)
        
        # Получаем текущие размеры
        original_width, original_height = img.size
        
        # Вычисляем коэффициент масштабирования
        scale = new_width / original_width
        
        # Вычисляем новую высоту с сохранением пропорций
        new_height = int(original_height * scale)
        
        # Изменяем размер изображения
        resized_img = img.resize((new_width, new_height), Image.LANCZOS)
        
        # Сохраняем новое изображение
        resized_img.save(output_path, quality=95)
        print(f"Изображение успешно обработано и сохранено как {output_path}")
        
    except Exception as e:
        print(f"Ошибка: {e}")

# Пример использования
if __name__ == "__main__":
    input_image = "outlook.png"  # Путь к исходному изображению
    output_image = "outlook2.png"  # Путь для сохранения результата
    resize_image(input_image, output_image)
