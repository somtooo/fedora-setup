#!/bin/bash

# ------------------------------------
# Install updates:
# ------------------------------------

sudo apt update && sudo apt dist-upgrade -y


# ------------------------------------
# Install dev tools and some themes:
# ------------------------------------

sudo apt install -y \
openjdk-8-jdk-headless \
openjdk-11-jdk-headless \
maven \
golang-go \
python3-minimal \
build-essential \
apt-transport-https \
ca-certificates \
curl \
software-properties-common \
apache2-utils \
make \
chromium-browser \
gnome-tweak-tool \
gnome-shell-extensions \
python3-pip \
libgconf-2-4 \
code \
arc-theme


# ------------------------------------
# Add Flathub.org as a Flatpak repo
# ------------------------------------

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo


# ------------------------------------
# Install NodeJS:
# ------------------------------------

curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt install -y nodejs
echo "fs.inotify.max_user_watches=10000000" | sudo tee -a /etc/sysctl.conf


# ------------------------------------
# Install .NET Core and turn off .NET Core telemetry:
# ------------------------------------

echo "export DOTNET_CLI_TELEMETRY_OPTOUT=true" >> ~/.profile
wget -q https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt update && sudo apt install dotnet-sdk-3.1 dotnet-sdk-6.0 -y
rm -f packages-microsoft-prod.deb
dotnet --version


# ------------------------------------
# Install Docker and Docker Compose:
# ------------------------------------

sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

# Running "sudo apt-key fingerprint 0EBFCD88" should display:

# pub   rsa4096 2017-02-22 [SCEA]
#       9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
# uid           [ unknown] Docker Release (CE deb) <docker@docker.com>
# sub   rsa4096 2017-02-22 [S]

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install -y docker-ce
docker --version

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

sudo usermod -aG docker $USER


# ------------------------------------
# Install Postman:
# ------------------------------------

# sudo apt install libgconf-2-4
# cd ~/Downloads
# wget https://dl.pstmn.io/download/latest/linux64 -O postman.tar.gz
# sudo tar -xzf postman.tar.gz -C /opt
# sudo ln -s /opt/Postman/Postman /usr/bin/postman

# cat > ~/.local/share/applications/postman.desktop <<EOL
# [Desktop Entry]
# Encoding=UTF-8
# Name=Postman
# Exec=postman
# Icon=/opt/Postman/app/resources/app/assets/icon.png
# Terminal=false
# Type=Application
# Categories=Development;
# EOL

### Alternative postman install from Flathub
sudo flatpak install flathub com.getpostman.Postman


# ------------------------------------
# Install GitHub CLI tools:
# ------------------------------------

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
sudo apt-add-repository https://cli.github.com/packages
sudo apt update
sudo apt install gh


# ------------------------------------
# Install VLC:
# ------------------------------------

sudo apt install -y vlc
sudo apt install -y libavcodec-extra libdvd-pkg
sudo dpkg-reconfigure libdvd-pkg