#!/bin/bash
echo "installing dependancies" 
sudo apt install git curl 

echo "installing xz" 
git clone https://github.com/tukaani-project/xz
cd xz
cmake .
make
sudo mv xz /usr/bin/
cd ..
rm -rf xz

echo "installing nix..."
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon

if [[ "$(ps -p 1 -o comm=)" == *"init"* ]]; then
    echo "System is not using init not systemd you might experience problems with nix"
    echo "trying to install daemon"

    sudo mv ~/dotfiles/daemon/nix-daemon /etc/init.d/nix-daemon
    sudo chmod +x /etc/init.d/nix-daemon
    sudo update-rc.d nix-daemon defaults
    sudo service nix-daemon start
fi

echo "cloning and installing dotfiles" 
rm -rf ~/dotfiles
git clone https://github.com/zwartemees/dotfiles.git ~/dotfiles
cd dotfiles
. /etc/profile.d/nix.sh
nix-env -irf packages.nix
dotter deploy -f
./scripts/setShell.sh
