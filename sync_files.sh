#!/bin/bash

# Путь к репозиторию
REPO_DIR="./"

# Список путей к файлам и папкам, которые нужно бэкапить
FILES_TO_BACKUP=(
    "/home/egor/.config/hypr",
    "/home/egor/.config/waybar",
    "/home/egor/.config/swaylock",
    "/home/egor/.config/kitty",
    "/home/egor/.config/mako",
    "/home/egor/.config/wofi",
    "/home/egor/.config/starship.toml",
    "/home/egor/.bashrc"
)

# Проверка существования папки репозитория
if [[ ! -d "$REPO_DIR" ]]; then
    echo "Error: Repository directory $REPO_DIR not found!"
    exit 1
fi

# Синхронизация файлов и папок
for FILE in "${FILES_TO_BACKUP[@]}"; do
    # Проверяем, существует ли файл или папка
    if [[ -e "$FILE" ]]; then
        RELATIVE_PATH="${FILE#/}"  # Удаляем начальный слэш для относительного пути
        DEST="$REPO_DIR/$RELATIVE_PATH"
        mkdir -p "$(dirname "$DEST")"  # Создаем директорию, если её нет
        rsync -a "$FILE" "$DEST"      # Синхронизируем содержимое
        echo "Synced: $FILE -> $DEST"
    else
        echo "Warning: $FILE not found, skipping..."
    fi
done

# Коммит изменений в репозитории
cd "$REPO_DIR" || exit
git add .
git commit -m "Update backups from $(date)"
git push
