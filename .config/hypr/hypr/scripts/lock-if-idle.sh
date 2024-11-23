if ! playerctl --player=firefox status >/dev/null 2>&1; then
# Если нет воспроизведения, запускаем swaylock
swaylock
fi

