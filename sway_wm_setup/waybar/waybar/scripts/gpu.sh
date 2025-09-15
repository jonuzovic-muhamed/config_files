#!/bin/bash

# Get GPU temp (example for AMD GPU — adjust if using NVIDIA)
gpu_temp_raw=$(cat /sys/class/hwmon/hwmon2/temp1_input 2>/dev/null)
gpu_temp=$(awk "BEGIN {printf \"%.1f\", $gpu_temp_raw/1000}")

gpu_usage=$(radeontop -d - -l 1 | grep gpu | cut -d ' ' -f 5 | cut -c 1-5)

echo "GPU ${gpu_usage} ${gpu_temp}°C"
