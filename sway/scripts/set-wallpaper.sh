#!/bin/bash
set -euo pipefail

# Directory to pick wallpapers from; override via env var if needed
WALLPAPER_DIR="${WALLPAPER_DIR:-$HOME/Pictures/Wallpapers}"

# Usage:
#   set-wallpaper.sh          set a random wallpaper as the desktop background
#   set-wallpaper.sh --print  print a random wallpaper path to stdout (no bg change)
PRINT_ONLY=false
if [[ "${1:-}" == "--print" ]]; then
    PRINT_ONLY=true
fi

if [[ ! -d "$WALLPAPER_DIR" ]]; then
    exit 0
fi

mapfile -t images < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.webp" \) 2>/dev/null)

if [[ ${#images[@]} -eq 0 ]]; then
    exit 0
fi

image="${images[RANDOM % ${#images[@]}]}"

if [[ "$PRINT_ONLY" == true ]]; then
    printf '%s\n' "$image"
else
    swaymsg output '*' bg "$image" fill
fi
