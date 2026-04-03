#  _____           _ _                ____             __ _
# |_   _|__   ___ | (_)_ __   __ _   / ___|___  _ __  / _(_) __ _
#   | |/ _ \ / _ \| | | '_ \ / _` | | |   / _ \| '_ \| |_| |/ _` |
#   | | (_) | (_) | | | | | | (_| | | |__| (_) | | | |  _| | (_| |
#   |_|\___/ \___/|_|_|_| |_|\__, |  \____\___/|_| |_|_| |_|\__, |
#                            |___/                          |___/

# Author: Muhamed Jonuzovic
# Date: 29.12.2025
# About: Various Tooling Configuration

# -------- SSH Agent (start once) --------
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
  eval "$(ssh-agent -s)" &>/dev/null
fi

# -------- Bash completion & Sudo bash completion --------
if [[ -f /etc/bash_completion ]]; then
  source /etc/bash_completion
fi

if type _sudo >/dev/null 2>&1; then
  complete -F _sudo sudo
fi

# -------- NVM --------
export NVM_DIR="$HOME/.config/nvm"

if [[ -s "$NVM_DIR/nvm.sh" ]]; then
  source "$NVM_DIR/nvm.sh"
fi

if [[ -s "$NVM_DIR/bash_completion" ]]; then
  source "$NVM_DIR/bash_completion"
fi

# -------- JDK Version 21 ------------
export JAVA_HOME=$(/usr/libexec/java_home -v 21)

# ------- HomeBrew Package Manager Completion -----------
eval "$(/opt/homebrew/bin/brew shellenv bash)"
