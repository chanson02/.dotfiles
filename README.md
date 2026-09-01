# Dotfiles

## Installation

1. `git clone https://github.com/chanson02/.dotfiles.git ~/.dotfiles`
2. `~/.dotfiles/scripts/install_all.sh`

Each config directory is symlinked into place (rather than copied) so changes applied here are reflected live in `~/.config`, and vice versa.

## SSH (personal + work)

Git credentials are split between personal and work:

- **Personal** identity lives in `config/.gitconfig`.
- **Work** identity lives in `config/gitconfig.calamp`.

Running git commands in a subdirectory of `~/Documents/CalAmp` will automatically use `bitbucket.org-calamp` as the host. Example `~/.ssh/config`:

```sshconfig
Host bitbucket.org
  HostName bitbucket.org
  User git
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_ed25519

Host bitbucket.org-calamp
  HostName bitbucket.org
  User git
  AddKeysToAgent yes
  IdentityFile ~/.ssh/calamp-bb
```

## Shell utilities (`bash_tools/`)

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
