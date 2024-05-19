#!/bin/sh

# script to automatically install dotfiles, should be run from project root
# based on https://github.com/RubixDev/.dotfiles/blob/main/install.sh

# check if current directory is dotfiles repo and exit if not
[ "$(basename "$PWD")" = .dotfiles ] || {
  echo "Please run this script from your .dotfiles project root"
  exit 1
}

source ./scripts/utils.sh # include the common install functions

# check for critical dependencies
command_check git
command_check curl
command_check zsh

########### ZSH ###########

# install oh-my-zsh if not installed
# [ -e "${ZSH:-$HOME/.oh-my-zsh}" ] || {
#   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || exit 2
#   rm ~/.zshrc
# }

# install zsh plugins used in .zshrc
# install_zsh_custom plugins z-shell F-Sy-H
# install_zsh_custom plugins zsh-users zsh-syntax-highlighting
# install_zsh_custom plugins zsh-users zsh-autosuggestions
# install_zsh_custom plugins marlonrichert zsh-autocomplete
# install_zsh_custom themes romkatv powerlevel10k
# install_file .oh-my-zsh/custom/themes/agnoster-custom.zsh-theme
#install_zsh_custom plugins jeffreytse zsh-vi-mode # default oh-my-zsh plugin

install_file .zshrc
install_file .config/env
install_file .config/aliasrc
install_file .config/ctfrc
install_file .config/localrc
install_file .p10k.zsh

########### GPG Install ###########
install_file .gnupg/gpg.conf
install_file .gnupg/gpg-agent.conf
chmod 600 ~/.gnupg/gpg.conf

########### OTHER DOTFILES ########
install_file .gitconfig

install_file .config/tmux/tmux.conf
install_file .config/paru/paru.conf
install_file .config/btop/btop.conf
install_file .config/alacritty/alacritty.toml
install_file .config/kitty/kitty.conf
install_file .config/kitty/theme.conf
install_file .config/wezterm/wezterm.lua
install_file .config/terminator/config
install_file .config/stylua/stylua.toml

install_file .config/lf
install_file .config/joshuto
install_file .config/nvim

# install custom zsh theme

install_file .gdbinit

install_file .config/discord/settings.json
