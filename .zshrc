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
ctf_interface="tun0"

rs() {
  if [[ "$1" != "" ]]; then
    target_ip="$1"
  fi
  rustscan -b 2000 --ulimit 5000 -a "$target_ip" -- -A | tee rustscan.log
}

grip() {
  grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' $1
}

getip() {
  echo "$(ip a s $ctf_interface | grip)"
}

cpip() {
  getip | setclip
}

newctf() {
  target_name="$1"
  target_name_upper="$(tr '[:lower:]' '[:upper:]' <<< ${target_name:0:1})${target_name:1}"
  target_ip="$2"
  my_ip="$(getip)"

  mkdir "$target_name" && cd "$target_name"
  echo "# $target_name_upper\n\nMy IP:         $my_ip\nTarget IP:     $target_ip\n\n" > notes.md
  echo "$target_ip" > target_ip
}

sett() {
  target_ip="$1"
}

genrev() {
  if [[ "$2" != "" ]]; then
    rev_port="$2"
  else
    rev_port="9999"
  fi
  echo "$(pms -i $(getip) -p $rev_port -s -t $1)"
}

genrevc() {
  revshell="$(genrev $@)"
  echo "$revshell" && setclip "$revshell"
}

revpayload() {
  echo "#!/bin/sh\n$(genrev $@)" > payload
  python -m http.server
}

alias gob="gobuster dir -w /usr/share/dirbuster/directory-list-2.3-medium.txt -o gobuster.log -u"
alias gobt="gobuster dir -w /usr/share/dirbuster/directory-list-2.3-medium.txt -o gobuster.log -u http://$target_ip"
alias ferb="feroxbuster -o feroxbuster.log -u"
alias ferbt="feroxbuster -o feroxbuster.log -u https://$target_ip"
alias nik="nikto -o '$(pwd)'/nikto_log.txt -h"
alias nikt="nikto -o '$(pwd)'/nikto_log.txt -h http://$target_ip"
alias pnt="ping $target_ip"
alias up="python -m http.server"

if test -f target_ip; then
  target_ip="$(cat target_ip)"
fi

# pfetch
echo
pfetch
