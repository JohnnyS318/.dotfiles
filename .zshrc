
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
  kubectl #kubectl completion
  helm #helm completion
  vi-mode   # vi-keybinds
  kubectl
  
  # have to be installed externally, handled by install.sh
  zsh-autocomplete
  zsh-syntax-highlighting
  F-Sy-H
  #fast-syntax-highlighting #faster=better
  zsh-autosuggestions
)


#load oh-my-zsh
source $ZSH/oh-my-zsh.sh

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
bindkey '^E' autosuggest-accept
bindkey '^J' autosuggest-accept

#revert back to default history ↑ and ↓.
# () {
#    local -a prefix=( '\e'{\[,O} )
#    local -a up=( ${^prefix}A ) down=( ${^prefix}B )
#    local key=
#    for key in $up[@]; do
#       bindkey "$key" up-line-or-history
#    done
#    for key in $down[@]; do
#       bindkey "$key" down-line-or-history
#    done
# }

# Autojump
[[ -s /usr/share/autojump/autojump.zsh ]] && source /usr/share/autojump/autojump.zsh

#node version manager
[[ -s /usr/share/nvm/init-nvm.sh ]] && source /usr/share/nvm/init-nvm.sh 2> /dev/null

# source aliasrc for aliases
source ~/.config/aliasrc

# source localrc for local config and tokens not shared to git
source ~/.config/localrc 2> /dev/null

# launch gpg agent for gpg ssh keys if installed
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
command -v gpgconf >/dev/null && gpgconf --launch gpg-agent

#add go path if installed
command -v go > /dev/null && export PATH="$(go env GOPATH)/bin:$PATH"

#pnpm setup
export PNPM_HOME="/home/jonas/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $HOME/.p10k.zsh ]] || source $HOME/.p10k.zsh
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# run pfetch after initialization if installed
echo
command -v pfetch >/dev/null && pfetch

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/vault vault
