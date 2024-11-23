#!/bin/bash

# Захватываем выделенный текст
selected_text=$(wl-paste -p)

# Обрабатываем выделенный текст с помощью Python-скрипта
processed_text=$(python3 ~/.config/hypr/scripts/layout-convert.py "$selected_text")
echo "$processed_text"
# Вставляем обработанный текст вместо выделенного
echo -n "$processed_text" | wl-copy