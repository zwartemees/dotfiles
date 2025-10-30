#!/usr/bin/env bash
echo "installing cursor theme"
rm -rf ~/.local/share/icons/Bibata
cd ~/dotfiles/theme/cursor_theme
nix develop -c bash -c "accurse Bibata/metadata.toml && exit" >/dev/null 
mv AC-Bibata ../icons/Bibata

echo "applaying dconf settings"
dconf load / < ~/dotfiles/theme/dconf/settings.ini
