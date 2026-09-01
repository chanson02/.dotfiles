# Dotfiles

## Installation

1. `git clone https://github.com/chanson02/.dotfiles.git ~/.dotfiles`
2. `~/.dotfiles/scripts/install_all.sh`

Each config directory is symlinked into place (rather than copied) so changes applied here are reflected live in `~/.config`, and vice versa.

The `config/` directory holds symlinks to the app dirs to deploy (`nvim`, `ghostty`, `hypr`, `gitconfig`). `scripts/install_link.sh` walks it and links each entry into `~/.config` (and `gitconfig` into `~/.gitconfig`). To add an app, drop a symlink in `config/`.

*NOTE*: If you're someone other than me, change the `gitconfig` file.

## Shell utilities (`bash_tools/`)

Omarchy already provides starship, zoxide, fzf, eza, bat, btop, and mise out of the box. The `bash_tools/` scripts are personal utilities for project-specific workflows.

- `init_psql` — create a Postgres database + user from `config/database.yml`
- `kill_rails` — stop a Rails server running from current directory
- `pull_heroku_psql` — pull a Heroku Postgres backup into `config/database.yml`
- `push_heroku_psql` — push database from `config/database.yml` into Heroku
- `mic_monitor` — pipe mic input to output (monitor headset)
- `add_to_bashrc` — append a line to `~/.bashrc` if not already present

Discover the full list with `ls ~/.dotfiles/bash_tools`.

## Neovim

- `nvim/` uses native `vim.pack`, locked via `nvim-pack-lock.json`
- Install language servers via `:Mason`

## Runtimes & tooling

`install_mise.sh` sets global defaults (Python 3.12, Ruby 3.3) via mise and installs `uv` for Python venv/package management. `install_psql.sh` installs Postgres and the heroku CLI (needed by the `bash_tools` psql/heroku helpers).
