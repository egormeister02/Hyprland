#!/bin/bash

# Путь к репозиторию
REPO_DIR="./"

# Список путей к файлам и папкам для бэкапа
FILES_TO_BACKUP=(
    "/home/egor/.config/hypr"
    "/home/egor/.config/waybar"
    "/home/egor/.config/swaylock"
    "/home/egor/.config/kitty"
    "/home/egor/.config/mako"
    "/home/egor/.config/wofi"
    "/home/egor/.config/starship.toml"
    "/home/egor/.bashrc"
)

# Проверка существования папки репозитория
if [[ ! -d "$REPO_DIR" ]]; then
    echo "Ошибка: Папка репозитория $REPO_DIR не найдена!"
    exit 1
fi

# Синхронизация файлов и папок
for FILE in "${FILES_TO_BACKUP[@]}"; do
    if [[ -e "$FILE" ]]; then
        RELATIVE_PATH="${FILE#/home/egor/}"  # Удаляем /home/egor для сохранения структуры
        DEST="$REPO_DIR/$RELATIVE_PATH"
        mkdir -p "$(dirname "$DEST")"  # Создаем директорию, если её нет
        rsync -a "$FILE" "$DEST"      # Синхронизируем содержимое
        echo "Синхронизирован: $FILE -> $RELATIVE_PATH"
    else
        echo "Предупреждение: $FILE не найден, пропускаем..."
    fi
done

# Коммит изменений в репозитории
cd "$REPO_DIR" || exit
git add .
git commit -m "Обновление бэкапов от $(date)"
git push

