#!/usr/bin/env bash
# Pomodoro timer for Waybar
# Left-click: start/pause | Right-click: skip phase | Middle-click: reset
# Requires: jq, notify-send (optional for notifications)

STATE="${XDG_RUNTIME_DIR:-/tmp}/waybar_pomodoro.json"

# Durations in seconds
WORK_SECS=1500    # 25 min
SHORT_SECS=300    #  5 min
LONG_SECS=900     # 15 min
SESSIONS_FOR_LONG=4

# ---------------------------------------------------------------------------
init() {
    printf '{"status":"stopped","mode":"work","sessions":0,"elapsed":0,"start_time":0}' \
        > "$STATE"
}

[[ -f "$STATE" ]] || init

state=$(cat "$STATE")
status=$(jq -r '.status'     <<< "$state")
mode=$(jq -r '.mode'         <<< "$state")
sessions=$(jq -r '.sessions' <<< "$state")
elapsed=$(jq -r '.elapsed'   <<< "$state")
start_time=$(jq -r '.start_time' <<< "$state")

save()   { printf '%s' "$1" > "$STATE"; }

duration() {
    case "$1" in
        work)        echo $WORK_SECS  ;;
        short_break) echo $SHORT_SECS ;;
        long_break)  echo $LONG_SECS  ;;
    esac
}

# Outputs "<next_mode> <session_count>"
next_phase() {
    local m="$1" s="$2"
    if [[ "$m" == "work" ]]; then
        local ns=$(( s + 1 ))
        (( ns % SESSIONS_FOR_LONG == 0 )) \
            && echo "long_break $ns" \
            || echo "short_break $ns"
    else
        echo "work $s"
    fi
}

notify_maybe() {
    command -v notify-send &>/dev/null \
        && notify-send -t 5000 -i "appointment-soon" "Pomodoro" "$1"
}

# ---------------------------------------------------------------------------
case "${1:-status}" in

    toggle)
        now=$(date +%s)
        if [[ "$status" == "running" ]]; then
            new_elapsed=$(( elapsed + now - start_time ))
            save "$(jq --argjson e "$new_elapsed" '.status="paused"|.elapsed=$e' <<< "$state")"
        else
            save "$(jq --argjson t "$now" '.status="running"|.start_time=$t' <<< "$state")"
        fi
        ;;

    skip)
        read -r next_mode next_sessions <<< "$(next_phase "$mode" "$sessions")"
        now=$(date +%s)
        save "$(jq --arg m "$next_mode" --argjson s "$next_sessions" --argjson t "$now" \
            '.mode=$m|.sessions=$s|.elapsed=0|.start_time=$t|.status="running"' <<< "$state")"
        [[ "$next_mode" == "work" ]] \
            && notify_maybe "Break over! Back to focus." \
            || notify_maybe "Pomodoro done! Take a break."
        ;;

    reset)
        init
        ;;

    status|*)
        now=$(date +%s)
        if [[ "$status" == "running" ]]; then
            total=$(( elapsed + now - start_time ))
        else
            total=$elapsed
        fi

        dur=$(duration "$mode")

        # Auto-advance when the timer expires
        if [[ "$status" == "running" ]] && (( total >= dur )); then
            read -r next_mode next_sessions <<< "$(next_phase "$mode" "$sessions")"
            save "$(jq --arg m "$next_mode" --argjson s "$next_sessions" --argjson t "$now" \
                '.mode=$m|.sessions=$s|.elapsed=0|.start_time=$t|.status="running"' <<< "$state")"
            [[ "$next_mode" == "work" ]] \
                && notify_maybe "Break over! Back to focus." \
                || notify_maybe "Pomodoro done! Take a break."
            mode="$next_mode"; sessions="$next_sessions"; total=0; dur=$(duration "$mode")
        fi

        remaining=$(( dur - total ))
        (( remaining < 0 )) && remaining=0
        time_str=$(printf "%02d:%02d" $(( remaining / 60 )) $(( remaining % 60 )))

        case "$mode" in
            work)        icon="󰔟"; label="Focus"      ;;
            short_break) icon="󰒳"; label="Short Break" ;;
            long_break)  icon="󰒲"; label="Long Break"  ;;
        esac

        case "$status" in
            paused)  icon="󰏤" ;;
            stopped) time_str="25:00" ;;
        esac

        css_class="$mode"
        [[ "$status" == "paused"  ]] && css_class="paused"
        [[ "$status" == "stopped" ]] && css_class="stopped"

        # Session progress dots within current long-break cycle
        dots=""
        pos=$(( sessions % SESSIONS_FOR_LONG ))
        for (( i=0; i<SESSIONS_FOR_LONG; i++ )); do
            (( i < pos )) && dots+="●" || dots+="○"
        done

        tooltip="$label  |  session $(( pos + 1 ))/$SESSIONS_FOR_LONG  [$dots]\\n⏱ $time_str remaining\\n\\nLeft-click  : start / pause\\nRight-click : skip phase\\nMiddle-click: reset"

        printf '{"text":"%s %s","tooltip":"%s","class":"%s"}\n' \
            "$icon" "$time_str" "$tooltip" "$css_class"
        ;;
esac
