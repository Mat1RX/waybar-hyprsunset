#!/bin/bash

case $1 in
    up)
        hyprctl hyprsunset temperature +25
        ;;
    down)
        hyprctl hyprsunset temperature -25
        ;;
    reset)
        hyprctl hyprsunset temperature 6000
        ;;
esac

# В любом случае выводим текущую температуру для Waybar
TEMP=$(hyprctl hyprsunset temperature)
echo "{\"text\": \"${TEMP}K\", \"class\": \"sunset\"}"
