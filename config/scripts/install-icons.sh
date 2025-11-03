#!/usr/bin/env bash
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  echo "call with the theme name otherwise the default is onedark"
  echo "currently supportet themes are"
  echo $(ls ~/dotfiles/theme/system-theme/themes| sed 's/.....$//')
  exit 0
fi


echo "setting color scheme"
theme="$1"
cd ~/dotfiles/theme/system-theme
if [ -z "$theme" ]; then
  nix-shell default.nix --argstr schemeName catppuccin --run 'cp colors.toml ../../.dotter'
fi
 nix-shell default.nix --run 'cp colors.toml ../../.dotter'
 cp colors.toml ../colors.toml 

echo "installing cursor theme"
cd ~/dotfiles/theme/cursor_theme
rm -rf ../icons/Bibata
nix develop -c bash -c "accurse Bibata/metadata.toml && exit" >/dev/null 
mv AC-Bibata ../icons/Bibata

echo "applaying dconf settings"
dconf load / < ~/dotfiles/theme/dconf/settings.ini
