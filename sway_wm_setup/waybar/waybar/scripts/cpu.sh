#!/bin/bash

# Get CPU Temp
cpu_temp_raw=$(cat /sys/class/hwmon/hwmon3/temp1_input 2>/dev/null)
cpu_temp=$(awk "BEGIN {printf \"%.1f\", $cpu_temp_raw/1000}")

# Get CPU Usage
# Get first snapshot
read cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat
cpu_idle_1=$((idle + iowait))
cpu_total_1=$((user + nice + system + idle + iowait + irq + softirq + steal))

# Wait a second
sleep 1

# Get second snapshot
read cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat
cpu_idle_2=$((idle + iowait))
cpu_total_2=$((user + nice + system + idle + iowait + irq + softirq + steal))

# Calculate deltas
total_diff=$((cpu_total_2 - cpu_total_1))
idle_diff=$((cpu_idle_2 - cpu_idle_1))
cpu_usage=$((100 * (total_diff - idle_diff) / total_diff))

echo "${cpu_usage}% ${cpu_temp}°C"
