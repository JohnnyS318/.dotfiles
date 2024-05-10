# install custom zsh plugin to omz. OMZ must be installed first
install_zsh_custom() {
  [ -e "${ZSH_CUSTOM:-${ZSH:-$HOME/.oh-my-zsh}/custom}/$1/$3" ] || {
    git clone --depth=1 "https://github.com/$2/$3" \
      "${ZSH_CUSTOM:-${ZSH:-$HOME/.oh-my-zsh}/custom}/$1/$3"
  }
}
