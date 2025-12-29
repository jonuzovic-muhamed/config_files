#  __  __     _       ____             __ _ _
# |  \/  |   | |___  |  _ \ _ __ ___  / _(_) | ___
# | |\/| |_  | / __| | |_) | '__/ _ \| |_| | |/ _ \
# | |  | | |_| \__ \ |  __/| | | (_) |  _| | |  __/
# |_|  |_|\___/|___/ |_|   |_|  \___/|_| |_|_|\___|
#

# General
export NATIVE_WAYLAND=1
export WLR_NO_HARDWARE_CURSORS=1
export CLUTTER_BACKEND=wayland
export SDL_VIDEODRIVER=wayland
export WLR_RENDERER=vulkan
export OZONE_PLATFORM=wayland

# XDG Setup
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=wayland
export XDG_CURRENT_DESKTOP=sway
export XDG_SCREENSHOTS_DIR=$HOME/Pictures/Screenshots

# GTK Setup
export GDK_BACKEND=wayland
export GTK_THEME=Yaru-blue-dark
export GDK_SCALE=1
export GDK_DPI_SCALE=1

# Qt Setup
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=qt5ct
export QT_QPA_PLATFORMTHEME=qt6ct
export QT_STYLE_OVERRIDE=Kvantum

# Applications
export ELECTRON_OZONE_PLATFORM_HINT=wayland
export MOZ_ENABLE_WAYLAND=1
export ANKI_WAYLAND=1

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

# SSH Agent Setup
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

eval `ssh-agent -s`

### --- Ensure runtime dir exists ---
if [ -z "$XDG_RUNTIME_DIR" ]; then
  export XDG_RUNTIME_DIR="/run/user/$(id -u)"
  [ -d "$XDG_RUNTIME_DIR" ] || mkdir -p "$XDG_RUNTIME_DIR"
  chmod 700 "$XDG_RUNTIME_DIR"
fi

### --- Start dbus session if not already ---
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
  eval "$(dbus-launch --sh-syntax --exit-with-session)"
fi

### --- Import environment into systemd user instance ---
if command -v systemctl >/dev/null; then
  systemctl --user import-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP DBUS_SESSION_BUS_ADDRESS
fi

### --- Start GNOME Keyring Daemon ---
if command -v gnome-keyring-daemon >/dev/null; then
  eval "$(gnome-keyring-daemon --start --components=secrets,ssh,pkcs11)"
  export SSH_AUTH_SOCK
fi

### --- Start portals (file pickers, URL openers, etc.) ---
if command -v systemctl >/dev/null; then
  systemctl --user start xdg-desktop-portal xdg-desktop-portal-wlr
fi

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
