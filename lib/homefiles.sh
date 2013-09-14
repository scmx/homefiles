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

source lib/homefiles/dotfiles.sh
source lib/homefiles/binfiles.sh

install_files() {
  install_dotfiles
  install_binfiles
  e_success "Installation complete"
}

# https://github.com/cowboy/dotfiles/blob/master/bin/dotfiles#L19-L22
e_header()  { echo -e "\n\033[1m$@\033[0m"; }
e_success() { echo -e " \033[1;32m✔\033[0m  $@"; }
e_error()   { echo -e " \033[1;31m✖\033[0m  $@"; }
e_arrow()   { echo -e " \033[1;33m➜\033[0m  $@"; }

case "$1" in
ins*)    shift; install_files $@;;
sta*|"") shift; gitstatus $@;;
*)       shift; usage $@;;
esac
