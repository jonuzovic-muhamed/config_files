#  __  __     _       ____            _       ____             __ _ _
# |  \/  |   | |___  | __ )  __ _ ___| |__   |  _ \ _ __ ___  / _(_) | ___
# | |\/| |_  | / __| |  _ \ / _` / __| '_ \  | |_) | '__/ _ \| |_| | |/ _ \
# | |  | | |_| \__ \ | |_) | (_| \__ \ | | | |  __/| | | (_) |  _| | |  __/
# |_|  |_|\___/|___/ |____/ \__,_|___/_| |_| |_|   |_|  \___/|_| |_|_|\___|
#

export QT_QPA_PLATFORMTHEME=qt5ct
export QT_QPA_PLATFORM=wayland
export QT_STYLE_OVERRIDE=Kvantum
export QT_QPA_PLATFORMTHEME=qt6ct

export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=sway
export XDG_SCREENSHOTS_DIR=$HOME/Pictures/Screenshots

export GDK_BACKEND=wayland
export GDK_SCALE=1.25
export GDK_DPI_SCALE=1.25
export GTK_THEME=Adwaita-dark

export QT_QPA_PLATFORM=wayland
export SDL_VIDEODRIVER=wayland
export CLUTTER_BACKEND=wayland
export MOZ_ENABLE_WAYLAND=1
export ANKI_WAYLAND=1

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs
. "$HOME/.cargo/env"
