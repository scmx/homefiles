#!/usr/bin/env zsh
# For installing github.com/sorin-ionescu/prezto
setopt EXTENDED_GLOB
for rcfile in $(dirname $(dirname $0))/dotfiles/zprezto/runcoms/^README.md(.N); do
  filepath="${ZDOTDIR:-$HOME}/.${rcfile:t}"
  [ -L $filepath ] && unlink $filepath
  ln -s "$rcfile" "$filepath"
done
