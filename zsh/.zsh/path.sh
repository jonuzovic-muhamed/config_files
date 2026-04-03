#  ____       _   _        ____             __ _
# |  _ \ __ _| |_| |__    / ___|___  _ __  / _(_) __ _
# | |_) / _` | __| '_ \  | |   / _ \| '_ \| |_| |/ _` |
# |  __/ (_| | |_| | | | | |__| (_) | | | |  _| | (_| |
# |_|   \__,_|\__|_| |_|  \____\___/|_| |_|_| |_|\__, |
#                                                |___/

# Author: Muhamed Jonuzovic
# Date: 03.04.2026
# About: Path Configuration

path_add() {
  [[ -d "$1" && ":$PATH:" != *":$1:"* ]] && PATH="$1:$PATH"
}

# User Binaries
if [ -d "$HOME/bin" ] ; then
  path_add "$HOME/bin"
fi

if [ -d "$HOME/.local/bin" ] ; then
  path_add "$HOME/.local/bin"
fi

export PATH