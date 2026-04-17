#!/bin/bash

#   ____             __ _         ___           _        _ _
#  / ___|___  _ __  / _(_) __ _  |_ _|_ __  ___| |_ __ _| | |
# | |   / _ \| '_ \| |_| |/ _` |  | || '_ \/ __| __/ _` | | |
# | |__| (_) | | | |  _| | (_| |  | || | | \__ \ || (_| | | |
#  \____\___/|_| |_|_| |_|\__, | |___|_| |_|___/\__\__,_|_|_|
#                         |___/

# Author: Muhamed Jonuzovic
# Date: 16.11.2025
# About: Installation Script for Configuration Files

SCRIPT_DIR="$(cd -- "$(dirname -- "$0")" && pwd)"

log_file="$HOME/config_file_install.log"
touch "$log_file"

external_fonts=(
    'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Lilex.zip'
    'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip'
    'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Hack.zip'
)

install_external_fonts() {
  echo '=================== EXTERNAL FONT INSTALLATION ===================' | tee -a "$log_file"

  font_dir="$HOME/.local/share/fonts"
  tmp_dir="/tmp/fonts"

  mkdir -p "$font_dir" | tee -a "$log_file"
  mkdir -p "$tmp_dir" | tee -a "$log_file"

  for font in "${external_fonts[@]}"; do
    wget -q --show-progress -P "$tmp_dir" "$font" | tee -a "$log_file"
  done

  for file in "$tmp_dir"/*.zip; do
    base="$(basename "$file" .zip)"
    extract_dir="/tmp/$base"

    mkdir -p "$extract_dir"
    unzip -o "$file" -d "$extract_dir" | tee -a "$log_file"

    find "$extract_dir" -type f \( -iname "*.ttf" -o -iname "*.otf" \) \
      -exec cp -v {} "$font_dir/" \; | tee -a "$log_file"

    rm -rf "$extract_dir"
  done

  fc-cache -f -v | tee -a "$log_file"
  rm -rf "$tmp_dir"/* | tee -a "$log_file"
}

install_bash_configuration() {
  echo '=================== BASH CONFIG INSTALLATION ===================' | tee -a "$log_file"
  bash_dir="$SCRIPT_DIR/bash"
  ln -s -f -v "$bash_dir/.bashrc" "$HOME/.bashrc"
  ln -s -f -v "$bash_dir/.bash_profile" "$HOME/.bash_profile"
  ln -s -f -v -n "$bash_dir/.bash" "$HOME/.bash"
}

install_zsh_configuration() {
  echo '=================== ZSH CONFIG INSTALLATION ===================' | tee -a "$log_file"
  zsh_dir="$SCRIPT_DIR/zsh"
  ln -s -f -v "$zsh_dir/.zshrc" "$HOME/.zshrc" | tee -a "$log_file"
  ln -s -f -v "$zsh_dir/.zprofile" "$HOME/.zprofile" | tee -a "$log_file"
  ln -s -f -v -n "$zsh_dir/.zsh" "$HOME/.zsh" | tee -a "$log_file"

  # local.sh is copied (not linked) to keep sensitive content out of git
  if [[ ! -f "$HOME/.zsh/local.sh" ]]; then
    cp -v "$zsh_dir/.zsh/local.sh" "$HOME/.zsh/local.sh" | tee -a "$log_file"
  else
    echo "~/.zsh/local.sh already exists, skipping copy to preserve local secrets." | tee -a "$log_file"
  fi
}

install_terminal_emulator_configuration() {
  echo '=================== TERMINAL EMULATOR CONFIG INSTALLATION ===================' | tee -a "$log_file"
  terminal_dir="$SCRIPT_DIR/terminal_emulators"
  for dir in "$terminal_dir"/* ; do
    dir_basename="$(basename "$dir")"
    target="$HOME/.config/$dir_basename"
    mkdir -p "$target"
    cp -a -l -v "$dir/." "$target/" | tee -a "$log_file"
  done
}

install_tmux_configuration() {
  echo '=================== TMUX CONFIG INSTALLATION ===================' | tee -a "$log_file"
  tmux_dir="$SCRIPT_DIR/tmux"
  ln -f -v "$tmux_dir/.tmux.conf" "$HOME/.tmux.conf" | tee -a "$log_file"

  tmux_script_dir="$HOME/.tmux"
  mkdir -p "$tmux_script_dir"

  for file in "$tmux_dir"/.tmux/*; do
    ln -f -v "$file" "$tmux_script_dir/" | tee -a "$log_file"
  done
}

install_vim_configuration() {
  echo '=================== VIM CONFIG INSTALLATION ===================' | tee -a "$log_file"
  vim_dir="$SCRIPT_DIR/vim"
  ln -f -v "$vim_dir/.vimrc" "$HOME/.vimrc" | tee -a "$log_file"
}

install_neovim_configuration() {
  echo '=================== NEOVIM CONFIG INSTALLATION ===================' | tee -a "$log_file"
  source_dir="$SCRIPT_DIR/nvim"
  target_dir="$HOME/.config/nvim"
  mkdir -p "$target_dir"
  if [[ ! -d "$target_dir" || -z "$(ls -A "$target_dir")" ]]; then
    echo "Installing Neovim config fresh..." | tee -a "$log_file"
    cp -l -v -a "$source_dir/." "$target_dir/" | tee -a "$log_file"
  else
    echo "Merging Neovim config into existing directory..." | tee -a "$log_file"
    cp -l -v -a "$source_dir/." "$target_dir/" | tee -a "$log_file"
  fi
}

install_sway_configuration() {
  echo '=================== SWAY CONFIG INSTALLATION ===================' | tee -a "$log_file"
  source_dir="$SCRIPT_DIR/sway"
  target_dir="$HOME/.config/sway"
  mkdir -p "$target_dir"
  cp -a -l -v "$source_dir/." "$target_dir/" | tee -a "$log_file"
}

install_rofi_configuration() {
  echo '=================== ROFI CONFIG INSTALLATION ===================' | tee -a "$log_file"
  source_dir="$SCRIPT_DIR/rofi"
  target_dir="$HOME/.config/rofi"
  mkdir -p "$target_dir"
  cp -a -l -v "$source_dir/." "$target_dir/" | tee -a "$log_file"
}

install_waybar_configuration() {
  echo '=================== WAYBAR CONFIG INSTALLATION ===================' | tee -a "$log_file"
  source_dir="$SCRIPT_DIR/waybar"
  target_dir="$HOME/.config/waybar"
  mkdir -p "$target_dir"
  cp -a -l -v "$source_dir/." "$target_dir/" | tee -a "$log_file"
}

usage() {
  cat <<EOF
Usage: ./install.sh [OPTIONS]

Options:
  --bash        Install Bash config
  --zsh         Install Zsh config
  --font        Install Fonts
  --tmux        Install Tmux config
  --vim         Install Vim config
  --nvim        Install Neovim config
  --sway        Install Sway config
  --terminal    Install Terminal Emulators config
  --all         Install everything
  -h, --help    Show this help
EOF
}

INSTALL_ALL=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --bash) install_bash_configuration ;;
    --zsh)  install_zsh_configuration ;;
    --font) install_external_fonts ;;
    --tmux) install_tmux_configuration ;;
    --vim)  install_vim_configuration ;;
    --nvim) install_neovim_configuration ;;
    --sway) install_sway_configuration ;;
    --rofi) install_rofi_configuration ;;
    --waybar) install_waybar_configuration ;;
    --terminal) install_terminal_emulator_configuration ;;
    --all)  INSTALL_ALL=true ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $1"; usage; exit 1 ;;
  esac
  shift
done

if $INSTALL_ALL; then
  install_external_fonts
  install_bash_configuration
  install_zsh_configuration
  install_terminal_emulator_configuration
  install_tmux_configuration
  install_vim_configuration
  install_neovim_configuration
fi
