#!/bin/sh

# script to automatically install dotfiles, should be run from project root
# based on https://github.com/RubixDev/.dotfiles/blob/main/install.sh

# check if current directory is dotfiles repo and exit if not
[ "$(basename "$PWD")" = .dotfiles ] || {
	echo "Please run this script from your .dotfiles project root"
	exit 1
}

# user prompt with default option yes
prompt() {
	printf '%s [Y/n] ' "$1"
	read -r choice
	case "$choice" in
	[Yy][Ee][Ss] | [Yy] | '') return 0 ;;
	*) return 1 ;;
	esac
}

# user prompt with default option no
promptn() {
	printf '%s [y/N] ' "$1"
	read -r choice
	case "$choice" in
	[Yy][Ee][Ss] | [Yy]) return 0 ;;
	*) return 1 ;;
	esac
}

# function to check if command exists and exit if not
command_check() {
	command -v "$1" >/dev/null || { echo "$1 not found, please install first" && exit 1; }
}

# check for critical dependencies
command_check git
command_check curl
command_check zsh

########### Oh My ZSH ###########
# install oh-my-zsh if not installed
[ -e "${ZSH:-$HOME/.oh-my-zsh}" ] || {
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || exit 2
	rm ~/.zshrc
}

# function to install custom zsh plugins
install_zsh_custom() {
	[ -e "${ZSH_CUSTOM:-${ZSH:-$HOME/.oh-my-zsh}/custom}/$1/$3" ] || {
		git clone --depth=1 "https://github.com/$2/$3" \
			"${ZSH_CUSTOM:-${ZSH:-$HOME/.oh-my-zsh}/custom}/$1/$3"
	}
}

# install zsh plugins used in .zshrc
install_zsh_custom plugins zsh-users zsh-autosuggestions
install_zsh_custom plugins zsh-users zsh-syntax-highlighting
#install_zsh_custom plugins jeffreytse zsh-vi-mode

########### dotfiles Installation ###########
# create symlink of dotfiles, backup existing files if present
# usage: install_file [source_file] <destination_file>
install_file() {
	# set source file
	src="$1"

	# check if destination is set, set to default if not
	if [ -n "$2" ]; then
		dest="$2"
	else
		dest="$HOME/$1"
	fi

	# create target dir if not present
	mkdir -p "$(dirname "$dest")"

	[ ! -L "$dest" ] || rm "$dest"             # if destination is symlink, delete it
	[ ! -e "$dest" ] || mv "$dest" "$dest".old # if destination is file, create backup

	# create symlink
	echo "Linking '$PWD/$src' to '$dest'"
	ln -s "$PWD/$src" "$dest"
}

########### GPG Install ###########
install_file .gnupg/gpg.conf
install_file .gnupg/gpg-agent.conf
chmod 600 ~/.gnupg/gpg.conf

# remove SpaceVim if installed
[ -e ~/.SpaceVim ] && {
	curl -sLf https://spacevim.org/install.sh | bash -s -- --uninstall
	rm -rf ~/.SpaceVim
}
# create symlinks of dotfiles
install_file .zshrc
install_file .gitconfig

install_file .config/env
install_file .config/aliasrc
install_file .config/ctfrc
install_file .config/localrc

install_file .config/tmux/tmux.conf
install_file .config/paru/paru.conf
install_file .config/btop/btop.conf
install_file .config/alacritty/alacritty.yml
install_file .config/kitty/kitty.conf
install_file .config/kitty/theme.conf
install_file .config/wezterm/wezterm.lua
install_file .config/terminator/config
install_file .config/stylua/stylua.toml

install_file .config/lf
install_file .config/joshuto
install_file .config/nvim

install_file .config/BetterDiscord/themes/nocturnal_gruvbox.theme.css

# install custom zsh theme
install_file .oh-my-zsh/custom/themes/agnoster-custom.zsh-theme

install_file .gdbinit

if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
	echo "installed powerlevel10k"
	echo "Run p10k configure"
else
	echo "p10k already installed"
fi