#!/usr/bin/env bash

# --- CONFIGURACIÓN ---
theme="$HOME/.config/rofi/powermenu/powermenu.rasi"
uptime=$(uptime -p | sed -e 's/up //g')

# --- ICONOS ---
shutdown=''
reboot=''
logout=''
yes=''
no=''

# --- FUNCIÓN: MENÚ PRINCIPAL ---
run_rofi() {
    echo -e "$logout\n$reboot\n$shutdown" | rofi \
        -dmenu \
        -mesg "bye bye.&#x0a;<span size='small' color='#867970'>Sesión: $uptime</span>" \
        -theme ${theme}
}

# --- FUNCIÓN: CONFIRMACIÓN ---
# Reutilizamos el mismo tema pero cambiamos el mensaje
confirm_cmd() {
    echo -e "$no\n$yes" | rofi \
        -dmenu \
        -p "Seguro?" \
        -mesg "¿Turn off?" \
        -theme ${theme}
}

# --- LÓGICA ---
chosen="$(run_rofi)"

case ${chosen} in
    $shutdown)
        # AQUÍ ESTÁ EL CAMBIO:
        # Abrimos el menú de confirmación antes de ejecutar
        selected="$(confirm_cmd)"
        if [[ "$selected" == "$yes" ]]; then
            systemctl poweroff
        fi
        ;;
    $reboot)
        systemctl reboot
        ;;
    $logout)
        i3-msg exit
        ;;
esac
