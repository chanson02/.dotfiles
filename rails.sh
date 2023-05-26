home=$(getent passwd ${SUDO_USER:-$USER} | cut -d: -f6) # home dir

apt-get update
apt-get install -y git curl libssl-dev libreadline-dev zlib1g-dev

# Download rbenv
git clone https://github.com/rbenv/rbenv.git $home/.rbenv
chmod -R 777 $home/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> $home/.dotfiles/bash_vars.sh
echo 'eval "$(rbenv init -)"' >> $home/.dotfiles/bash_vars.sh
source $home/.bashrc

# Download ruby installer
git clone https://github.com/rbenv/ruby-build.git $home/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> $home/.dotfiles/bash_vars.sh

# install latest ruby/rails versions
latest=$(rbenv install -l | grep -v - | tail -1)
rbenv install $latest
rbenv global $latest

gem install bundler
gem install rails
rbenv rehash

# Forward port 80 to rails (3000)
# iptables -t nat -I PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 3000
