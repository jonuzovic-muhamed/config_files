#   ____                  ____             __ _
#  / ___|___  _ __ ___   / ___|___  _ __  / _(_) __ _
# | |   / _ \| '__/ _ \ | |   / _ \| '_ \| |_| |/ _` |
# | |__| (_) | | |  __/ | |__| (_) | | | |  _| | (_| |
#  \____\___/|_|  \___|  \____\___/|_| |_|_| |_|\__, |
#                                               |___/

# Author: Muhamed Jonuzovic
# Date: 03.04.2026
# About: Core configuration parameters.

# -------- Behavior --------
bindkey -v
bindkey -M vicmd '^l' clear-screen
bindkey -M viins '^l' clear-screen

setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt CHECK_JOBS

# -------- History --------
export HISTSIZE=5000
export SAVEHIST=20000
export HISTFILE="$HOME/.zsh_history"
setopt HIST_IGNORE_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS

# -------- Prompt --------
setopt PROMPT_SUBST
PS1='%B%F{blue}%~%f%b $ '

# -------- Less / Man --------
export PAGER=less
export LESS='-R --mouse'
