#!/usr/bin/env bash
# Simple volume controller with 0–100% bounds and notifications

SINK="@DEFAULT_SINK@"
STEP=5
ICON_UP="󰝝"
ICON_DOWN="󰝞"
ICON_MUTE="󰖁"

get_volume() {
    pactl get-sink-volume "$SINK" | awk '/Volume:/ {print $5}' | head -n1 | tr -d '%'
}

set_volume() {
    local vol=$1
    # Clamp between 0 and 100
    (( vol < 0 )) && vol=0
    (( vol > 100 )) && vol=100
    pactl set-sink-volume "$SINK" "${vol}%"
    /usr/bin/notify-send "${ICON_UP} Volume ${vol}%"
}

case "$1" in
    up)
        cur=$(get_volume)
        set_volume $((cur + STEP))
        ;;
    down)
        cur=$(get_volume)
        set_volume $((cur - STEP))
        ;;
    mute)
        pactl set-sink-mute "$SINK" toggle
        /usr/bin/notify-send "${ICON_MUTE} Mute Toggled"
        ;;
    micmute)
        pactl set-source-mute @DEFAULT_SOURCE@ toggle
        /usr/bin/notify-send "󰍭 Microphone Mute Toggled"
        ;;
    *)
        echo "Usage: $0 {up|down|mute|micmute}"
        exit 1
        ;;
esac

