#!/bin/bash
echo "installing dependancies" 
sudo apt install git curl 

echo "installing xz" 
git clone https://github.com/tukaani-project/xz
cd xz
Cmake .
make
sudo mv xz /usr/bin/
cd ..
rm -rf xz

echo "installing nix..."
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
. /etc/profile.d/nix.sh

echo "installing home-manager" 
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

echo "cloning and installing dotfiles" 
git clone https://github.com/zwartemees/dotfiles.git ~/dotfiles
mkdir -p ~/.config/home-manager
ln -sf ~/dotfiles/home.nix ~/.config/home-manager/home.nix
home-manager switch
