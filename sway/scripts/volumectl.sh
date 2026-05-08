#!/usr/bin/env bash
# Simple volume controller with 0–100% bounds and notifications

SINK="@DEFAULT_SINK@"
STEP=5

get_volume() {
    pactl get-sink-volume "$SINK" | awk '/Volume:/ {print $5}' | head -n1 | tr -d '%'
}

set_volume() {
    local vol=$1
    # Clamp between 0 and 100
    (( vol < 0 )) && vol=0
    (( vol > 100 )) && vol=100
    pactl set-sink-volume "$SINK" "${vol}%"
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
        ;;
    micmute)
        pactl set-source-mute @DEFAULT_SOURCE@ toggle
        ;;
    *)
        echo "Usage: $0 {up|down|mute|micmute}"
        exit 1
        ;;
esac

