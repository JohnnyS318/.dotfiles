#!/bin/sh

# script to automatically install dotfiles, should be run from project root
# based on https://github.com/RubixDev/.dotfiles/blob/main/install.sh

# check if current directory is dotfiles repo and exit if not
[ "$(basename "$PWD")" = .dotfiles ] || {
  echo "Please run this script from your .dotfiles project root"
  exit 1
}

. ./scripts/utils.sh # include the common install functions

command_check git
command_check curl
command_check zsh

install_file .zshrc
install_file .config/env
install_file .config/aliasrc
install_file .config/ctfrc
install_file .config/localrc
install_file .p10k.zsh
install_file .config/starship.toml

# OTHERS
install_file .config/joshuto
