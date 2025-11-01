
to install clone this repo then run 
```bash
dotter deploy -f
sudo nixos-rebuild switch --flake .#nixos
```
the sddm theme is a modified catppuccin theme
Icons from iconoir

## Theme colors
all theme colors are managed with colors.toml in themes
but to applay you have to rebuild the system (for the sddm theme) and execute .config/sccripts/install-icons.sh and restart the system for the cursor theme to apply.


## Credit
this repo contains the folowing (partial and or modified) projects 
iconoir for the icons in config/ignis/icons
sddm theme https://github.com/catppuccin/sddm
gtk3 theme https://github.com/lassekongo83/adw-gtk3
gtk4 theme is libadwaita
icon theme is form https://github.com/cbrnix/Flatery/tree/master
cursor theme is https://github.com/ful1e5/Bibata_Cursor/tree/main
