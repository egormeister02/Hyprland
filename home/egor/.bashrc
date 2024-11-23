#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias killwaybar='killall -SIGUSR2 waybar'

alias ll='ls -la --color=auto'  # Подробный список с цветами
alias la='ls -A --color=auto'   # Показывать все файлы кроме . и ..
alias l='ls -CF --color=auto'   # Краткий список
alias ..='cd ..'                # Перейти на уровень выше
alias ...='cd ../..'            # Перейти на два уровня выше
alias mkdir='mkdir -pv'         # Создавать каталоги с родителями

alias update='sudo pacman -Syu'                   # Обновить систему
alias install='sudo pacman -S'                    # Установить пакет
alias remove='sudo pacman -Rns'                   # Удалить пакет с зависимостями
alias search='pacman -Ss'                         # Поиск пакета в репозиториях
alias yays='yay -Syu --devel --timeupdate'        # Обновить все пакеты с помощью yay
alias ysi='yay -S'                                # Установить пакет с помощью yay
alias ysremove='yay -Rns'                         # Удалить пакет с помощью yay

alias vpn-up='sudo wg-quick up wg'
alias vpn-down='sudo wg-quick down wg'


startvpn() {
    sudo systemctl start openvpn@"$1"
}

stopvpn() {
    sudo systemctl stop openvpn@"$1"
}

startvenv() {
    source "$1"/bin/activate
}

alias d="deactivate"

#PS1='[\u@\h \W]\$ '

eval "$(starship init bash)"
export DOCKER_HOST=unix:///var/run/docker.sock
export TZ='Europe/Moscow'
