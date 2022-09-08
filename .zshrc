export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.local/bin:$PATH"

ZSH_THEME="agnoster"

plugins=(
  themes
  cp
  sudo
  vi-mode
  git
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

# Autojump
[[ -s /usr/share/autojump/autojump.zsh ]] && source /usr/share/autojump/autojump.zsh

export EDITOR='vim'

# TODO update
alias updaterc="wget https://raw.githubusercontent.com/Gobidev/dotfiles/main/.zshrc -O ~/.zshrc &>/dev/null && echo 'Update successful'"

# source aliasrc for aliases
source ~/.dotfiles/aliasrc

# more aliases for ctfs, disabled most of the time
#source ~/.dotfiles/ctfrc

echo
pfetch
