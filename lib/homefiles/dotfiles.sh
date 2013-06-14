#!/usr/bin/env bash

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
}
