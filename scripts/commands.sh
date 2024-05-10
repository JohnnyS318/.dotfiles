# function to check if command exists and exit if not
command_check() {
  command -v "$1" > /dev/null || { echo "$1 not found, please install first" && exit 1; }
}
