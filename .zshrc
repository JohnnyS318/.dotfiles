# source environment variables
source ~/.config/env

# set zsh theme
ZSH_THEME="agnoster"

# enable oh-my-zsh plugins
plugins=(
  cp  # define cpv command that uses rsync
  sudo  # press double escape to add sudo to command
  vi-mode   # vi-keybinds
  git   # git aliases
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# configure autosuggest plugin
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=1

# load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# customize syntax highlighting colors
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
DISABLE_MAGIC_FUNCTIONS=1

# Autojump
[[ -s /usr/share/autojump/autojump.zsh ]] && source /usr/share/autojump/autojump.zsh

# TODO update
alias updaterc="wget https://raw.githubusercontent.com/Gobidev/dotfiles/main/.zshrc -O ~/.zshrc &>/dev/null && echo 'Update successful'"

# source aliasrc for aliases
source ~/.config/aliasrc

# more aliases for ctfs, disabled most of the time
#source ~/.config/ctfrc

echo
pfetch
