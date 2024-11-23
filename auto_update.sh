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
        NAME="$(basename "$FILE")"  # Получаем только имя файла или папки
        DEST="$REPO_DIR/$NAME"
        
        if [[ -d "$FILE" ]]; then
            rsync -a "$FILE/" "$DEST/"  # Синхронизируем папку
            echo "Synced folder: $FILE -> $NAME"
        else
            rsync -a "$FILE" "$DEST"      # Синхронизируем файл
            echo "Synced file: $FILE -> $NAME"
        fi
    else
        echo "Warning: $FILE not found, skipping..."
    fi
done

# Коммит изменений в репозитории
cd "$REPO_DIR" || exit
git add .
git commit -m "Update backups from $(date)"
git push

