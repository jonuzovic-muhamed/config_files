#  ____       _   _        ____             __ _
# |  _ \ __ _| |_| |__    / ___|___  _ __  / _(_) __ _
# | |_) / _` | __| '_ \  | |   / _ \| '_ \| |_| |/ _` |
# |  __/ (_| | |_| | | | | |__| (_) | | | |  _| | (_| |
# |_|   \__,_|\__|_| |_|  \____\___/|_| |_|_| |_|\__, |
#                                                |___/

# Author: Muhamed Jonuzovic
# Date: 29.12.2025
# About: Path Configuration

path_add() {
  [[ -d "$1" && ":$PATH:" != *":$1:"* ]] && PATH="$1:$PATH"
}

# user's private bin
if [ -d "$HOME/bin" ] ; then
  path_add "$HOME/bin"
fi

# user's private bin
if [ -d "$HOME/.local/bin" ] ; then
  path_add "$HOME/.local/bin"
fi

# Java (RHEL Environment)
if [[ -d /usr/lib/jvm/java-21-openjdk-amd64 ]]; then
  export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
  path_add "$JAVA_HOME/bin"
fi

# Rust
if [[ -d "$HOME/.cargo" ]]; then
  RUST_HOME="$HOME/.cargo"
  path_add "$RUST_HOME/bin"
fi

export PATH
