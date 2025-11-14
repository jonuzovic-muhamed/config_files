#!/usr/bin/env bash

ram_usage=$(free -h | sed 's/  */ /g' | tail -2 | head -1 | cut -d ' ' -f 2,3 | sed 's/ / - /g')

echo $ram_usage
