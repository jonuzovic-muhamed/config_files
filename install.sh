#!/bin/bash

# Font Installation

function install_fonts {
  for file in fonts/* ; do
    echo "Started installing font $file"
    filename="${file##*/}"
    basename="${filename%.*}"
    mkdir /tmp/$basename
    unzip $file -d /tmp/$basename &> /dev/null
    mkdir -p ~/.local/share/fonts/
    mv /tmp/$basename/*.ttf ~/.local/share/fonts/
    rm -rf /tmp/$basename
    echo "Finished installing font $file"
    fc-cache -f -v &> /dev/null
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

install_fonts
configure_terminal_emulators

