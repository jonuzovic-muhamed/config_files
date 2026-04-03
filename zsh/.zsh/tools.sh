#  _____           _ _                ____             __ _
# |_   _|__   ___ | (_)_ __   __ _   / ___|___  _ __  / _(_) __ _
#   | |/ _ \ / _ \| | | '_ \ / _` | | |   / _ \| '_ \| |_| |/ _` |
#   | | (_) | (_) | | | | | | (_| | | |__| (_) | | | |  _| | (_| |
#   |_|\___/ \___/|_|_|_| |_|\__, |  \____\___/|_| |_|_| |_|\__, |
#                            |___/                          |___/

# Author: Muhamed Jonuzovic
# Date: 03.04.2026
# About: Various Tooling Configuration

# -------- SSH Agent (start once) --------
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
  eval "$(ssh-agent -s)" &>/dev/null
fi

# -------- Zsh Completion --------
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# -------- NVM --------
export NVM_DIR="$HOME/.config/nvm"

if [[ -s "$NVM_DIR/nvm.sh" ]]; then
  source "$NVM_DIR/nvm.sh"
fi

if [[ -s "$NVM_DIR/bash_completion" ]]; then
  source "$NVM_DIR/bash_completion"
fi

# -------- JDK Version 21 ------------
if [[ -x /usr/libexec/java_home ]]; then
  export JAVA_HOME=$(/usr/libexec/java_home -v 21 2>/dev/null)
fi

# ------- HomeBrew Package Manager -----------
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
