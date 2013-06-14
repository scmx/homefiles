#!/usr/bin/env bash

install_binfiles() {
  folders="$(find $PWD/binfiles -mindepth 1 -maxdepth 1)"
  for folder in $folders; do
    local syml="$HOME/bin/$(basename $folder)"
    local args=""
    mkdir -p backups
    if [ -L $syml ]; then
      [[ $(readlink $syml) == $folder/bin/$(basename $folder) ]] && continue
      args+="-f"
    elif [ -e $syml ]; then
      mv $syml backups/$(basename $syml)
    fi
    if ln -s $args $folder/bin/$(basename $folder) $syml; then
      echo "Linked $(basename $syml)"
    fi
  done
}
