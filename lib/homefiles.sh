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
  echo "Installation complete"
}

case "$1" in
ins*)    shift; install_dotfiles $@;;
sta*|"") shift; gitstatus $@;;
*)       shift; usage $@;;
esac
