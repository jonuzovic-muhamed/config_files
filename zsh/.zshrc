#  _________  _      ____             __ _
# |__  / ___|| |__  / ___|___  _ __  / _(_) __ _
#   / /\___ \| '_ \| |   / _ \| '_ \| |_| |/ _` |
#  / /_ ___) | | | | |__| (_) | | | |  _| | (_| |
# /____|____/|_| |_|\____\___/|_| |_|_| |_|\__, |
#                                           |___/

# Author: Muhamed Jonuzovic
# Date: 03.04.2026
# About: Entrypoint file for loading the configuration step by step. 
#The configuration is located inside $HOME/.zsh config directory.

# Global Config Location
ZSH_DIR="$HOME/.zsh"

# Only run for interactive shells
# Prevent loading heavy stuff for non-interactive shell
[[ ! -o interactive ]] && return

source "$ZSH_DIR/core.sh"
source "$ZSH_DIR/env.sh"
source "$ZSH_DIR/path.sh"
source "$ZSH_DIR/aliases.sh"
source "$ZSH_DIR/functions.sh"
source "$ZSH_DIR/tools.sh"

# Optional machine- or user-specific overrides
[[ -f "$ZSH_DIR/local.sh" ]] && source "$ZSH_DIR/local.sh"
