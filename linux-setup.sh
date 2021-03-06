# Update Ubuntu
echo "Updating Ubuntu"
sudo apt update && sudo apt upgrade 

# Installing Dependencies
echo "Installing Dependencies"

## Install Node and Yarn
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

## Install other dependencies
sudo apt-get install expect curl git python libpq-dev zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev nodejs unzip zip whois bat ack-grep fd fzf silversearcher-ag

## Install snap for software applications download
sudo apt install firefox i3 filezilla kleopatra

### Brave Browser
sudo apt install apt-transport-https curl gnupg
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser

# Setup Postgres
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -sc)-pgdg main" > /etc/apt/sources.list.d/PostgreSQL.list'
sudo apt update
sudo apt install postgresql-13
sudo service postgresql start
sudo -u postgres createuser $(whoami) -s

# Install Tmux
sudo apt-get install automake bison pkg-config libevent-dev libncurses5-dev
rm -rf /tmp/tmux
git clone https://github.com/tmux/tmux.git /tmp/tmux
cd /tmp/tmux
git checkout master
sh autogen.sh
./configure && make
sudo make install
cd
rm -rf /tmp/tmux

# Cleanup
sudo apt remove cmdtest
sudo apt autoremove

