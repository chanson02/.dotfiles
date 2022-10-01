# Download rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc

# Download ruby installer
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc

# Don't wait for shell restart
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

# install latest ruby/rails versions
latest=$(rbenv install -l | grep -v - | tail -1)
rbenv install $latest
rbenv global $latest

gem install bundler
gem install rails
rbenv rehash

# Forward port 80 to rails (3000)
# iptables -t nat -I PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 3000
