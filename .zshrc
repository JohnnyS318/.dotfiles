export ZSH="$HOME/.oh-my-zsh"
ZSH_DISABLE_COMPFIX=true

ZSH_THEME="agnoster"

plugins=(
  git
  themes
  alias-finder
  archlinux
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

alias btop="bpytop"
alias r="ranger"
alias tmux="tmux -2"
alias cp="cpv -iv"
alias mv="mv -iv"
alias rm="rm -v"
alias wg0="sudo systemctl stop wg-quick@wg1 && sudo systemctl start wg-quick@wg0"
alias wg1="sudo systemctl stop wg-quick@wg0 && sudo systemctl start wg-quick@wg1"

echo
pfetch
