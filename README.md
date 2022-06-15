# Welcome to my homefiles

This is my set-up for having a version controlled home directory. I use Neovim,
Tmux, Zsh, iTerm and lots of little scripts. It contains all relevant
configuration and everything else is in `.gitignore`. I manage it with the
`homefiles` script via my `h` alias (see `~/.zshrc`).

## How to create your own homefiles

First you need a bare git repository in another location, because having
`~/.git` makes it problematic to have any other git repositories in home
directory. I would recommend `~/Dev/homefiles.git`

```sh
cd ~/Dev
git init --bare homefiles.git
```

Then you need a good `.gitignore` to ignore everything that shouldn't be
tracked by git. You can take a look at mine here.

After that you need a git wrapper script that sets GIT_WORK_TREE to $HOME and
GIT_DIR to your bare repository. This is what the `homefiles` script does.
Personally I use an alias called `h` and for normal git I use `g`.

### `homefiles` script

`~/.bin/homefiles`

```sh
#!/usr/bin/env sh

set -euo pipefail

export GIT_WORK_TREE=$HOME
export GIT_DIR=$HOME/Dev/homefiles.git

dark_gray='\033[1;30m'
reset='\033[0m'
echo "${dark_gray}Using $GIT_DIR${reset}"

case "${1:-}" in
  "")
    git status -bs
    ;;
  *)
    git "$@"
    ;;
esac
```

#### How to use

- Status: `homefiles`
- Diff: `homefiles diff`
- Add `homefiles add`

And you can use any other git command or alias like normal

## Persist your homefiles

Create a personal git repo.
And then add a git remote.

```sh
git remote add origin your-git-repo-url`
git fetch
```

## Privacy & Security

You may want to consider whether you want to keep your repo private or not.
There are dotfiles management tools that allow you to have some parts private
and other parts public. With this set-up you need to:

- Decide if your repo should be public or not
- Maintain your `.gitignore` so that you don't expose any sensitive files
- You could set up `~/.*.local` files for many tools to keep sensitive data in
  and make these load it they exist. For example `.zshrc.local`

```sh
# For private environment variables etc
if [[ -f ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi
```

And put `~/.zshrc.local` in `~/.gitignore`.
