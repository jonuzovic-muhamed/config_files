#!/bin/bash

function install_fonts {
  for file in fonts/* ; do
    echo "Started installing font $file"
    filename="${file##*/}"
    basename="${filename%.*}"
    mkdir /tmp/$basename
    unzip $file -d /tmp/$basename &> /dev/null
    mkdir -p ~/.local/share/fonts/
    cp -v /tmp/$basename/*.ttf ~/.local/share/fonts/
    rm -rf /tmp/$basename
    echo "Finished installing font $file"
    fc-cache -f -v &> /dev/null
  done
}

function configure_shell {
  echo "Adding configuration files for Shell"
  for config_file in ./shell/.* ; do
    filename="${config_file##*/}"
    basename="${filename%.*}"
    cp -v $config_file ~/$basename
  done
}

function configure_terminal_emulators {
  echo "Adding configuration files for terminal emulators"
  for dir in ./terminal_emulators/* ; do
    dir_name="${dir##*/}"
    basename="${dir_name%.*}"
    mkdir -p ~/.config/$basename
    cp -r -v $dir ~/.config/$basename
  done
}

function configure_tmux {
  echo "Adding configuration files for tmux"
  cp -v ./tmux/.tmux.conf ~/.tmux.conf
  for file in ./tmux/.tmux/* ; do
    filename="${file##*/}"
    basename="${filename%.*}"
    cp -r -v $file ~/.tmux/$filename
  done
}

function configure_vim {
  echo "Adding configuration files for vim"
  for file in ./vim/.* ; do
    filename="${file##*/}"
    basename="${filename%.*}"
    cp -r -v $file ~/$filename
  done
}

install_fonts
configure_shell
configure_terminal_emulators
configure_tmux
configure_vim
