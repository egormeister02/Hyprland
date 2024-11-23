#!/bin/bash
API_KEY="AQVNw32076HmsXR4REmvJ63JMBB0qqA3cYLNj56R"
CURRENT_TEXT=""  # Переменная для хранения текущего текста
TRANSLATED_TEXT=""  # Переменная для хранения переведенного текста

# Запускаем Kitty для вывода перевода
kitty bash -c "
  API_KEY=\"$API_KEY\"  # Передаем API_KEY в контекст Kitty

  translate_text() {
    TEXT=\"\$1\"
    RESPONSE=\$(curl -s -X POST \"https://translate.api.cloud.yandex.net/translate/v2/translate\" \
      -H \"Authorization: Api-Key \$API_KEY\" \
      -H \"Content-Type: application/json\" \
      -d '{
            \"texts\": [\"'\$TEXT'\"],
            \"targetLanguageCode\": \"ru\"
          }')

    # Проверка на ошибки при парсинге
    TRANSLATED_TEXT=\$(echo \"\$RESPONSE\" | jq -r '.translations[0].text')
    if [[ \"\$TRANSLATED_TEXT\" == \"null\" ]]; then
      echo \"Ошибка: Не удалось получить переведённый текст. Ответ API: \$RESPONSE\"
      exit 1
    fi
  }

  echo 'Выделите текст и нажмите любую клавишу для выхода...'
  while true; do
    # Получаем текст из буфера обмена
    NEW_TEXT=\$(wl-paste -p)

    # Проверяем, изменился ли текст
    if [[ \"\$NEW_TEXT\" != \"\$CURRENT_TEXT\" ]]; then
      CURRENT_TEXT=\$NEW_TEXT  # Обновляем текущий текст
      translate_text \"\$CURRENT_TEXT\"  # Переводим новый текст

      # Форматируем вывод
      echo \"\$CURRENT_TEXT\"
      echo \"\$(printf '%*s' \"\$(tput cols)\" '' | tr ' ' '-')\"  # Черта из "-"
      echo \"\$TRANSLATED_TEXT\"
    fi

    sleep 1  # Задержка перед следующей проверкой
  done
"
