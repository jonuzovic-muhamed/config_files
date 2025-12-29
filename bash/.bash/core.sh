#   ____                  ____             __ _
#  / ___|___  _ __ ___   / ___|___  _ __  / _(_) __ _
# | |   / _ \| '__/ _ \ | |   / _ \| '_ \| |_| |/ _` |
# | |__| (_) | | |  __/ | |__| (_) | | | |  _| | (_| |
#  \____\___/|_|  \___|  \____\___/|_| |_|_| |_|\__, |
#                                               |___/

# Author: Muhamed Jonuzovic
# Date: 29.12.2025
# About: Core configuration parameters.

# -------- Behavior --------
set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert  'Control-l: clear-screen'
shopt -s histappend
shopt -s checkwinsize

# -------- History --------
export HISTSIZE=5000
export HISTFILESIZE=20000
export HISTCONTROL=ignoredups:erasedups

# Save history immediately
PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"

# -------- Prompt --------
PS1='\[\e[34;1m\]\w \[\e[0m\]$ '

# -------- Less / Man --------
export PAGER=less
export LESS='-R --mouse'
