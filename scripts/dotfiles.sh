########### dotfiles Installation ###########
# create symlink of dotfiles, backup existing files if present
# usage: install_file [source_file] <destination_file>
install_file() {
  # set source file
  src="$1"

  # check if destination is set, set to default if not
  if [ -n "$2" ]; then
    dest="$2"
  else
    dest="$HOME/$1"
  fi

  # create target dir if not present
  mkdir -p "$(dirname "$dest")"

  [ ! -L "$dest" ] || rm "$dest"             # if destination is symlink, delete it
  [ ! -e "$dest" ] || mv "$dest" "$dest".old # if destination is file, create backup

  # create symlink
  echo "Linking '$PWD/$src' to '$dest'"
  ln -s "$PWD/$src" "$dest"
}
