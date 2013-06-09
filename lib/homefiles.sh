#!/usr/bin/env bash
VERSION="v.0.0.1 (2013-06-08)"

usage() {
cat <<-EOS
Usage:
  homefiles [status]
  homefiles install
Version:
  $VERSION
EOS
}

gitstatus() {
  git status
}

install_dotfiles() {
  files="$(find $PWD/dotfiles -mindepth 1 -maxdepth 1)"
  for file in $files; do
    local syml="$HOME/.$(basename $file)"
    local args=""
    mkdir -p backups
    if [ -L $syml ]; then
      [[ $(readlink $syml) == $file ]] && continue
      args+="-f"
    elif [ -e $syml ]; then
      mv $syml backups/$(basename $syml)
    fi
    ln -s $args $file $syml && echo "Linked $(basename $syml)"
  done
  e_success "Installation complete"
  e_error "Goto $BASH_SOURCE"
}

# https://github.com/cowboy/dotfiles/blob/master/bin/dotfiles#L19-L22
e_header()  { echo -e "\n\033[1m$@\033[0m"; }
e_success() { echo -e " \033[1;32m✔\033[0m  $@"; }
e_error()   { echo -e " \033[1;31m✖\033[0m  $@"; }
e_arrow()   { echo -e " \033[1;33m➜\033[0m  $@"; }

case "$1" in
ins*)    shift; install_dotfiles $@;;
sta*|"") shift; gitstatus $@;;
*)       shift; usage $@;;
esac
