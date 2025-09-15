#  __  __     _       ____            _        ____             __ _
# |  \/  |   | |___  | __ )  __ _ ___| |__    / ___|___  _ __  / _(_) __ _
# | |\/| |_  | / __| |  _ \ / _` / __| '_ \  | |   / _ \| '_ \| |_| |/ _` |
# | |  | | |_| \__ \ | |_) | (_| \__ \ | | | | |__| (_) | | | |  _| | (_| |
# |_|  |_|\___/|___/ |____/ \__,_|___/_| |_|  \____\___/|_| |_|_| |_|\__, |
#                                                                    |___/

# Environment Variables Declaration
export EDITOR=nvim
export VISUAL=nvim
export TERM=xterm-256color
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
export PATH=$PATH:$JAVA_HOME
export MANPAGER="nvim +Man!"
export HISTCONTROL=ignoredups:erasedups
export LIBVIRT_DEFAULT_URI='qemu:///system'

# Vi like navigation mode for shell
set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'

# Custom prompt
PS1='\[\e[34;1m\]\w \[\e[0m\]$ '

# Each filetype has different color
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43:'

# History
HISTSIZE=5000
HISTFILESIZE=20000

# Aliases
alias ll="ls -lahvg --group-directories-first --color=auto"
alias rm="rm -v -i"
alias cp="cp -v -i"
alias mv="mv -v"

# Enable bash completion in interactive shells
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# XDG Base Directory Specification
if [ -z "$XDG_CONFIG_HOME" ] ; then
    export XDG_CONFIG_HOME="$HOME/.config"
fi
if [ -z "$XDG_DATA_HOME" ] ; then
    export XDG_DATA_HOME="$HOME/.local/share"
fi
if [ -z "$XDG_CACHE_HOME" ] ; then
    export XDG_CACHE_HOME="$HOME/.cache"
fi

# Archive extraction
# usage: ex <file>
ex ()
{
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Node Version Manager
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
