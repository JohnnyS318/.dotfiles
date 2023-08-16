# source environment variables
source ~/.config/env

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# set zsh theme
ZSH_THEME="powerlevel10k/powerlevel10k" # modified version of agnoster theme, source in dotfiles repo

# enable oh-my-zsh plugins
plugins=(
  # default oh-my-zsh plugins
  cp  # define cpv command that uses rsync
  sudo  # press double escape to add sudo to command
  git   # git aliases
  # have to be installed externally, handled by install.sh
  vi-mode   # vi-keybinds
  zsh-autosuggestions
  zsh-syntax-highlighting
  kubectl-autocomplete
)

# configure autosuggest plugin
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=1
bindkey '^I' autosuggest-accept

# disable zsh update prompt
DISABLE_AUTO_UPDATE=true

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
zstyle ':bracketed-paste-magic' active-widgets '.self-*'

# Autojump
[[ -s /usr/share/autojump/autojump.zsh ]] && source /usr/share/autojump/autojump.zsh

# source aliasrc for aliases
source ~/.config/aliasrc

# launch gpg agent for gpg ssh keys if installed

export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
command -v gpgconf >/dev/null && gpgconf --launch gpg-agent

#rust
source "$HOME/.cargo/env"

# more aliases for ctfs, disabled most of the time
#source ~/.config/ctfrc

# run pfetch after initialization if installed
#echo
#command -v pfetch >/dev/null && pfetch

export PATH="$(go env GOPATH)/bin:$PATH"

# pnpm
export PNPM_HOME="/home/jonas/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm edit

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

export KEYID=0x1B95684041835F5F
export PATH="$PATH:/home/jonas/.local/share/JetBrains/Toolbox/scripts"
