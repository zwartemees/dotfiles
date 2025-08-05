{ config, pkgs, ... }:
{
  programs.home-manager.enable = true;
   stylix.cursor.package = pkgs.simp1e-cursors;
    stylix.autoEnable = true;
    stylix.polarity = "dark";
    stylix.targets.gtk.enable = true;
    stylix.enable = true;
    stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    stylix.targets.firefox.enable = true;
}
