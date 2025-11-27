#!/usr/bin/env bash
if [[ "$1" == "-h" || "$1" == "--help" || -z "$1" ]]; then
  echo "call with the theme name"
  echo "currently supported themes are"
  echo $(ls ~/dotfiles/theme/system-theme/themes| sed 's/.....$//')
  exit 0
fi

theme="$1"

echo "setting color scheme"
cd ~/dotfiles/theme/system-theme
nix-shell default.nix --argstr schemeName "$theme" --run 'cp colors.toml ../../.dotter'
cp colors.toml ../colors.toml 

echo "installing cursor theme"
cd ~/dotfiles/theme/cursor_theme
rm -rf ../icons/Bibata
nix develop -c bash -c "accurse Bibata/metadata.toml && exit" >/dev/null 
mv AC-Bibata ../icons/Bibata

echo "applaying dconf settings"
dconf load / < ~/dotfiles/theme/dconf/settings.ini

echo "deploying now"
cd ~/dotfiles
dotter deploy -f -y
