#!/usr/bin/env bash
echo "installing cursor theme"
cd ~/dotfiles/theme/cursor_theme
rm -rf ../icons/Bibata
nix develop -c bash -c "accurse Bibata/metadata.toml && exit" >/dev/null 
mv AC-Bibata ../icons/Bibata

echo "applaying dconf settings"
dconf load / < ~/dotfiles/theme/dconf/settings.ini
