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
