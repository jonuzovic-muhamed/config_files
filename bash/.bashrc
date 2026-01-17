#  ____            _        ____             __ _
# | __ )  __ _ ___| |__    / ___|___  _ __  / _(_) __ _
# |  _ \ / _` / __| '_ \  | |   / _ \| '_ \| |_| |/ _` |
# | |_) | (_| \__ \ | | | | |__| (_) | | | |  _| | (_| |
# |____/ \__,_|___/_| |_|  \____\___/|_| |_|_| |_|\__, |
#                                                 |___/

# Author: Muhamed Jonuzovic
# Date: 29.12.2025
# About: Entrypoint file for loading the configuration step by step. The configuration is located inside $HOME/.bash config directory.

# Global Config Location
BASH_DIR="$HOME/.bash"

# Only run for interactive shells
# Prevent loading heavy stuff for non-interactive shell
[[ $- != *i* ]] && return

source "$BASH_DIR/core.sh"
source "$BASH_DIR/env.sh"
source "$BASH_DIR/paths.sh"
source "$BASH_DIR/aliases.sh"
source "$BASH_DIR/functions.sh"
source "$BASH_DIR/tools.sh"

# Optional machine- or user-specific overrides
[[ -f "$BASH_DIR/local.sh" ]] && source "$BASH_DIR/local.sh"
