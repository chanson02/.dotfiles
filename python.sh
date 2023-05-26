home=$(getent passwd ${SUDO_USER:-$USER} | cut -d: -f6) # home dir

apt-get update
apt-get install -y git curl build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl

git clone https://github.com/pyenv/pyenv.git $home/.pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $home/.dotfiles/bash_vars.sh
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> $home/.dotfiles/bash_vars.sh
echo 'eval "$(pyenv init --path)"' >> $home/.dotfiles/bash_vars.sh
echo 'eval "$(pyenv virtualenv-init -)"' >> $home/.dotfiles/bash_vars.sh
source $home/.bashrc

#bash $home/.pyenv/bin/pyenv install $version
#bash $home/.pyenv/bin/pyenv global $version
