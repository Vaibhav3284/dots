#!/usr/bin/env bash

# Using standard Nerd Font icons
shutdown="  Shutdown"
reboot="󰑓  Reboot"
lock="  Lock"
suspend="  Suspend"
logout="󰗽  Logout"

options="$lock\n$suspend\n$logout\n$reboot\n$shutdown"

# Large Horizontal Overlay - Grey Minimalist (Upscaled)
chosen=$(echo -e "$options" | rofi -dmenu -i -p "System" \
    -theme-str '
    window {
        width:            1000px;
        height:           180px;
        border:           2px;
        border-color:     #424242;
        background-color: #121212;
        border-radius:    10px;
    }
    mainbox {
        children:         [ listview ];
        background-color: transparent;
    }
    listview {
        layout:           horizontal;
        spacing:          20px;
        lines:            5;
        margin:           50px 50px;
        background-color: transparent;
    }
    element {
        padding:          10px 10px;
        width:            200px; /* Increased to fit larger text */
        background-color: transparent;
        border-radius:    6px;
    }
    element-text {
        horizontal-align: 0.5;
        vertical-align:   0.5;
        font:             "JetBrainsMono Nerd Font 18"; /* Bigger text and icons */
        background-color: transparent;
        text-color:       #e0e0e0;
    }
    element selected {
        background-color: #333333;
        text-color:       #ffffff;
    }
    element-text selected {
        text-color:       #ffffff;
    }
    inputbar { enabled: false; }
    ')

case $chosen in
    $lock)     loginctl lock-session ;;
    $suspend)  systemctl suspend ;;
    $logout)   loginctl terminate-user $USER ;;
    $reboot)   systemctl reboot ;;
    $shutdown) systemctl poweroff ;;
esac
