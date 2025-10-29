#!/bin/bash

if [ $# -eq 0 ]; then
  echo "No username provided!"
  echo "Provide username in argument as its needed for autologin.service systemd service file. It specifies the user which execute the start command at login!"
  exit 1
else
  cp /etc/pam.d/login /etc/pam.d/autologin
  cp autologin/autologin /usr/local/bin
  sed -i 's/username/$1/' autologin/autologin.service
  cp autologin/autologin.service /etc/systemd/system
  systemctl enable autologin.service
  echo "Autologin was configured!"
  exit 0
fi
