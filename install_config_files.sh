#!/bin/bash

#   ____             __ _         ___           _        _ _
#  / ___|___  _ __  / _(_) __ _  |_ _|_ __  ___| |_ __ _| | |
# | |   / _ \| '_ \| |_| |/ _` |  | || '_ \/ __| __/ _` | | |
# | |__| (_) | | | |  _| | (_| |  | || | | \__ \ || (_| | | |
#  \____\___/|_| |_|_| |_|\__, | |___|_| |_|___/\__\__,_|_|_|
#                         |___/
# By: Muhamed Jonuzovic
# Date: 16.11.2025

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

install_shell_configuration() {
  echo '=================== SHELL CONFIG INSTALLATION ===================' | tee -a "$log_file"
  shell_dir="$SCRIPT_DIR/shell"

  for file in "$shell_dir"/.*; do
    basename=$(basename "$file")
    ln -f -v "$file" "$HOME/$basename" | tee -a "$log_file"
  done
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

main() {
    echo '=================== BEGIN CONFIG FILE INSTALLATION ===================' | tee -a "$log_file"
    # install_external_fonts
    install_shell_configuration
    install_terminal_emulator_configuration
    install_tmux_configuration
    install_vim_configuration
    install_neovim_configuration
    echo '=================== END CONFIG FILE INSTALLATION =====================' | tee -a "$log_file"
}

main
