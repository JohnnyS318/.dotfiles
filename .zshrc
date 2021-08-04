export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.local/bin:$PATH"

ZSH_THEME="agnoster"

plugins=(
  git
  themes
  alias-finder
  cp
  gitfast
  sudo
  vi-mode
  vscode
  zsh-autosuggestions
  zsh-syntax-highlighting
)

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=1

source $ZSH/oh-my-zsh.sh

typeset -gA ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[arg0]=fg=4
ZSH_HIGHLIGHT_STYLES[command]=fg=4
ZSH_HIGHLIGHT_STYLES[alias]=fg=4
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=4
ZSH_HIGHLIGHT_STYLES[precommand]=fg=4,bold
ZSH_HIGHLIGHT_STYLES[builtin]=fg=6,bold
ZSH_HIGHLIGHT_STYLES[default]=fg=12
ZSH_HIGHLIGHT_STYLES[path]=fg=12
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=5
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=208,bold
ZSH_HIGHLIGHT_STYLES[assign]=fg=14

export EDITOR='vim'

# general Aliases
alias btop="bpytop"
alias r="ranger"
alias tmux="tmux -2"
alias cp="cpv -iv"
alias mv="mv -iv"
alias rm="rm -v"

alias updaterc="wget https://raw.githubusercontent.com/Gobidev/dotfiles/main/.zshrc -O ~/.zshrc &>/dev/null && echo 'Update successful'"

# wireguard aliases
alias wg0="sudo systemctl stop wg-quick@wg1 && sudo systemctl start wg-quick@wg0"
alias wg1="sudo systemctl stop wg-quick@wg0 && sudo systemctl start wg-quick@wg1"

# clipboard aliases
command -v xclip >/dev/null && { alias setclip="xclip -selection c" && alias getclip="xclip -selection c -o" }
command -v wl-copy >/dev/null && { alias setclip="wl-copy" && alias getclip="wl-paste" }

# ctf aliases
rs() {
  rustscan -b 5000 -a "$1" -- -A | tee rustscan.txt
}

grip() {
  grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' $1
}

gettun() {
  echo "$(ip a s tun0 | grip)"
}

cptun() {
  gettun | setclip
}

newctf() {
  target_name="$1"
  myip="$(gettun)"

  mkdir "$target_name"
  echo "# $target_name\n\nMy IP:         $myip\nTarget IP:     " > "$target_name"/notes.md
}

alias gob="gobuster dir -w /usr/share/dirbuster/directory-list-2.3-medium.txt -o gobuster.txt -u"
alias ferb="feroxbuster -o feroxbuster.txt -u"
alias nik="nikto -o '$(pwd)'/nikto.txt -h"

echo
pfetch
