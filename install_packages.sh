#!/usr/bin/env bash

if [[ $EUID -ne 0 ]]; then
    echo "This script installs packages with package manager, it needs sudo privileges."
    echo "Please run this script with sudo!"
    exit 1
fi

ping -4 -c1 deb.debian.org &>/dev/null ||
{
    echo "Network unavailable! Can't install packages."
    exit 1
}

### General Tools
total_packages=('radeontop thunar pavucontrol keepassxc obs-studio vlc qalculate-gtk')

### Wayland
total_packages+=('wayland libqt5waylandclient5 libqt5waylandcompositor5 libqt6waylandclient6 libqt6waylandcompositor6 libva-wayland2 libwayland-client0 libwayland-cursor0 libwayland-egl1 libwayland-server0 qt6-wayland qtwayland5 xwayland-run xwayland xwaylandvideobridge')

### XDG Desktop Portal Definition
total_packages+=('python3-xdg xdg-dbus-proxy xdg-desktop-portal-gtk xdg-desktop-portal-wlr xdg-desktop-portal xdg-user-dirs-gtk xdg-user-dirs xdg-utils')

### App Launchers
total_packages+=('rofi')

### Yaru Theme
total_packages+=('yaru-theme-gtk yaru-theme-icon yaru-theme-sound')

### Sway Components
total_packages+=('sway-backgrounds sway-notification-center sway swaybg swayidle swayimg swaykbdd swaylock swayosd')

### System Bar
total_packages+=('waybar')

### Terminal Emulators
total_packages+=('kitty alacritty foot')

### Fonts
total_packages+='fonts-firacode'

### Office Suite
total_packages+=('libreoffice')

### Browsers & Email
total_packages+='firefox-esr thunderbird'

### Network Manager
total_packages+=('network-manager-applet network-manager-l10n network-manager-openconnect-gnome network-manager-openconnect network-manager-openvpn-gnome network-manager-openvpn network-manager-pptp-gnome network-manager-pptp network-manager-vpnc-gnome network-manager-vpnc network-manager')

### Bluetooth
total_packages+=('bluetooth blueman')

### Log File Definition
log_file="/home/$SUDO_USER/package_install.log"
touch $log_file

### Func for installing package_group
function install_package_group {
  packages=$1
  log=$2
  apt install -y $1 | tee -a $log
}

function install_total_packages {
  echo '=================== BEGIN PACKAGE INSTALLATION ===================' | tee -a $log_file

  for package_group in "${total_packages[@]}"; do
    install_package_group "$package_group" $log_file
  done

  echo '=================== END PACKAGE INSTALLATION =====================' | tee -a $log_file
}

install_total_packages
exit 0;
