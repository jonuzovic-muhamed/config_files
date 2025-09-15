#!/bin/bash

function cpu_usage() {
  printf "CPU %.1f%%|" $(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
}


function memory_usage() {

  if [ "$(which bc)" ]; then

    read used total <<< $(free -m | awk '/Mem/{printf $2" "$3}')
    percent=$(bc -l <<< "100 * $total / $used")

  else

    total=$(free -h | sed 's/[[:space:]]\+/\//g' | cut -d '/' -f 2 | sed -n '2p' | sed 's/[Gi,Mi]//g')
    used=$(free -h | sed 's/[[:space:]]\+/\//g' | cut -d '/' -f 3 | sed -n '2p' | sed 's/[Gi,Mi]//g')
    percent=$(bc -l <<< "100 * $total / $used")

  fi

  printf "RAM %.1f%%|" "$percent"
}

function sysinfo() {
  printf "%s|" $(uname -a | awk '{print $1 " " substr($3, 1, 6) " " substr($4,5,20) " " $2}')
}

function username() {
  printf "%s|" $(id -un)
}

function main() {
  sysinfo
  username
  cpu_usage
  memory_usage
}

main

