#!/bin/bash

WALLPAPER_DIR=~/Pictures/cozy_v2/minimal_low_blue/
WALLPAPER=$(ls -1 "$WALLPAPER_DIR"/*.jpg | shuf -n 1)
feh --bg-scale "$WALLPAPER"
