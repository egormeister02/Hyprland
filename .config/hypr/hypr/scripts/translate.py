import subprocess
import requests
import json
import time
import tkinter as tk

# API Key Yandex
API_KEY = "AQVNw32076HmsXR4REmvJ63JMBB0qqA3cYLNj56R"

# Переменные для хранения текста
current_text = ""
translated_text = ""

def translate_text(text):
    url = "https://translate.api.cloud.yandex.net/translate/v2/translate"
    headers = {
        "Authorization": f"Api-Key {API_KEY}",
        "Content-Type": "application/json"
    }
    data = {
        "texts": [text],
        "targetLanguageCode": "ru"
    }

    try:
        response = requests.post(url, headers=headers, data=json.dumps(data))
        response.raise_for_status()  # Проверка на ошибки HTTP
        translated_text = response.json()["translations"][0]["text"]
        return translated_text
    except requests.exceptions.RequestException as e:
        print(f"Ошибка запроса: {e}")
        return None
    except (KeyError, IndexError) as e:
        print(f"Ошибка при парсинге ответа API: {e}")
        return None

def get_selected_text():
    try:
        # Получаем текст из буфера "primary selection" через wl-paste
        result = subprocess.run(["wl-paste", "-p"], capture_output=True, text=True)
        return result.stdout.strip() if result.stdout else ""
    except Exception as e:
        print(f"Ошибка получения текста: {e}")
        return ""

def update_translation(window, original_text_box, translated_text_box):
    global current_text
    new_text = get_selected_text()
    
    # Проверяем, изменился ли текст
    if new_text != current_text and new_text.strip() != "":
        current_text = new_text  # Обновляем текущий текст
        translated_text = translate_text(current_text)  # Переводим текст

        if translated_text:
            # Очищаем текстовые поля и обновляем их содержимое
            original_text_box.delete("1.0", tk.END)
            original_text_box.insert("1.0", current_text)

            translated_text_box.delete("1.0", tk.END)
            translated_text_box.insert("1.0", translated_text)
    
    # Запускаем проверку через 1 секунду
    window.after(500, update_translation, window, original_text_box, translated_text_box)

def create_window():
    window = tk.Tk()
    window.title("Translator3000")

    # Метка для исходного текста
    original_label = tk.Label(window, text="Original:", font=("Helvetica", 12, "bold"))
    original_label.pack()

    # Поле для исходного текста
    original_text_box = tk.Text(window, wrap="word", height=15)
    original_text_box.pack()

    # Метка для перевода
    separator = tk.Label(window, text="Translator 3000", font=("Helvetica", 12, "bold"))
    separator.pack()

    # Поле для перевода
    translated_text_box = tk.Text(window, wrap="word", height=15)
    translated_text_box.pack()

    # Кнопка выхода
    exit_button = tk.Button(window, text="Закрыть", command=window.quit)
    exit_button.pack()

    # Запускаем цикл обновления перевода
    window.after(500, update_translation, window, original_text_box, translated_text_box)

    window.mainloop()

def main():
    create_window()

if __name__ == "__main__":
    main()
